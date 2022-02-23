----------------------------------------------------------------------------------

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Memory_Writer is
    Port ( 
    	clk_6 : in STD_LOGIC;
    	Start_execution : in STD_LOGIC;
    	Finished : out STD_LOGIC := '0';
    	Data_in : in STD_LOGIC_VECTOR(15 downto 0);
    	Bus_write, RAM_write, PM_write : in STD_LOGIC;
    	Bus_Addr_in : in STD_LOGIC_VECTOR(7 downto 0);
    	RAM_Addr_in, PM_Addr_in : in STD_LOGIC_VECTOR (15 downto 0);
    	
    	Bus_enable : out STD_LOGIC := '0';
    	Bus_Addr_out : out STD_LOGIC_VECTOR(7 downto 0);
    	Bus_Data_out : out STD_LOGIC_VECTOR(15 downto 0);
    	
    	RAM_enable : out STD_LOGIC := '0';
    	RAM_Addr_out : out STD_LOGIC_VECTOR(15 downto 0);
    	RAM_Data_out : out STD_LOGIC_VECTOR(15 downto 0);
    	
    	PM_enable : out STD_LOGIC := '0';
    	PM_Addr_out : out STD_LOGIC_VECTOR(15 downto 0);
    	PM_Data_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end Memory_Writer;

architecture Behavioral of Memory_Writer is

	signal enabled, start_buffer, Bus_write_buffer, 
	RAM_write_buffer, PM_write_buffer, fin : std_logic := '0'; 
signal Data_buffer, PM_addr_buffer, RAM_addr_buffer : std_logic_vector(15 downto 0) := X"0000";
signal Bus_addr_bufffer : std_logic_vector(7 downto 0) := X"00";

begin
enabled <= Bus_write or RAM_write or PM_write;

Bus_Data_out <= Data_buffer when Bus_write_buffer = '1' else X"0000";
Bus_Addr_out <= Bus_addr_bufffer when Bus_write_buffer = '1' else X"00";

RAM_Data_out <= Data_buffer when RAM_write_buffer = '1' else X"0000";
RAM_Addr_out <= RAM_addr_buffer when RAM_write_buffer = '1' else X"0000";

PM_Data_out <= Data_buffer when PM_write_buffer = '1' else X"0000";
PM_Addr_out <= PM_addr_buffer when PM_write_buffer = '1' else X"0000";

Bus_enable <= start_buffer and Bus_write_buffer;
RAM_enable <= start_buffer and RAM_write_buffer;
PM_enable <= start_buffer and PM_write_buffer;

Finished <= fin when enabled = '1' else Start_execution;

process(clk_6) begin
	if rising_edge(clk_6) then
		start_buffer <= enabled and Start_execution;
		Data_buffer <= Data_in;
		Bus_write_buffer <= Bus_write;
		RAM_write_buffer <= RAM_write;
		PM_write_buffer  <= PM_write;
		Bus_addr_bufffer <= Bus_Addr_in;
		RAM_addr_buffer <= RAM_Addr_in;
		PM_addr_buffer <= PM_Addr_in;
		Data_buffer <= Data_in;
	end if;
	if falling_edge(clk_6) then
		fin <= start_buffer;
	end if;
end process;
end Behavioral;
