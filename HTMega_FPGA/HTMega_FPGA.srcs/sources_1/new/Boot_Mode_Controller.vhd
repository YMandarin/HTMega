library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Boot_Mode_Controller is
    Port ( 
		clk_6 : in STD_LOGIC;
		Button : in STD_LOGIC;
		Boot_Mode : out STD_LOGIC;
		Program_reset : out STD_LOGIC;
		BootLoader_finished : in STD_LOGIC;
		Program_stopped : in STD_LOGIC
	);
end Boot_Mode_Controller;

architecture Behavioral of Boot_Mode_Controller is
signal boot_mode_buffer : std_logic := '1';
signal button_fl : std_logic := '0';
signal button_hold : std_logic := '0';
constant button_hold_time_6Mhz : integer := 12000000;
signal button_hold_counter, counter_buffer : integer range 0 to button_hold_time_6Mhz := 0;

begin
Boot_Mode <= boot_mode_buffer;
Program_reset <= boot_mode_buffer or button_hold; 

process(clk_6) begin
if falling_edge(clk_6) then
    if button_fl = '0' and button = '1' then
		if boot_mode_buffer = '1' then
			boot_mode_buffer <= '0';
		else
			button_hold <= '1';
		end if;
	end if;
	if button_hold = '1'then
		if button = '0' then
			button_hold <= '0';
			button_hold_counter <= 0;
		else
			if button_hold_counter = (button_hold_time_6Mhz - 1) then
				button_hold_counter <= 0;
				button_hold <= '0';
				boot_mode_buffer <= '1';
			else
				button_hold_counter <= counter_buffer;
			end if;
		end if;
	end if;
	if Program_stopped = '1' then
		boot_mode_buffer <= '1';
	end if;
	if BootLoader_finished = '1' then
		boot_mode_buffer <= '0';
	end if;
	button_fl <= button;
end if;
if falling_edge(clk_6) then
    counter_buffer <= counter_buffer + 1;
end if;
end process;
end Behavioral;
