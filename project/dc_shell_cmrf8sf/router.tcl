#########################################
# TCL script for Design Compiler        #
# 2012 Mingoo Seok                      #
#########################################

#########################################
# READ Design and Library               #
#########################################
set BEHAVIORROOT "../rtl/"
#set top_level
#set top_level cacheBank_new
set top_level router
source -verbose "common.tcl"
#read_verilog {../rtl/cacheBank_test.v}
read_verilog {../rtl/router.v}
list_designs

#########################################
# Design Constranits                    #
#########################################
current_design $top_level
link
source -verbose "timing.tcl"
set_max_capacitance 0.001 [all_inputs]
set_max_fanout 4 $top_level
set_max_fanout 2 [all_inputs]
set_max_area 0 


#########################################
# Compile for combinational logic       #
#########################################
check_design
compile -boundary_optimization -map_effort medium
#compile_ultra -no_autoungroup
#########################################
# Write outputs                         #
#########################################
set verilogout_no_tri TRUE
write -hierarchy -format verilog -output "${top_level}.nl.v"

# Generate Standard Delay Format (SDF) file
write_sdf -context verilog "${top_level}.temp.sdf"
# Generate report file
set maxpaths 20
set rpt_file "${top_level}.dc.rpt"
check_design > $rpt_file
report_area  >> ${rpt_file}
report_power -hier -analysis_effort medium >> ${rpt_file}
report_design >> ${rpt_file}
report_cell >> ${rpt_file}
report_port -verbose >> ${rpt_file}
report_compile_options >> ${rpt_file}
report_constraint -all_violators -verbose >> ${rpt_file}
report_timing -path full -delay max -max_paths $maxpaths -nworst 100 >> ${rpt_file}

quit
