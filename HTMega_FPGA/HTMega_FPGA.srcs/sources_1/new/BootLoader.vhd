library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;

library work;
use work.Constants.ALL;

entity BootLoader is
    Port ( 
    	clk_6, clk_locked, active : in STD_LOGIC;
    	Finished : out STD_LOGIC := '0';
    	PM_Addr_out : out STD_LOGIC_VECTOR (16 downto 0) := (others => '0');
    	PM_Data_out : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
		PM_write : out STD_LOGIC := '0';
		Is_sending, UART_out : out STD_LOGIC := '0';
		UART_in : in STD_LOGIC
	);
end BootLoader;

    architecture Behavioral of BootLoader is
component UART_Reciever is
    Port ( clk, active, uart_in, reset_buffer, parity_type: in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (7 downto 0) := X"00";
           is_receiving, finished_receiving, wrong_parity : out STD_LOGIC := '0'
           );
end component;
component UART_Transmitter is
    Port ( uart_out : out STD_LOGIC := '1';
           is_sending : out STD_LOGIC;
           clk, active, start_sending, parity_type : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR(7 downto 0)
           );
end component;

signal rec_data : std_logic_vector(7 downto 0);
signal pm_addr : unsigned(16 downto 0) := (others => '1');
signal active_buffer, received,  wrong_parity, start_sending, transmitting, is_second : std_logic := '0';
signal transmission_end_counter : unsigned(2 downto 0) := "000";
begin
Receiver : UART_Reciever port map(
	clk => not clk_6 and clk_locked, uart_in => UART_in, active => active_buffer, 
	reset_buffer => '1', parity_type => '0', 
	data => rec_data, is_receiving => open,
	finished_receiving => received, wrong_parity => wrong_parity
);

Transmitter : UART_Transmitter port map(
	clk => not clk_6, uart_out => UART_out,
	is_sending => Is_sending, active => active_buffer,
	start_sending => start_sending, parity_type => '0',
	data => TRANSMISSION_ERROR
);
PM_Addr_out <= std_logic_vector(pm_addr);

process(clk_6) begin
	if rising_edge(clk_6) and clk_locked = '1' then
		PM_write <= '0';
		Finished <= '0';
		start_sending <= wrong_parity;
		if wrong_parity = '1' then
			transmitting <= '0';
		elsif received = '1' then
			if transmitting = '0' and rec_data = TRANSMISSION_BEGIN then
				pm_addr <= X"FFFF"&'1';
				transmitting <= '1';
				is_second <= '0';
			elsif transmitting = '1' then
				
				if rec_data = TRANSMISSION_END then
					if transmission_end_counter = 5 then
						transmission_end_counter <= "000";
						Finished <= '1';
						transmitting <= '0';
					else
						transmission_end_counter <= transmission_end_counter + 1;
					end if;
				else 
				    transmission_end_counter <= "000";
                end if;        
				if is_second = '0' then
					pm_addr <= pm_addr + 1;
					PM_Data_out(7 downto 0) <= rec_data;
				else
					PM_Data_out(15 downto 8) <= rec_data;
					PM_write <= '1';
				end if;
				is_second <= not is_second;
			end if;

		end if;
		active_buffer <= active;
	end if;	
end process;
end Behavioral;
