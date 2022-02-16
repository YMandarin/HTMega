----------------------------------------------------------------------------------
-- GPREG
-- General Purpose Register BRAM
-- single side 8bit x 16bit Block RAM 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GPREG is
    port (
        addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
        clk : in STD_LOGIC;
        d_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
        d_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
        enable : in STD_LOGIC;
        w_enable : in STD_LOGIC
    );
end GPREG;

architecture Behavioral of GPREG is
component GPREG_IP IS
  port (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;
begin
  BRAM : GPREG_IP port map(
    clka => clk, ena => enable, wea(0) => w_enable, 
    addra => addr, dina => d_in, douta => d_out
  );

end Behavioral;
