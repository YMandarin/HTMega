onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib GPREG_IP_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {GPREG_IP.udo}

run -all

quit -force
