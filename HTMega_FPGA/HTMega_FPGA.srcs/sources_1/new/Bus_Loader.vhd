----------------------------------------------------------------------------------

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Bus_Loader is
    Port ( clk_6 : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Start : in STD_LOGIC;
           LoadSecond : in STD_LOGIC;
           Addr1, Addr2 : in STD_LOGIC_VECTOR (7 downto 0);
           Finished : out STD_LOGIC := '0';
           Data_out_1, Data_out_2 : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
       	   
       	   Bus_enable : out STD_LOGIC := '0';
           Bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
           Bus_addr_out : out STD_LOGIC_VECTOR (7 downto 0) := X"00"
           );
end Bus_Loader;

architecture Behavioral of Bus_Loader is
signal address_1, address_2 : std_logic_vector(7 downto 0) := X"00";
signal data_cache : std_logic_vector (15 downto 0) := X"0000";
signal load_second, second, fin : std_logic := '0';
begin

Data_out_1 <= data_cache when load_second = '1' else Bus_data_in;
Data_out_2 <= Bus_data_in when load_second = '1' else X"0000";
Bus_addr_out <= address_1 when second = '0' else address_2;

process(clk_6) begin
if rising_edge(clk_6) and enable = '1' then
	if fin = '1' and Start = '0' then
		Bus_enable <= '0';
		second <= '0';
		fin <= '0';
	else
		if second = '0' and Start = '1'then
			Bus_enable <= '1';
			load_second <= loadSecond;
			address_1 <= Addr1;
			address_2 <= Addr2;
			if LoadSecond = '1' then
				second <= '1';
			else
				fin <= '1';
			end if;
		elsif second = '1' then
			data_cache <= Bus_data_in;
			fin <= '1';
			second <= '0';
		end if;
	end if; 
	
end if;
if falling_edge(clk_6) then
	finished <= fin;
end if;
end process;
end Behavioral;
