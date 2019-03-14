##################################################
#  Modelsim do file to run simuilation
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
#vlog -incr lfsr1.v
vlog -incr /tools2/courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog -incr dc_shell_cmrf8sf/lfsr1.nl.v
vlog -incr test_lfsr.v 

# Run Simulator 
vsim -t ns -lib work testbench 
do waveformat.do
run 5160000ps
#quit -f
