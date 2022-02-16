// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sat Feb 12 20:43:29 2022
// Host        : YMLap running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ SysClkWizard_stub.v
// Design      : SysClkWizard
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(CLK_12, CLK_24, CLK_48, CLK_96, reset, locked, 
  clk_in1)
/* synthesis syn_black_box black_box_pad_pin="CLK_12,CLK_24,CLK_48,CLK_96,reset,locked,clk_in1" */;
  output CLK_12;
  output CLK_24;
  output CLK_48;
  output CLK_96;
  input reset;
  output locked;
  input clk_in1;
endmodule
