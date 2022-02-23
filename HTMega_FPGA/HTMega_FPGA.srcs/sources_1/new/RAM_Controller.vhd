-- this is a 12 MHz wrapper of the 24 MHz RAM Controller

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_Controller is
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
end RAM_Controller;

architecture Behavioral of RAM_Controller is
    signal enable, write_buffer, read_buffer, clk_6_buffer : std_logic := '0';
    signal ram_data_out_buffer : std_logic_vector(7 downto 0) := X"00";
    signal data_out_buffer : std_logic_vector(15 downto 0) := X"0000";
    signal address_buffer, address : std_logic_vector(16 downto 0) := X"0000" & '0';
    
begin
    enable <= read_buffer or write_buffer;
    address(15 downto 0) <= Write_Address when write = '1' else Read_Address;
    address(16) <= Addr_Space;
    
    RAM_CE <= not enable;
    RAM_OE <= not (read_buffer and not write_buffer);
    RAM_WE <= not (write_buffer and not read_buffer);
    
    RAM_DATA <= ram_data_out_buffer when write_buffer = '1' and clk_24 = '0' else "ZZZZZZZZ";
    RAM_Address (18) <= '0';
    RAM_Address(17 downto 1) <= address_buffer when enable = '1' else X"0000"&'0' ;
    RAM_Address(0) <= enable and not clk_6;
    
    ram_data_out_buffer <= Data_in(15 downto 8) when clk_6 = '0' else Data_in(7 downto 0);
    process(clk_12, clk_6)
    begin
        if falling_edge(clk_12) then
            clk_6_buffer <= clk_6;
            if clk_6 = '1' then
                read_buffer <= read;
                write_buffer <= write;
                address_buffer <= address;
            elsif read_buffer = '1' then
                Data_out(15 downto 8) <= ram_data;            
            end if;
        end if;
        
        if falling_edge(clk_6) and read_buffer = '1' then
            Data_out(7 downto 0) <= ram_data;
        end if;
    end process;
    
end Behavioral;
