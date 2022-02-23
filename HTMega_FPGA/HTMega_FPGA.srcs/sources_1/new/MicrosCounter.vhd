library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MicrosCounter is
    Port ( clk_6 : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end MicrosCounter;

architecture Behavioral of MicrosCounter is
signal prescaler : unsigned(2 downto 0) := "000";
signal data : unsigned(31 downto 0) := X"00000000";
begin
	data_out <= std_logic_vector(data);
	process(clk_6) begin
	if rising_edge(clk_6) then
		if prescaler >= X"5" then
			prescaler <= "000";
			data <= data + 1;
		else 
			prescaler <= prescaler + 1;
		end if;
	end if;
	end process;
end Behavioral;
