library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.Constants.ALL;

entity Main is
    Port ( 
    	sysclk : in STD_LOGIC;
    	RAM_Addr : out STD_LOGIC_VECTOR(18 downto 0);
    	RAM_Data : inout STD_LOGIC_VECTOR(7 downto 0);
    	RAM_OE, RAM_WE, RAM_CE : out STD_LOGIC;
    	GPIO : inout STD_LOGIC_VECTOR (45 downto 0);
		UART_in : in STD_LOGIC;
		UART_out : out STD_LOGIC;
		PMOD : inout STD_LOGIC_VECTOR (7 downto 0);
		LED_out : out STD_LOGIC_VECTOR (1 downto 0);
		RgbLED_out : out STD_LOGIC_VECTOR (2 downto 0);
		Button_in : in STD_LOGIC_VECTOR (1 downto 0));
end Main;

architecture Behavioral of Main is

signal clk_6, clk_12, clk_24, clk_locked : std_logic := '0';
signal start_loader, start_ALU, start_writer, start_program_loader, start_decoder : std_logic := '1';
signal enable_bus_load, enable_ram_load, enable_pm_load, enable_ALU, enable_bus_write, enable_ram_write, enable_pm_write, enable_bus_second : std_logic := '1';
signal addr_ram, addr_pm, program_counter, immediate : std_logic_vector(15 downto 0) := X"0000";
signal addr_bus_load_1, addr_bus_load_2, addr_bus_write : std_logic_vector(7 downto 0) := X"00";

signal zreg_bus_out, sp_bus_out : std_logic_vector(15 downto 0) := X"0000";
signal flags_alu_out, flags_bus_out : std_logic_vector(7 downto 0) := X"00";
signal sp_inc, sp_dec, use_immediate :std_logic := '0'; 

signal ALU_data_in_1, ALU_data_in_2, ALU_data_out_1, ALU_data_out_2 : std_logic_vector(15 downto 0) := X"0000";
signal ALU_sel : std_logic_vector(4 downto 0) := "00000";

signal bus_read_addr, bus_write_addr : std_logic_vector(7 downto 0) := X"00";
signal bus_data_out, bus_data_in : std_logic_vector(15 downto 0) := X"0000";
signal bus_read, bus_write : std_logic := '0';

signal ram_write_addr, ram_read_addr, ram_data_out, ram_data_in : std_logic_vector(15 downto 0) := X"0000";
signal ram_read, ram_write : std_logic := '0';

signal pm_write_addr, pm_read_addr, pm_data_in, pm_boot_data_in : std_logic_vector(15 downto 0) := X"0000";
signal pm_boot_write_addr : std_logic_vector(16 downto 0) := (others => '0');
signal pm_data_1, pm_data_2 : std_logic_vector(15 downto 0) := X"0000";
signal pm_read, pm_write, pm_program_read, pm_boot_write : std_logic := '0';

signal boot_uart_out, tr_uart_out, boot_is_sending : std_logic := '0';
signal boot_mode : std_logic := '1';
signal boot_loader_finished, program_reset, program_stopped : std_logic := '0';

signal RgbLED : std_logic_vector(2 downto 0);


component SysClkWizard is
	port(
		clk_in1 : in STD_LOGIC;
        CLK_6 : out STD_LOGIC;
		CLK_12 : out STD_LOGIC;
		CLK_24 : out STD_LOGIC;
		reset : in STD_LOGIC;
		locked : out STD_LOGIC
	);
end component;

component Instruction_Decoder is
    Port ( 
		clk_6 : in STD_LOGIC;
		Reset : in STD_LOGIC;
		Start_decoder : in STD_LOGIC;

		PM_Data_1_in : in STD_LOGIC_VECTOR (15 downto 0);
		PM_Data_2_in : in STD_LOGIC_VECTOR (15 downto 0);
		
		PC_out : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
		Flags_in : in STD_LOGIC_VECTOR (7 downto 0);
		Zreg_in : in STD_LOGIC_VECTOR (15 downto 0);
		SP_in : in STD_LOGIC_VECTOR (15 downto 0);
		SP_inc, SP_dec : out STD_LOGIC := '0';
		
		Start_execution : out STD_LOGIC := '0';
		Program_stopped : out STD_LOGIC := '0';
		
		Use_imdt : out STD_LOGIC := '0';
		ALU_enable : out STD_LOGIC := '0';
		ALU_sel : out STD_LOGIC_VECTOR (4 downto 0) := "00000";
		Immediate : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
		
		Bus_load, Bus_load_second, Bus_write : out STD_LOGIC := '0';
		Bus_load_addr_1, Bus_load_addr_2, Bus_write_addr : out STD_LOGIC_VECTOR(7 downto 0) := X"00";
		
		RAM_load, RAM_write : out STD_LOGIC := '0';
		RAM_addr : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
		
		PM_load, PM_write : out STD_LOGIC := '0';
		PM_addr : out STD_LOGIC_VECTOR(15 downto 0) := X"0000"
	);
end component;

component ALU_16bit is
    Port (
    	clk_6 : in STD_LOGIC;
    	Enable, Start_Execution : in STD_LOGIC;
		Instr_sel : in STD_LOGIC_VECTOR(4 downto 0);
        X,Y : in STD_LOGIC_VECTOR(15 downto 0);
        Flags_in : STD_LOGIC_VECTOR(7 downto 0);
        Res1,Res2 : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
        Flags_out : out STD_LOGIC_VECTOR(7 downto 0);
        Finished : out STD_LOGIC := '0'
	);
        
end component;

component Program_Loader is
    Port (
    	clk_6 : in STD_LOGIC; 
    	Start : in STD_LOGIC;
    	Reset : in STD_LOGIC;
    	Finished : out STD_LOGIC;
		PM_read : out STD_LOGIC
	);
end component;

component Memory_Loader is
	Port (
		clk_6 : in STD_LOGIC;
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
end component;

component Memory_Writer is
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
end component;

component GP_Bus_Master is
	Port (
		clk_6, clk_12, clk_24 : in std_logic;
		Master_Read_Addr_in, Master_Write_Addr_in : in std_logic_vector(7 downto 0);
		Master_Data_in : in std_logic_vector(15 downto 0);
		Master_Data_out : out std_logic_vector(15 downto 0);
		Master_Bus_read, Master_Bus_write : in std_logic;
		
		Pin_GPIO : inout std_logic_vector (45 downto 0);
		Pin_PMOD : inout std_logic_vector (7 downto 0);
		Pin_UART_out : out std_logic;
		Pin_UART_in : in std_logic;
		Pin_Button_in : in std_logic;
		Pin_LED_out : out std_logic_vector (3 downto 0);
		
		SP_inc, SP_dec : in STD_LOGIC;
		SP_out, Zreg_out : out STD_LOGIC_VECTOR(15 downto 0);
		PC_in: in STD_LOGIC_VECTOR ( 15 downto 0);
		Flags_out : out STD_LOGIC_VECTOR(7 downto 0);
		Flags_in : STD_LOGIC_VECTOR(7 downto 0);
		Breg_in : STD_LOGIC_VECTOR(15 downto 0)
	);
end component;

component RAM_Controller is
    Port (
    	clk_6, clk_12, clk_24 : in std_logic; 
        write, read : in std_logic;
        Write_Address, Read_Address : in std_logic_vector(15 downto 0);
        Addr_space : in std_logic;
        Data_in : in std_logic_vector(15 downto 0);
        Data_out : out std_logic_vector(15 downto 0) := X"0000";
        
        RAM_Address : out std_logic_vector(18 downto 0) := (others => '0');
        RAM_Data : inout std_logic_vector(7 downto 0);
        RAM_CE, RAM_OE, RAM_WE : out std_logic := '1'
    );
end component;

component PM_Controller is
	Port (
		clk_6, clk_12, clk_24 : in STD_LOGIC;
		Write, Read, Program_Read, Boot_Write: in STD_LOGIC;
		Addr_space : in STD_LOGIC;
		Write_Addr, Read_Addr, Program_Counter : in STD_LOGIC_VECTOR(15 downto 0);
		Boot_Write_Addr : in STD_LOGIC_VECTOR(16 downto 0);
		Data_in, Boot_Data_in : in STD_LOGIC_VECTOR(15 downto 0);
		Data_out_1, Data_out_2 : out STD_LOGIC_VECTOR(15 downto 0) := X"0000"
	);
end component;

component BootLoader is
    Port ( 
    	clk_6, clk_locked, active : in STD_LOGIC;
    	Finished : out STD_LOGIC := '0';
    	PM_Addr_out : out STD_LOGIC_VECTOR (16 downto 0) := (others => '0');
    	PM_Data_out : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
		PM_write : out STD_LOGIC := '0';
		Is_sending, UART_out : out STD_LOGIC := '0';
		UART_in : in STD_LOGIC
	);
end component;

component Boot_Mode_Controller is
    Port ( 
		clk_6 : in STD_LOGIC;
		Button : in STD_LOGIC;
		Boot_Mode : out STD_LOGIC;
		Program_reset : out STD_LOGIC;
		BootLoader_finished : in STD_LOGIC;
		Program_stopped : in STD_LOGIC
	);
end component;

begin

	Clock : SysClkWizard port map(
		clk_in1 => sysclk, CLK_6 => clk_6,
		CLK_12 => clk_12, CLK_24 => clk_24, 
		reset => '0', locked => clk_locked
	);

	Decoder : Instruction_Decoder port map(
		clk_6 => clk_6, Reset => program_reset, Start_decoder => start_decoder, 
		Start_execution => start_loader,
		Program_stopped => program_stopped,
		PM_Data_1_in => pm_data_1, PM_Data_2_in => pm_data_2,
		PC_out => program_counter, Flags_in => flags_bus_out, Zreg_in => zreg_bus_out,

		SP_in => sp_bus_out, SP_inc => sp_inc, SP_dec => sp_dec, 

		Use_imdt => use_immediate, ALU_enable => enable_ALU, ALU_sel => ALU_sel,
		Immediate => immediate, 

		Bus_load => enable_bus_load, Bus_load_second => enable_bus_second, Bus_write => enable_bus_write,
		Bus_load_addr_1 => addr_bus_load_1, Bus_load_addr_2 => addr_bus_load_2, Bus_write_addr => addr_bus_write,

		RAM_load => enable_ram_load, RAM_write => enable_ram_write,
		RAM_addr => addr_ram,

		PM_load => enable_pm_load, PM_write => enable_pm_write,
		PM_addr => addr_pm
	);
	
	ALU : ALU_16bit port map(
		clk_6 => clk_6, 
		Enable => enable_ALU, Start_Execution => start_ALU, 
		Instr_sel => ALU_sel, 
		X => ALU_data_in_1, Y => ALU_data_in_2,
		Flags_in => flags_bus_out,
		Res1 => ALU_data_out_1, Res2 => ALU_data_out_2,
		Flags_out => flags_alu_out,
		Finished => start_writer
	);

	PM_Loader : Program_Loader port map(
		clk_6 => clk_6, Start => start_program_loader,
		Reset => program_reset, Finished => start_decoder,
		PM_read => pm_program_read
	);

	Loader : Memory_Loader port map(
		clk_6 => clk_6, Start_execution => start_loader, 
		Bus_load => enable_bus_load, Bus_load_second => enable_bus_second, 
		RAM_load => enable_ram_load, PM_load => enable_pm_load,
		Use_imdt => use_immediate, 
		Finished => start_ALU,
		Address_ram => addr_ram, Address_pm => addr_pm,
		Immediate => immediate, Address_bus_1 => addr_bus_load_1, Address_bus_2 => addr_bus_load_2,
		Data_out_1 => ALU_data_in_1, Data_out_2 => ALU_data_in_2,
		
		Bus_enable => Bus_read, Bus_data_in => bus_data_out,
		Bus_addr_out => bus_read_addr,

		RAM_enable => ram_read, RAM_data_in => ram_data_out,
		RAM_addr_out => ram_read_addr,

		PM_enable => pm_read, PM_data_in => pm_data_1,
		PM_addr_out => pm_read_addr
	);

	Writer : Memory_Writer port map(
		clk_6 => clk_6,
		Start_execution => start_writer, Finished => start_program_loader,
		Data_in => ALU_data_out_1,
		Bus_write => enable_bus_write, RAM_write => enable_ram_write, PM_write => enable_pm_write,
		Bus_Addr_in => addr_bus_write, RAM_Addr_in => addr_ram, PM_Addr_in => addr_pm,

		Bus_enable => Bus_write, Bus_Addr_out => bus_write_addr,
		Bus_Data_out => bus_data_in,

		RAM_enable => ram_write, RAM_Addr_out => ram_write_addr,
		RAM_Data_out => ram_data_in,

		PM_enable => pm_write, PM_Addr_out => pm_write_addr,
		PM_Data_out => pm_data_in
	);

	GP_Bus : GP_Bus_Master port map(
		clk_6 => clk_6, clk_12 => clk_12, clk_24 => clk_24,
		Master_Read_Addr_in => bus_read_addr, Master_Write_Addr_in => bus_write_addr,
		Master_Data_in => bus_data_in, Master_Data_out => bus_data_out,
		Master_Bus_read => bus_read, Master_Bus_write => bus_write,

		Pin_GPIO => GPIO, Pin_PMOD => PMOD, Pin_UART_out => tr_uart_out,
		Pin_UART_in => UART_in, Pin_Button_in => Button_in(1),
		Pin_LED_out(0) => LED_out(1), Pin_LED_out(3 downto 1) => RgbLED, 

		SP_inc => sp_inc, SP_dec => sp_dec, SP_out => sp_bus_out, Zreg_out => zreg_bus_out,
		PC_in => program_counter, Flags_out => flags_bus_out, Flags_in => flags_alu_out,
		Breg_in => ALU_data_out_2
	);
    RgbLED_out <= not RgbLED;
    
	RAM : RAM_Controller port map(
		clk_6 => clk_6, clk_12 => clk_12, clk_24 => clk_24,
		write => ram_write, read => ram_read,
		Write_Address => ram_write_addr, Read_Address => ram_read_addr,
		Addr_space => flags_bus_out(f_R), Data_in => ram_data_in,
		Data_out => ram_data_out, RAM_Address => RAM_Addr,
		Ram_Data => RAM_Data, Ram_ce => RAM_CE, ram_oe => RAM_OE, ram_we => RAM_WE
	);

	PM : PM_Controller port map(
		clk_6 => clk_6, clk_12 => clk_12, clk_24 => clk_24,
		Write => pm_write, Read => pm_read, Program_Read => pm_program_read, Boot_Write => pm_boot_write,
		Addr_Space => flags_bus_out(f_P),
		Write_Addr => pm_write_addr, Read_Addr => pm_read_addr, Program_Counter => program_counter,
		Boot_Write_Addr => pm_boot_write_addr,
		Data_in => pm_data_in, Boot_Data_in => pm_boot_data_in,
		Data_out_1 => pm_data_1, Data_out_2 => pm_data_2
	);

	BootLoaderI : BootLoader port map(
		clk_6 => clk_6, clk_locked => clk_locked, active => boot_mode,
		Finished => boot_loader_finished, PM_Addr_out => pm_boot_write_addr,
		PM_Data_out => pm_boot_data_in, PM_write => pm_boot_write,
		Is_sending => boot_is_sending, UART_out => boot_uart_out, UART_in => UART_in
	);
	
	UART_out <= boot_uart_out when boot_is_sending = '1' else tr_uart_out;

	Boot_Controller : Boot_Mode_Controller port map(
		clk_6 => clk_6, Button => Button_in(0),
		Boot_Mode => boot_mode,
		Program_reset => program_reset,
		BootLoader_finished => boot_loader_finished,
		Program_stopped => program_stopped
	);
	
	LED_out(0) <= boot_mode;

end Behavioral;
