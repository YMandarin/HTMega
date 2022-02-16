----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.Constants.ALL;

entity Timers is
    Port ( clk_12 : in STD_LOGIC;
    	   bus_addr_in : in STD_LOGIC_VECTOR (7 downto 0);
           bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
           bus_data_out : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
           bus_enable, bus_write_enable : in STD_LOGIC;
           port_timer_A, port_timer_B: out STD_LOGIC := 'Z'
           );
end Timers;

architecture Behavioral of Timers is
signal Timer_A_Value, Timer_B_Value, Timer_A_Top, Timer_B_Top, 
	Micros_High, Micros_Low, Timer_A_Compare, 
	Timer_B_Compare : std_logic_vector (15 downto 0) := X"0000";
	
signal Timer_A_Config, Timer_B_Config : std_logic_vector(7 downto 0) := X"00";
signal Timer_A_Status, Timer_B_Status : std_logic_vector(1 downto 0) := "00";

signal Timer_A_reset, Timer_B_reset, Micros_reset : std_logic := '0';

component MicrosCounter is
    Port ( clk_12 : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Timer_16bit is
	Port (
		clk_12 : in std_logic;
		value_out : out std_logic_vector(15 downto 0) ;
		compare_value, top : in std_logic_vector (15 downto 0);
		enabled, en_comparison, en_pwm, reset : in std_logic;
		out_comparison, out_overflow, out_port : out std_logic := '0';
		port_config : in std_logic_vector(1 downto 0);
		prescaler : in std_logic_vector(2 downto 0)
);
end component;

begin
Timer_A : Timer_16bit port map(clk_12, Timer_A_Value, 
	Timer_A_Compare, Timer_A_Top, Timer_A_Config(0),Timer_A_Config(1), 
	Timer_A_Config(2), Timer_A_reset, Timer_A_Status(0), Timer_A_Status(1),
	port_timer_A,Timer_A_Config(4 downto 3), Timer_A_Config(7 downto 5));

Timer_B : Timer_16bit port map(clk_12, Timer_B_Value, 
	Timer_B_Compare, Timer_B_Top, Timer_B_Config(0),Timer_B_Config(1), 
	Timer_B_Config(2), Timer_B_reset, Timer_B_Status(0), Timer_B_Status(1),
	out_port => port_timer_B, 
	port_config => Timer_B_Config(4 downto 3), 
	prescaler=>Timer_B_Config(7 downto 5));

Timer_Micros : MicrosCounter port map(clk_12, Micros_reset, 
	data_out(15 downto 0) => Micros_Low, 
	data_out(31 downto 16) => Micros_High);

process(clk_12) begin
	if falling_edge(clk_12) and bus_enable = '1' then
		Timer_A_reset <= '0';
		Timer_B_reset <= '0';
		Micros_reset <= '0';

		case bus_addr_in is
			when AD_TIMA_VAL =>
				bus_data_out <= Timer_A_Value;
				if bus_write_enable = '1' then
					Timer_A_reset <= '1';
				end if;
			when AD_TIMB_VAL =>
				bus_data_out <= Timer_B_Value;
				if bus_write_enable = '1' then
					Timer_B_reset <= '1';
				end if;
			when AD_TIMA_TOP =>
				bus_data_out <= Timer_A_Top;
				if bus_write_enable = '1' then
					Timer_A_Top <= bus_data_in;
					Timer_A_reset <= '1';
				end if;
			when AD_TIMB_TOP =>
				bus_data_out <= Timer_B_Top;
				if bus_write_enable = '1' then
					Timer_B_Top <= bus_data_in;
					Timer_B_reset <= '1';
				end if;
			when AD_TIMA_COMP =>
				bus_data_out <= Timer_A_Compare;
				if bus_write_enable = '1' then
					Timer_A_Compare <= bus_data_in;
				end if;
			when AD_TIMB_COMP =>
				bus_data_out <= Timer_B_Compare;
				if bus_write_enable = '1' then
					Timer_B_Compare <= bus_data_in;
				end if;
			when AD_TIMA_CONF =>
				bus_data_out <= "000000" & Timer_A_Status & Timer_A_Config; 
				if bus_write_enable = '1' then
					Timer_A_Config <= bus_data_in(7 downto 0);
					Timer_A_reset <= '1';
				end if;
			when AD_TIMB_CONF =>
				bus_data_out <= "000000" & Timer_B_Status & Timer_B_Config; 
				if bus_write_enable = '1' then
					Timer_B_Config <= bus_data_in(7 downto 0);
					Timer_B_reset <= '1';
				end if;
			when AD_MICR_L =>
				bus_data_out <= Micros_Low; 
				if bus_write_enable = '1' then
					Micros_reset <= '1';
				end if;
			when AD_MICR_H =>
				bus_data_out <= Micros_HIGH; 
				if bus_write_enable = '1' then
					Micros_reset <= '1';
				end if;
			when others =>
		end case;		
	end if;
end process;
end Behavioral;
