library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity GP_RegisterBank is
    Port ( clk_12, clk_24, clk_96 : in STD_LOGIC;
           bus_addr : in STD_LOGIC_VECTOR (7 downto 0);
           bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
           enable, write_enable : in STD_LOGIC;
           bus_data_out : out STD_LOGIC_VECTOR (15 downto 0));
           
end GP_RegisterBank;

architecture Behavioral of GP_RegisterBank is
	component GPREG is
		port (
			addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
			clk : in STD_LOGIC;
			d_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
			d_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
			enable : in STD_LOGIC;
			w_enable : in STD_LOGIC
		);
	end component;
	signal d_in, d_out: STD_LOGIC_VECTOR(15 downto 0) := X"0000";
	signal address : STD_LOGIC_VECTOR(7 downto 0) := X"00";
	
begin
	Reg : GPREG port map(addr => address, clk => not clk_96, 
		d_in => d_in, d_out => d_out, enable => enable, 
		w_enable => write_enable
	);
		
	process(clk_12)
	begin
		if falling_edge(clk_12) and enable = '1' then
			d_in <= bus_data_in;
			address <= bus_addr;
		end if;
	end process;
	process(clk_24) begin
		if falling_edge(clk_24) and clk_12 = '0' then
			bus_data_out <= d_out;
		end if;
	end process;
end Behavioral;
