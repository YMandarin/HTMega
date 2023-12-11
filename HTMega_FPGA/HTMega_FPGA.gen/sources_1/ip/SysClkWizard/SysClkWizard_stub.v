// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sun Mar  6 07:47:49 2022
// Host        : YMLap running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/Diplomarbeit/HTMega/HTMega_FPGA/HTMega_FPGA.gen/sources_1/ip/SysClkWizard/SysClkWizard_stub.v
// Design      : SysClkWizard
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module SysClkWizard(CLK_6, CLK_12, CLK_24, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="CLK_6,CLK_12,CLK_24,reset,locked,clk_in1" */;
  output CLK_6;
  output CLK_12;
  output CLK_24;
  input reset;
  output locked;
  input clk_in1;
endmodule
