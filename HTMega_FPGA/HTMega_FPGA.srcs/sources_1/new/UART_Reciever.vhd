library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

----------------- UART receiver --------------------
-- UART protocol: 1 low start bit - 8 data bits - 1 parity bit - 2 high stop bits
-- max speed: 12 MBaud/s -> max data rate: 1 MByte/s

entity UART_Reciever is
    Port ( clk, active, uart_in, reset_buffer, parity_type: in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (7 downto 0) := X"00";
           is_receiving, finished_receiving, wrong_parity : out STD_LOGIC := '0'
           );
end UART_Reciever;

architecture Behavioral of UART_Reciever is
signal receiving : boolean := false;
signal FIFO : std_logic_vector(7 downto 0);
signal counter : unsigned(3 downto 0) := "0000";
signal parity, finished : std_logic := '0';
begin
    is_receiving <= '1' when receiving else '0';
    finished_receiving <= finished;
    process(clk)
    begin
        if rising_edge(clk) then
            if receiving then
                if counter = 8 then
                    wrong_parity <= parity xor uart_in;
                    counter <= counter + 1;
                elsif counter = 9 then
                    receiving <= false;
                    finished <= '1';
                    counter <= "0000";
                    data <= FIFO;
                    
                else
                    for i in 0 to 6 loop
                        FIFO(i) <= FIFO(i+1);
                    end loop;
                    FIFO(07) <= uart_in;
                    parity <= parity xor uart_in;
                    counter <= counter + 1;
                end if;
            elsif active = '1' and uart_in = '0' and not receiving then
                receiving <= true;
                parity <= parity_type;
            end if;
            if reset_buffer = '1' and finished = '1' then
                finished <= '0';
                wrong_parity <= '0';
                data <= X"00";
            end if;
        end if;
    end process;

end Behavioral;
