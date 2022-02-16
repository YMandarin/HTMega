onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Program_BRAM_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {Program_BRAM.udo}

run -all

quit -force
