library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Loader is
    Port (
    	clk_12 : in STD_LOGIC; 
    	Start : in STD_LOGIC;
    	Finished : out STD_LOGIC;
		PM_read : out STD_LOGIC
	);
end Program_Loader;
architecture Behavioral of Program_Loader is
signal start_buffer : std_logic := '0';

begin
PM_read <= start_buffer;


process(clk_12) begin
	if rising_edge(clk_12) then
		start_buffer <= Start;
		
	end if;
	if falling_edge(clk_12) then
		Finished <= start_buffer;
		
	end if;
end process;

end Behavioral;
