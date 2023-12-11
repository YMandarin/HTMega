----------------------------------------------------------------------------------
-- IO_in_X: reg to read the GPIO state from
-- IO_out_X: reg to write to, to set the GPIO state
-- IO_config_X: reg to write to, to set if GPIO is output
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.Constants.ALL;

entity GPIO_Interface is
    Port ( 
    	clk_6 : in STD_LOGIC;
		bus_addr : in STD_LOGIC_VECTOR (7 downto 0);
		bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
		bus_data_out : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
		bus_enable, write_enable : in STD_LOGIC;
		port_Timer_A, port_Timer_B: in STD_LOGIC;
		Pin_GPIO: inout STD_LOGIC_VECTOR (45 downto 0);
		Pin_LED: out STD_LOGIC_VECTOR(3 downto 0);
		Pin_button: in STD_LOGIC;
		Pin_PMOD : inout STD_LOGIC_VECTOR(7 downto 0)
		);
end GPIO_Interface;

architecture Behavioral of GPIO_Interface is

signal IO_in_A, IO_in_B, IO_in_C, IO_out_A, IO_out_B, IO_out_C, 
	IO_config_A, IO_config_B, IO_config_C, IO_out_Board, IO_config_Board, IO_in_Board : std_logic_vector(15 downto 0) := X"0000";

begin

	Pin_GPIO(0) <= IO_out_A(0) when IO_config_A(0) = '1' else port_Timer_A; 
	IO_A: for i in 1 to 15 generate
		Pin_GPIO(i) <= IO_out_A(i) when IO_config_A(i) = '1' else 'Z';
	end generate IO_A;
	
	IO_B: for i in 0 to 15 generate
		Pin_GPIO(i+16) <= IO_out_B(i) when IO_config_B(i) = '1' else 'Z';
	end generate IO_B;
	IO_C: for i in 0 to 12 generate
		Pin_GPIO(i+32) <= IO_out_C(i) when IO_config_C(i) = '1' else 'Z';
	end generate IO_C;
    Pin_GPIO(45) <= IO_out_B(13) when IO_config_B(13) = '1' else port_Timer_B;

	
	IO_PMOD : for i in 0 to 7 generate 
		Pin_PMOD(i) <= IO_out_Board(i) when IO_config_Board(i) = '1' else 'Z';
	end generate IO_PMOD;
	
	IO_in_A <= Pin_GPIO(15 downto 0);
	IO_in_B <= Pin_GPIO(31 downto 16);
	IO_in_C(11 downto 0) <= Pin_GPIO(43 downto 32);
	IO_in_Board(7 downto 0) <= Pin_PMOD;
	IO_in_Board(8) <= Pin_button;
	IO_in_Board(12 downto 9) <= IO_out_Board(12 downto 9);
	Pin_LED <= IO_out_Board (12 downto 9);
	
	process(clk_6) begin
	if falling_edge(clk_6) and bus_enable='1' then
		case bus_addr is
			when AD_PA_IN =>
				bus_data_out <= IO_in_A;
			when AD_PB_IN =>
				bus_data_out <= IO_in_B;
			when AD_PC_IN =>
				bus_data_out <= IO_in_C;
			when AD_PA_CONF =>
				bus_data_out <= IO_config_A;
				if write_enable = '1' then
					IO_config_A <= bus_data_in;
				end if;
			when AD_PB_CONF =>
				bus_data_out <= IO_config_B;
				if write_enable = '1' then
					IO_config_B <= bus_data_in;
				end if;
			when AD_PC_CONF =>
				bus_data_out <= IO_config_C;
				if write_enable = '1' then
					IO_config_C <= bus_data_in;
				end if;
			when AD_PA_OUT =>
				bus_data_out <= IO_out_A;
				if write_enable = '1' then
					IO_out_A <= bus_data_in;
				end if;
			when AD_PB_OUT =>
				bus_data_out <= IO_out_B;
				if write_enable = '1' then
					IO_out_B <= bus_data_in;
				end if;
			when AD_PC_OUT =>
				bus_data_out <= IO_out_C;
				if write_enable = '1' then
					IO_out_C <= bus_data_in;
				end if;
			when AD_PD_OUT =>
				bus_data_out <= IO_out_Board;
				if write_enable = '1' then
					IO_out_Board<= bus_data_in;
				end if;
			when AD_PD_IN => 
				bus_data_out <= IO_in_Board;
			when AD_PD_CONF =>
				bus_data_out <= IO_config_Board;
				if write_enable = '1' then
					IO_config_Board <= bus_data_in;
				end if;
			when others => 
		end case;
	end if;
	end process;
end Behavioral;
