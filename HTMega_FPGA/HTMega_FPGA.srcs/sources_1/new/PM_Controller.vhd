library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;

entity PM_Controller is
	Port (
		clk_12, clk_24, clk_48 : in STD_LOGIC;
		Write, Read, Program_Read, Boot_Write: in STD_LOGIC;
		Addr_space : in STD_LOGIC;
		Write_Addr, Read_Addr, Program_Counter : in STD_LOGIC_VECTOR(15 downto 0);
		Boot_Write_Addr : in STD_LOGIC_VECTOR(16 downto 0);
		Data_in, Boot_Data_in : in STD_LOGIC_VECTOR(15 downto 0);
		Data_out_1, Data_out_2 : out STD_LOGIC_VECTOR(15 downto 0) := X"0000"
	);
end PM_Controller;

architecture Behavioral of PM_Controller is

component Program_BRAM IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;

signal BRAM_addr : std_logic_vector(16 downto 0) := (others => '0');
signal BRAM_data_out : std_logic_vector(15 downto 0) := X"0000";
signal BRAM_write : std_logic_vector(0 downto 0);

signal clk_12_buffer, clk_24_buffer, read_buffer, write_buffer, program_read_buffer, boot_write_buffer : std_logic := '0';
signal PC_buffer, boot_data_in_buffer, data_in_buffer: std_logic_vector(15 downto 0) := X"0000";
signal PC_buffer_added, boot_write_addr_buffer: std_logic_vector(16 downto 0) := (others => '0');
signal write_addr_buffer, read_addr_buffer, BRAM_data_in  : std_logic_vector(15 downto 0) := X"0000";
signal sel: std_logic_vector (3 downto 0);
begin

sel(0) <= write_buffer;
sel(1) <= read_buffer;
sel(2) <= program_read_buffer;
sel(3) <= boot_write_buffer;

PC_buffer_added <= PC_buffer&clk_12;
BRAM_write <= ""&((write_buffer or boot_write_buffer) and not clk_12);

BRAM_data_in <= boot_data_in_buffer when boot_write_buffer = '1' else data_in_buffer;
Data_out_1 <= BRAM_data_out;

with sel select BRAM_addr <=
	Addr_space & Write_Addr when "0001",
	Addr_space & Read_Addr when "0010",
	PC_buffer_added when "0100",
	boot_write_addr_buffer when "1000",
	X"0000"&'0' when others;
	
PM : Program_BRAM port map(
		clka => not clk_48, 
		wea => BRAM_write,
		addra => BRAM_addr,
		dina => BRAM_data_in,
		douta => BRAM_data_out
	);

process(clk_12) begin
	if falling_edge(clk_24) and clk_12 = '1' then 
		write_buffer <= Write;
		read_buffer <= Read;
		program_read_buffer <= Program_Read;
		boot_write_buffer <= Boot_Write;
		
		write_addr_buffer <= Write_Addr;
		read_addr_buffer <= Read_Addr;
		boot_write_addr_buffer <= Boot_Write_Addr;
		PC_buffer <= Program_Counter;
		
		boot_data_in_buffer <= Boot_Data_in;
		data_in_buffer <= Data_in;
	end if;
		
	if falling_edge(clk_24) and clk_12 = '0' then
		Data_out_2 <= BRAM_data_out;
	end if;
	
end process;
end Behavioral;
