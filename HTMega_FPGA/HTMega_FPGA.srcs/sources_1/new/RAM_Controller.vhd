-- this is a 12 MHz wrapper of the 24 MHz RAM Controller

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_Controller is
    Port (
    	clk_12, clk_24, clk_48 : in std_logic; 
        write, read : in std_logic;
        Write_Address, Read_Address : in std_logic_vector(15 downto 0);
        Addr_space : in std_logic;
        Data_in : in std_logic_vector(15 downto 0);
        Data_out : out std_logic_vector(15 downto 0) := X"0000";
        
        RAM_Address : out std_logic_vector(17 downto 0) := (others => '0');
        Ram_Data : inout std_logic_vector(7 downto 0);
        Ram_ce, ram_oe, ram_we : out std_logic := '1'
    );
end RAM_Controller;

architecture Behavioral of RAM_Controller is
component RAM_Controller_24MHz is
    Port (
        address : in std_logic_vector(16 downto 0) := X"0000"&"0";
        data_in : in std_logic_vector(15 downto 0) := X"0000";
        data_out : out std_logic_vector(15 downto 0) := X"0000";
        clk_48, clk_24, write, start, enable : in std_logic := '0';
        valid : out std_logic := '0';
        ram_address : out std_logic_vector(17 downto 0) := X"0000"&"00";
        ram_data : inout std_logic_vector(7 downto 0);
        ram_ce, ram_oe, ram_we : out std_logic := '1'
        );
end component;
signal start_buffer, addr_space_buffer: std_logic := '0';
signal enable : std_logic := '0';
signal address : std_logic_vector(15 downto 0) := X"0000";
begin

	enable <= write or read;
	address <= Write_Address when write = '1' else Read_Address;
	
    Controller : RAM_Controller_24MHz port map(
    	address => addr_space_buffer & address,
    	data_in => Data_in,
    	data_out => Data_out,
    	clk_48 => clk_48, clk_24 => clk_24,
    	write => write, start => start_buffer,
    	enable => enable, valid => open,
    	ram_address => RAM_address(17 downto 0), ram_data => RAM_data, 
    	ram_ce => RAM_ce, ram_oe => RAM_oe, ram_we => RAM_we
    );
    
process(clk_24) begin
	if falling_edge(clk_24) and clk_12 = '1' then 
		addr_space_buffer <= Addr_space;
		start_buffer <= clk_12 and enable; 
	end if;
end process;
    
end Behavioral;
