----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.Constants.ALL;

entity GP_Bus is
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
end GP_Bus;

architecture Behavioral of GP_Bus is
	signal sel : std_logic_vector(7 downto 0) := X"00";
begin
	GPREG_SS <= sel(0);
	IO_SS <= sel(1);
	UART_SS <= sel(2);
	Timer_SS <= sel(3);
	SREG_SS <= sel(4);
	
	with sel select Master_Data_out <= 
		GPREG_Data_in when "00000001",
		IO_Data_in when "00000010",
		UART_Data_in when "00000100",
		Timer_Data_in when "00001000",
		SREG_Data_in when "00010000",
		(others => '0') when others;

process(clk_12) begin
	if falling_edge(clk_12) and clk_6 = '1' then
        sel <= X"00";
	    if Master_Bus_enable = '1' then
            Slave_Write_enable <= Master_Write_enable;
            Slave_Addr_out <= Master_Addr_in;
            Slave_Data_out <= Master_Data_in;
            if Master_Bus_enable = '1' then
                Slave_Data_out <= Master_Data_in;
                if Master_Addr_in(7 downto 5) /= "111" then
                    sel(0) <= '1'; -- select GPREG 
                elsif Master_Addr_in >= AD_PA_IN and Master_Addr_in <= AD_PD_CONF then 
                    sel(1) <= '1'; -- select IO interface
                elsif Master_Addr_in >= AD_UART_CONF and Master_Addr_in <= AD_UART_RD then
                    sel(2) <= '1'; -- select UART
                elsif Master_Addr_in >= AD_TIMA_VAL and Master_Addr_in <= AD_MICR_H then
                    sel(3) <= '1'; -- select Timers
                elsif Master_Addr_in >= AD_ALU_B then
                    sel(4) <= '1'; -- select Special regs
                end if;
            end if;
	    end if;
	end if;
end process;

end Behavioral;
