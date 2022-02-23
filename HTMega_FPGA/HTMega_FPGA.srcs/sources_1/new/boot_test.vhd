library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity boot_test is
    Port ( 
        sysclk : in STD_LOGIC;
        UART_in : in STD_LOGIC;
        UART_out : out STD_LOGIC;
        GPIO : out STD_LOGIC_VECTOR (43 downto 0) := (others => '0');
        LED_out : out STD_LOGIC_VECTOR (1 downto 0);
        Button_in : in STD_LOGIC_VECTOR (1 downto 0)
    );

end boot_test;

architecture Behavioral of boot_test is
signal clk_6, clk_12, clk_24, clk_48, clk_96, clk_locked : std_logic := '0';
signal pm_boot_write, boot_is_sending : std_logic := '0';
signal boot_mode : std_logic := '1';
signal boot_loader_finished, program_reset, program_stopped : std_logic := '0';
signal pm_boot_write_addr : std_logic_vector(16 downto 0) := (others => '0');
signal pm_boot_data_in : std_logic_vector(15 downto 0) := (others => '0');

component SysClkWizard is
	port(
		clk_in1 : in STD_LOGIC;
		CLK_12 : out STD_LOGIC;
		CLK_24 : out STD_LOGIC;
		CLK_48 : out STD_LOGIC;
		CLK_96 : out STD_LOGIC;
		CLK_6 : out STD_LOGIC;
		reset : in STD_LOGIC;
		locked : out STD_LOGIC
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
    	clk_6, active : in STD_LOGIC;
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
		clk_in1 => sysclk, CLK_12 => clk_12, CLK_24 => clk_24, 
		CLK_48 => clk_48, CLK_96 => clk_96, CLK_6 => clk_6,
		reset => '0', locked => clk_locked
	);
	
    PM : PM_Controller port map(
		clk_6 => clk_6, clk_12 => clk_12, clk_24 => clk_24,
		Write => '0', Read => '0', Program_Read => '0', Boot_Write => pm_boot_write,
		Addr_Space => '0',
		Write_Addr => X"0000", Read_Addr => X"0000", Program_Counter => X"0000",
		Boot_Write_Addr => pm_boot_write_addr,
		Data_in => X"0000", Boot_Data_in => pm_boot_data_in,
		Data_out_1 => GPIO(15 downto 0), Data_out_2 => open
	);
    
    BootLoaderI : BootLoader port map(
		clk_6 => clk_6, active => boot_mode,
		Finished => boot_loader_finished, PM_Addr_out => open,
		PM_Data_out => pm_boot_data_in, PM_write => pm_boot_write,
		Is_sending => boot_is_sending, UART_out => UART_out, UART_in => UART_in
	);
	
	LED_out(1) <= boot_is_sending;
	LED_out(0) <= boot_mode;

	Boot_Controller : Boot_Mode_Controller port map(
		clk_6 => clk_6, Button => Button_in(0),
		Boot_Mode => boot_mode,
		Program_reset => program_reset,
		BootLoader_finished => boot_loader_finished,
		Program_stopped => program_stopped
	);

end Behavioral;
