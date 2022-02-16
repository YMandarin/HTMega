library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

---------------- UART transmitter --------------------
-- UART protocol: 1 low start bit - 8 data bits - 1 parity bit - 2 high stop bits
-- max speed: 12 MBaud/s -> max data rate: 1 MByte/s

entity UART_Transmitter is
    Port ( uart_out : out STD_LOGIC := '1';
           is_sending : out STD_LOGIC;
           clk, active, start_sending, parity_type : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR(7 downto 0)
           );
end UART_Transmitter;

architecture Behavioral of UART_Transmitter is
signal sending : boolean := false;
signal FIFO : std_logic_vector(7 downto 0);
signal parity : std_logic := '0';
signal counter : unsigned(3 downto 0) := "0000";
signal start_fl : std_logic;
begin
    is_sending <= '1' when sending else '0';
    process(clk)
    begin
        if rising_edge(clk) and active = '1' then
            if sending then
                if counter = 8 then
                    uart_out <= parity;
                    counter <= counter +1;
                elsif counter = 9 then
                    uart_out <= '1';
                    counter <= counter +1;
                elsif counter = 10 then
                    counter <= "0000";
                    sending <= false;
                else
                    uart_out <= FIFO(0);
                    parity <= parity xor FIFO(0);
                    for i in 0 to 6 loop
                        FIFO(i) <= FIFO(i+1);
                    end loop;
                    counter <= counter +1;
                end if;
            elsif start_sending = '1' and start_fl = '0' then
                parity <= '0';
                FIFO <= data;
                sending <= true;
                uart_out <= '0';
            end if;
            start_fl <= start_sending;
        end if;
    end process;

end Behavioral;