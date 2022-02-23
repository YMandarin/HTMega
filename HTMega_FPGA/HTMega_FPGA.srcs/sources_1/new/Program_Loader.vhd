library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Loader is
    Port (
    	clk_6 : in STD_LOGIC; 
    	Start : in STD_LOGIC;
    	Reset : in STD_LOGIC;
    	Finished : out STD_LOGIC;
		PM_read : out STD_LOGIC
	);
end Program_Loader;
architecture Behavioral of Program_Loader is
signal start_buffer, reset_fl, running : std_logic := '0';

begin
PM_read <= start_buffer;

process(clk_6) begin
	if rising_edge(clk_6) then
		if reset_fl = '1' and reset = '0' then
		    start_buffer <= '1';
		elsif reset = '0' then
            start_buffer <= Start;
        end if;
        reset_fl <= reset;
	end if;
	if falling_edge(clk_6) then
		Finished <= start_buffer;
	end if;
end process;

end Behavioral;
