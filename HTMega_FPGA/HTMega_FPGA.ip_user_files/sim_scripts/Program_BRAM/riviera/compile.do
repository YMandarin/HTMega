vlib work
vlib riviera

vlib riviera/blk_mem_gen_v8_4_5
vlib riviera/xil_defaultlib

vmap blk_mem_gen_v8_4_5 riviera/blk_mem_gen_v8_4_5
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work blk_mem_gen_v8_4_5  -v2k5 \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../HTMega_FPGA.gen/sources_1/ip/Program_BRAM/sim/Program_BRAM.v" \


vlog -work xil_defaultlib \
"glbl.v"

