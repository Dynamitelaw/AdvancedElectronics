##################################################
#  Modelsim do file to run simuilation
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog -incr /tools2/courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog -incr rtl/CacheMem.v 
vlog -incr dc_shell_cmrf8sf/network.nl.v
vlog -incr rtl/TEST_networkTestbench_Generated.v 

# Run Simulator 
vsim -t ns -lib work NetworkGeneratedTestBench 
do waveformat.do
run 20000us
#quit -f
