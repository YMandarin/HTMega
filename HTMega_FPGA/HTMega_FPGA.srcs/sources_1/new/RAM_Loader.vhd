----------------------------------------------------------------------------------
 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_Loader is
	Port (
		clk_6, enable, start : in STD_LOGIC;
		Address : in STD_LOGIC_VECTOR (15 downto 0);
		Data_out : out STD_LOGIC_VECTOR (15 downto 0);
		finished : out STD_LOGIC := '0';
		
		RAM_Address : out STD_LOGIC_VECTOR (15 downto 0);
		RAM_Data_in : in STD_LOGIC_VECTOR (15 downto 0);
		RAM_enable : out STD_LOGIC := '0'
	);
end RAM_Loader;
architecture Behavioral of RAM_Loader is
signal start_buffer : std_logic := '0';
signal addr_buffer : std_logic_vector(15 downto 0) := X"0000";

begin
Data_out <= RAM_Data_in;
RAM_Address <= addr_buffer;
RAM_enable <= start_buffer;
process(clk_6) begin
	if rising_edge(clk_6) then
		start_buffer <= start and enable;
		addr_buffer <= Address;
	end if;
	if falling_edge(clk_6) then
		finished <= start_buffer;
	end if;
end process;

end Behavioral;
