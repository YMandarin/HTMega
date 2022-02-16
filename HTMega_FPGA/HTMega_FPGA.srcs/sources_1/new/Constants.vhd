library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;

package Constants is
	-- flag position in flags register
	constant f_Z : integer range 0 to 7 := 0;
	constant f_C : integer range 0 to 7 := 1;
	constant f_N : integer range 0 to 7 := 2;
	constant f_V : integer range 0 to 7 := 3;
	constant f_T : integer range 0 to 7 := 4;
	constant f_I : integer range 0 to 7 := 5;
	constant f_R : integer range 0 to 7 := 6;
	constant f_P : integer range 0 to 7 := 7;
	
	-- bus io register addresses
	constant AD_PA_IN : std_logic_vector(7 downto 0) := X"E2"; 
	constant AD_PA_OUT : std_logic_vector(7 downto 0) := X"E3";
	constant AD_PA_CONF : std_logic_vector(7 downto 0) := X"E4";
	constant AD_PB_IN : std_logic_vector(7 downto 0) := X"E5";
	constant AD_PB_OUT : std_logic_vector(7 downto 0) := X"E6";
	constant AD_PB_CONF : std_logic_vector(7 downto 0) := X"E7";
	constant AD_PC_IN : std_logic_vector(7 downto 0) := X"E8";
	constant AD_PC_OUT : std_logic_vector(7 downto 0) := X"E9";
	constant AD_PC_CONF : std_logic_vector(7 downto 0) := X"EA";
	constant AD_PD_IN : std_logic_vector(7 downto 0) := X"EB";
	constant AD_PD_OUT : std_logic_vector(7 downto 0) := X"EC";
	constant AD_PD_CONF : std_logic_vector(7 downto 0) := X"ED";
	
	constant AD_UART_CONF : std_logic_vector(7 downto 0) := X"EE";
	constant AD_UART_TD : std_logic_vector(7 downto 0) := X"EF";
	constant AD_UART_RD : std_logic_vector(7 downto 0) := X"F0";
	
	constant AD_TIMA_VAL : std_logic_vector(7 downto 0) := X"F1";
	constant AD_TIMB_VAL : std_logic_vector(7 downto 0) := X"F2";
	constant AD_TIMA_TOP : std_logic_vector(7 downto 0) := X"F3";
	constant AD_TIMB_TOP : std_logic_vector(7 downto 0) := X"F4";
	constant AD_TIMA_COMP : std_logic_vector(7 downto 0) := X"F5";
	constant AD_TIMB_COMP : std_logic_vector(7 downto 0) := X"F6";
	constant AD_TIMA_CONF : std_logic_vector(7 downto 0) := X"F7";
	constant AD_TIMB_CONF : std_logic_vector(7 downto 0) := X"F8";
	constant AD_MICR_L : std_logic_vector(7 downto 0) := X"F9";
	constant AD_MICR_H : std_logic_vector(7 downto 0) := X"FA";
	
	constant AD_ALU_B : std_logic_vector(7 downto 0) := X"FB";
	constant AD_SP : std_logic_vector(7 downto 0) := X"FC";
	constant AD_IADDR : std_logic_vector(7 downto 0) := X"FD";
	constant AD_PC : std_logic_vector(7 downto 0) := X"FE";
	constant AD_FLAGS : std_logic_vector(7 downto 0) := X"FF";
	
	-- boot loader serial transmission constants
	constant TRANSMISSION_END : std_logic_vector(7 downto 0) := X"FF"; 
	constant TRANSMISSION_BEGIN : std_logic_vector(7 downto 0) := X"F1"; 
	constant TRANSMISSION_ERROR : std_logic_vector(7 downto 0) := X"10";

end package Constants;

package body Constants is
end package body;
