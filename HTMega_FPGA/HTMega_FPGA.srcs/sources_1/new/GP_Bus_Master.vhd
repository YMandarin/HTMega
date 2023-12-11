library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity GP_Bus_Master is
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
end GP_Bus_Master;

architecture Behavioral of GP_Bus_Master is
component GP_Bus is
    Port ( clk_6, clk_12 : in STD_LOGIC;
    	   Master_Addr_in : in STD_LOGIC_VECTOR (7 downto 0);
           Master_Data_in : in STD_LOGIC_VECTOR (15 downto 0);
           Master_Data_out : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
           Master_Bus_enable, Master_Write_enable : in STD_LOGIC;
           
           Slave_Data_out : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
           Slave_Addr_out : out STD_LOGIC_VECTOR(7 downto 0) := X"00";
           Slave_Write_enable : out STD_LOGIC := '0';
           
           GPREG_SS, IO_SS, UART_SS, Timer_SS, SREG_SS : out STD_LOGIC := '0';
           
           GPREG_Data_in, IO_Data_in, UART_Data_in, Timer_Data_in, SREG_Data_in
           		: in STD_LOGIC_VECTOR (15 downto 0)
           );
end component;

component GP_RegisterBank is
    Port ( 
        clk_6, clk_24: in STD_LOGIC;
        bus_addr : in STD_LOGIC_VECTOR (7 downto 0);
        bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
        enable, write_enable : in STD_LOGIC;
        bus_data_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component GPIO_Interface is
    Port ( 
    	clk_6 : in STD_LOGIC;
		bus_addr : in STD_LOGIC_VECTOR (7 downto 0);
		bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
		bus_data_out : out STD_LOGIC_VECTOR (15 downto 0);
		bus_enable, write_enable : in STD_LOGIC;
		port_Timer_A, port_Timer_B: in STD_LOGIC;
		Pin_GPIO: inout STD_LOGIC_VECTOR (45 downto 0);
		Pin_LED: out STD_LOGIC_VECTOR(3 downto 0);
		Pin_button: in STD_LOGIC;
		Pin_PMOD : inout STD_LOGIC_VECTOR(7 downto 0)
		);
end component;

component UART_Interface is
    Port ( clk_6 : in STD_LOGIC;
    	   bus_addr_in : in STD_LOGIC_VECTOR (7 downto 0);
           bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
           bus_data_out : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
           bus_enable, bus_write_enable : in STD_LOGIC;
           UART_port_out : out STD_LOGIC := '1';
           UART_port_in : in STD_LOGIC
           );
end component;

component Timers is
    Port ( clk_6 : in STD_LOGIC;
    	   bus_addr_in : in STD_LOGIC_VECTOR (7 downto 0);
           bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
           bus_data_out : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
           bus_enable, bus_write_enable : in STD_LOGIC;
           port_timer_A, port_timer_B: out STD_LOGIC := 'Z'
           );
end component;

component Special_Registers is
    Port ( 
    	clk_6 : in STD_LOGIC;
    	Bus_Addr_in : in STD_LOGIC_VECTOR (7 downto 0);
		Bus_Data_in : in STD_LOGIC_VECTOR (15 downto 0);
		Bus_Data_out : out STD_LOGIC_VECTOR (15 downto 0);
		Bus_enable, Bus_write_enable : in STD_LOGIC;
		SP_inc, SP_dec : in STD_LOGIC;
		SP_out, Zreg_out : out STD_LOGIC_VECTOR(15 downto 0);
		PC_in: in STD_LOGIC_VECTOR ( 15 downto 0);
		Flags_out : out STD_LOGIC_VECTOR(7 downto 0);
		Flags_in : STD_LOGIC_VECTOR(7 downto 0);
		Breg_in : STD_LOGIC_VECTOR(15 downto 0)
		
		);
end component;
signal Slave_addr : std_logic_vector(7 downto 0) := X"00";
signal Slave_data, GPREG_data, IO_data, UART_data, Timer_data, SREG_data: std_logic_vector(15 downto 0) := X"0000";
signal Slave_write_enable, GPREG_SS, IO_SS, UART_SS, Timer_SS, SREG_SS,
	 Timer_port_A, Timer_port_B : std_logic := '0';

signal bus_enable : std_logic := '0';
signal master_addr : std_logic_vector(7 downto 0) := X"00";
begin
	bus_enable <= Master_Bus_read or Master_Bus_write;
	master_addr <= Master_Write_Addr_in when Master_Bus_write = '1'
		else Master_Read_Addr_in;
	
	
Bus_Controller : GP_Bus port map(clk_6, clk_12,
	master_addr, Master_Data_in, Master_Data_out,
	bus_enable, Master_Bus_write,
	Slave_data, Slave_addr, Slave_write_enable,
	GPREG_SS, IO_SS, UART_SS, Timer_SS, SREG_SS,
	GPREG_data, IO_data, UART_data, Timer_data, SREG_data
	);

GPREG : GP_RegisterBank port map(clk_6, clk_24,
	bus_addr => Slave_addr, bus_data_in => Slave_data,
	enable => GPREG_SS, write_enable => Slave_write_enable,
	bus_data_out => GPREG_data
	);

GPIO : GPIO_Interface port map(clk_6,
	bus_addr => Slave_addr, bus_data_in => Slave_data,
	bus_data_out => IO_data, bus_enable => IO_SS, write_enable => Slave_write_enable,
	port_Timer_A => Timer_port_A, port_Timer_B => Timer_port_B,
	Pin_GPIO => Pin_GPIO, Pin_LED => Pin_LED_out, Pin_button => Pin_Button_in,
	Pin_PMOD => Pin_PMOD
	);

UART : UART_Interface port map(clk_6,
	bus_addr_in => Slave_addr, bus_data_in => Slave_data,
	bus_data_out => UART_data, bus_enable => UART_SS, 
	bus_write_enable => Slave_write_enable, UART_port_out => Pin_UART_out,
	UART_port_in => Pin_UART_in
	);

Timer : Timers port map(clk_6,
	bus_addr_in => Slave_addr, bus_data_in => Slave_data,
	bus_data_out => Timer_data, bus_enable => Timer_SS, 
	bus_write_enable => Slave_write_enable, 
	port_timer_A => Timer_port_A, port_timer_B => Timer_port_B
	);
	
SREG : Special_Registers port map(clk_6,
	Bus_Addr_in => Slave_addr, Bus_Data_in => Slave_data,
	Bus_Data_out => SREG_data, Bus_enable => SREG_SS,
	Bus_Write_enable => Slave_write_enable, SP_dec => SP_dec, 
	SP_inc => SP_inc, SP_out => SP_out, Zreg_out => Zreg_out, 
	PC_in => PC_in, Flags_in => Flags_in, 
	Flags_out => Flags_out, Breg_in => Breg_in
	);
	

end Behavioral;
