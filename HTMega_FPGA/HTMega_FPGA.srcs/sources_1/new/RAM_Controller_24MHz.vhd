library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_Controller_24MHz is
    Port (
        address : in std_logic_vector(16 downto 0) := X"0000"&"0";
        data_in : in std_logic_vector(15 downto 0) := X"0000";
        data_out : out std_logic_vector(15 downto 0) := X"0000";
        clk_12, clk_24, clk_48, write, start, enable : in std_logic := '0';
        valid : out std_logic := '0';
        ram_address : out std_logic_vector(17 downto 0) := X"0000"&"00";
        ram_data : inout std_logic_vector(7 downto 0);
        ram_ce, ram_oe, ram_we : out std_logic := '1'
        );
end RAM_Controller_24MHz;

architecture Behavioral of RAM_Controller_24MHz is
    signal write_buffer, start_buffer, clk_24_buffer : std_logic := '0';
    signal ram_data_out_buffer : std_logic_vector(7 downto 0) := X"00";
    signal data_out_buffer : std_logic_vector(15 downto 0) := X"0000";
    signal address_buffer : std_logic_vector(16 downto 0) := X"0000" & '0';
    
begin
    ram_ce <= not enable;
    ram_oe <= not (start_buffer and not write_buffer);
    ram_we <= not (start_buffer and write_buffer);
    ram_data <= ram_data_out_buffer when write_buffer = '1' and clk_48 = '0' else "ZZZZZZZZ";
    valid <= start_buffer and not write_buffer and not clk_24;
    data_out <= data_out_buffer;
    ram_address(17 downto 1) <= address_buffer when start_buffer = '1' else X"0000"&'0' ;
    ram_address(0) <= '1' when start_buffer = '1' and clk_24 = '1' else '0';
    
    process(clk_12, clk_24)
    begin
        if falling_edge(clk_24) and clk_12 = '1' then
            start_buffer <= start;
            write_buffer <= write;
            address_buffer <= address;
        end if;
        
        if falling_edge(clk_12) then
        	clk_24_buffer <= clk_24;
            if start_buffer = '1' then
                if write_buffer = '1' then
                    if clk_24 = '0' then
                        ram_data_out_buffer <= data_in(15 downto 8);
                    else
                        ram_data_out_buffer <= data_in(7 downto 0);
                    end if;
                else
                    if clk_24 = '0' then
                        data_out_buffer(15 downto 8) <= ram_data;
                        
                    else
                        data_out_buffer(7 downto 0) <= ram_data;
                        
                    end if;
                end if;
             end if;
        end if;
    end process;
    
end Behavioral;
