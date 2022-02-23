----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.Constants.ALL;

entity Special_Registers is
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
end Special_Registers;

architecture Behavioral of Special_Registers is

signal SP, Zreg, Breg : std_logic_vector (15 downto 0) := X"0000";
signal Flags, Flags_buffer : std_logic_vector (7 downto 0) := X"00";
begin
Zreg_out <= Zreg;
SP_out <= SP;
process(clk_6) begin
  
    if falling_edge(clk_6) then
        if Bus_enable = '1' then
            if Bus_Addr_in = AD_PC then
                Bus_Data_out <= PC_in;
            end if;
            if Bus_Addr_in = AD_IADDR then
                Bus_Data_out <= Zreg;
                if Bus_write_enable = '1' then
                    Zreg <= Bus_Data_in;
                end if;
            end if;
        end if;
        
        if Bus_Addr_in = AD_ALU_B and Bus_enable = '1' then
            Bus_Data_out <= Breg;
            if Bus_write_enable = '1' then
                Breg <= Bus_Data_in;
            end if;
        else
            Breg <= Breg_in;
        end if;
    
        if Bus_Addr_in = AD_SP and Bus_enable = '1' then
            Bus_Data_out <= SP;
            if Bus_write_enable = '1' then
                SP <= Bus_Data_in;
            end if;
        else
            if SP_inc = '1' then
                SP <= std_logic_vector(unsigned(SP) + 1);
            elsif SP_dec = '1' then
                SP <= std_logic_vector(unsigned(SP) - 1);
            end if;
        end if;
        if Bus_Addr_in = AD_FLAGS and Bus_enable = '1' then	
            Bus_Data_out <= X"00" & Flags;
            if Bus_write_enable = '1' then
                Flags <= Bus_data_in(7 downto 0);
             else 
                Flags <= Flags_in;
            end if;
        else
            Flags <= Flags_in;
        end if;
    end if;
    if rising_edge(clk_6) then
        Flags_out <= Flags;
    end if;
end process;

end Behavioral;
