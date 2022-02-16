------------------------------------------------------------------------------------ 
-- Create Date: 31.01.2022 15:38:23
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Memory_Loader is
	Port (
		clk_12 : in STD_LOGIC;
		Start_execution : in STD_LOGIC;
		Bus_load, Bus_load_second, RAM_load, PM_load, Use_Imdt : in STD_LOGIC;
		Finished : out STD_LOGIC := '0';
		Address_ram, Address_pm, Immediate : in STD_LOGIC_VECTOR(15 downto 0); 
		Address_bus_1, Address_bus_2 : in STD_LOGIC_VECTOR(7 downto 0);
		Data_out_1, Data_out_2 : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
		
		Bus_enable : out STD_LOGIC := '0';
		Bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
		Bus_addr_out : out STD_LOGIC_VECTOR (7 downto 0) := X"00";
		
		RAM_enable : out STD_LOGIC := '0';
		RAM_data_in : in STD_LOGIC_VECTOR (15 downto 0);
		RAM_addr_out : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
		
		PM_enable : out STD_LOGIC := '0';
		PM_data_in : in STD_LOGIC_VECTOR (15 downto 0);
		PM_addr_out : out STD_LOGIC_VECTOR (15 downto 0) := X"0000"
	);
end Memory_Loader;

architecture Behavioral of Memory_Loader is
component Bus_Loader is
    Port ( clk_12 : in STD_LOGIC;
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
end component;
component RAM_Loader is
	Port (
		clk_12, enable, start : in STD_LOGIC;
		Address : in STD_LOGIC_VECTOR (15 downto 0);
		Data_out : out STD_LOGIC_VECTOR (15 downto 0);
		finished : out STD_LOGIC := '0';
		
		RAM_Address : out STD_LOGIC_VECTOR (15 downto 0);
		RAM_Data_in : in STD_LOGIC_VECTOR (15 downto 0);
		RAM_enable : out STD_LOGIC := '0'
	);
end component;

signal enabled : std_logic;
signal bus_loader_start, ram_loader_start, pm_loader_start, 
	bus_loader_fin, ram_loader_fin, pm_loader_fin, fin : std_logic := '0';
signal bus_loader_data_1, bus_loader_data_2, 
	ram_loader_data, pm_loader_data : std_logic_vector(15 downto 0) := X"0000";
signal sel : std_logic_vector(2 downto 0);
begin
	sel(0) <= PM_load;
	sel(1) <= RAM_load;
	sel(2) <= Bus_load;
	
	enabled <= Bus_load or RAM_load or PM_load;
	with sel select Data_out_1 <= 
		bus_loader_data_1 when "100",
		ram_loader_data when "010",
		pm_loader_data when "001",
		Immediate when others;
	
	Data_out_2 <= Immediate when enabled = '1' and Use_Imdt = '1' else bus_loader_data_2;
	bus_loader_start <= Bus_load and Start_execution;
	ram_loader_start <= RAM_load and Start_execution;
	pm_loader_start <= PM_load and Start_execution;
	
	fin <= (Bus_load and bus_loader_fin)
		or (RAM_load and ram_loader_fin)
		or (PM_load and pm_loader_fin);
		
	Finished <= fin when enabled ='1' else Start_execution; 
		
		
	Bus_Loader_inst : Bus_Loader port map(
		clk_12 => clk_12, Enable => Bus_load,
		Start => bus_loader_start, LoadSecond => Bus_load_second,
		Addr1 => Address_bus_1, Addr2 => Address_bus_2,
		Finished => bus_loader_fin,
		Data_out_1 => bus_loader_data_1, Data_out_2 => bus_loader_data_2,
		
		Bus_enable => Bus_enable,
		Bus_data_in => Bus_data_in,
		Bus_addr_out => Bus_addr_out
	);
	
	RAM_loader_inst : RAM_Loader port map(
		clk_12 => clk_12, enable => RAM_load, start => ram_loader_start,
		Address => Address_ram,
		Data_out => ram_loader_data, finished => ram_loader_fin,
		
		RAM_Address => RAM_addr_out,
		RAM_Data_in => RAM_data_in,
		RAM_enable => RAM_enable
	);
	
	PM_loader_inst : RAM_Loader port map(
		clk_12 => clk_12, enable => PM_load, start => pm_loader_start,
		Address => Address_ram,
		Data_out => pm_loader_data, finished => pm_loader_fin,
		
		RAM_Address => PM_addr_out,
		RAM_Data_in => PM_data_in,
		RAM_enable => PM_enable
	);
end Behavioral;
