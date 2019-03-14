# Written by mgseok, May 08

#################################################
# ST45nm Library information from .lib file     #
#  time_unit : "1ns";                           #
#  voltage_unit : "1V";                         #
#  current_unit : "1mA";                        # 
#  pulling_resistance_unit : "1kohm";           #
#  capacitive_load_unit(1,pf);                  #
#  default_cell_leakage_power : 4.89642e-08;    #
#  default_fanout_load : 1;                     # 
#  default_inout_pin_cap : 0.01;                #
#  default_input_pin_cap : 0.01;                #
#  default_leakage_power_density : 3.46968e-08; #
#  default_max_fanout : 20;                     # 
#  default_output_pin_cap : 0;                  #
#  default_wire_load_mode : "enclosed";         #
#  leakage_power_unit : "1mW";                  # 
#################################################

## Global lfsr1es
set sh_enable_page_mode true
set power_enable_analysis true
set power_ui_backward_compatibility true

## Setting files/paths
set verilog_files {lfsr1.nl.v}
set my_toplevel lfsr1
set search_path ". ../dc_shell_cmrf8sf/ /tools2/courses/ee6321/share/ibm13rflpvt/synopsys/"
set link_path "* scx3_cmos8rf_lpvt_tt_1p2v_25c.db" 

## Read design
read_db "scx3_cmos8rf_lpvt_tt_1p2v_25c.db"
read_verilog $verilog_files
link_design -keep_sub_designs $my_toplevel
set_operating_conditions -analysis_type single

## Timing Constraint: Clock
set clk_period 12
set clk_uncertainty 0
set clk_transition 0.5

if {[sizeof_collection [get_ports clk]] > 0} {
  set clk_name "clk"
  set clk_port "clk"
  create_clock -name $clk_name -period $clk_period [get_ports $clk_port]
}

set_clock_uncertainty $clk_uncertainty [get_clocks $clk_name]
set_clock_transition $clk_transition [get_clocks $clk_name]

## Timing Constraint: Input delay or output delay 
set mydelay 1.5
set_input_delay $mydelay -clock $clk_name [all_inputs] -add_delay
remove_input_delay -clock $clk_name [find port $clk_name]
set_output_delay $mydelay -clock $clk_name [all_outputs]

## Setting driving buffer and output cap
set_load 0.01 [all_outputs]


#####################################################################
#       read switching activity file
#####################################################################
read_vcd "../dump_lfsr.vcd" -strip_path "testbench/lfsr_0"


##################################################################
## Units
##################################################################
report_units


##################################################################
## Write script to run STA (report_timing)
##################################################################
check_timing
report_design
report_reference
report_constraint
report_constraint -all_violators
report_timing


##################################################################
## Write script to run power analysis (report_power)
##################################################################
check_power
create_power_waveforms -output vcd
report_power


##################################################################
## Output annotated SDF
##################################################################
write_sdf lfsr.sdf
 
# Exiting primetime
quit
