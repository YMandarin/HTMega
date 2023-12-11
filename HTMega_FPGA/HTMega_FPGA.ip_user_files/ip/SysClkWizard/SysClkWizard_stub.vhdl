-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
-- Date        : Sun Mar  6 07:47:49 2022
-- Host        : YMLap running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/Diplomarbeit/HTMega/HTMega_FPGA/HTMega_FPGA.gen/sources_1/ip/SysClkWizard/SysClkWizard_stub.vhdl
-- Design      : SysClkWizard
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SysClkWizard is
  Port ( 
    CLK_6 : out STD_LOGIC;
    CLK_12 : out STD_LOGIC;
    CLK_24 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end SysClkWizard;

architecture stub of SysClkWizard is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK_6,CLK_12,CLK_24,reset,locked,clk_in1";
begin
end;
