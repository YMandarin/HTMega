vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic" \
"E:/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"E:/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../HTMega_FPGA.gen/sources_1/ip/SysClkWizard/SysClkWizard_clk_wiz.v" \
"../../../../HTMega_FPGA.gen/sources_1/ip/SysClkWizard/SysClkWizard.v" \

vlog -work xil_defaultlib \
"glbl.v"
