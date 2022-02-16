set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports clk_12]
create_clock -period 83.330 -name sys_clk_pin -waveform {0.000 41.660} -add [get_ports clk_12]

set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33} [get_ports Boot_Mode]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports Program_reset]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports Button]

set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33} [get_ports BootLoader_finished]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports Program_stopped]


set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_MODE SPIx4 [current_design]
