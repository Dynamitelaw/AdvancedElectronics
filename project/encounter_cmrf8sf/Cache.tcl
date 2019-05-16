###################################
# Run the design through Encounter
###################################

## Setup design 
set designName cache
source ./config/config_Cache.globals
set_message -no_limit
init_design


## Set the parameters for the floorplan (it is up to you to use these parameters or not)
################# FILL OUT PARAMETERS (OPTIONAL) #################
#set std_cell_height 3.76
#set core_width 37
#core_height should be a multiple of the std_cell_height
#set core_height 30.08
#you should iterate the core width and height to make the density close to 0.7
#set ring_left_width 3
#set ring_right_width 3 
#set ring_top_width 3
#set ring_bottom_width 3
#set ring_left_space 3 
#set ring_right_space 3
#set ring_top_space 3
#set ring_bottom_space 3
#set ring_offset 0
##################################################################

#188.80 188.90 233.480 885.80 10 1036


############### Create the floorplan (FILL OUT)  #################
#floorPlan -d 1006 952.5 10 10 10 10
#floorPlan -d 860 770 10 10 10 10
floorPlan -d 796.5 716 10 10 10 10 
##################################################################
 redraw
 fit

proc connect_std_cells_to_power { } {

    globalNetConnect VDD -type tiehi -inst * -verbose
    globalNetConnect VSS -type tielo -inst * -verbose

    globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
    globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

}

Puts "#####################"
Puts "###"
Puts "### Power Routing ..."
Puts "###"
Puts "#####################"
connect_std_cells_to_power
applyGlobalNets


############## Add power rings (FILL OUT) ########################
addRing -layer {top M3 bottom M3 left M2 right M2} -spacing 1 -width 3 -nets {VDD VSS}
##################################################################
redraw


############## Route power nets (FILL OUT) #######################
#sroute
##################################################################


## IO file 
#load the IO file for your pins
######### Make sure you fill out the IO file before loading ######
 loadIoFile "./$designName.io"
##################################################################
redraw

# Intermediate saving
 saveFPlan "$designName.fp"


Puts "####################"
Puts "###"
Puts "### Place Design ..."
Puts "###"
Puts "####################"
#place standard cells
 setDesignMode -process 130 -flowEffort high
# setPlaceMode -congEffort low -clkGateAware FALSE -placeIoPins FALSE
#Puts "RUNNING PLACEMENT ..."
# placeDesign  -noPrePlaceOpt

#place cells w/ timing constraints
 setTrialRouteMode -maxRouteLayer 3
 setPlaceMode -timingDriven true -congEffort high -modulePlan true
 setOptMode -fixFanoutLoad true -effort high -moveInst true -reclaimArea true
 placeDesign -inplaceOpt
 connect_std_cells_to_power
 redraw
 sroute -nets {VDD VSS} -straightConnections straightWithChanges
#save

#addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 5 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -nets {gnd! vdd!} -stacked_via_bottom_layer M1
#addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 4 -stacked_via_top_layer M4 -padcore_ring_top_layer_limit M4 -spacing 5 -merge_stripes_value 4.9 -layer M3 -block_ring_bottom_layer_limit M4 -width 4 -nets {VSS VDD} -stacked_via_bottom_layer M1

#addStripe -layer M3 -area {12.390 12.450) 780.030 16.450} -nets VDD -spacing 1 -width 4 -number_of_sets 1 
#addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 4 -stacked_via_top_layer M4 -padcore_ring_top_layer_limit M4 -spacing 5 -merge_stripes_value 4.9 -layer M3 -block_ring_bottom_layer_limit M4 -width 4 -nets {VSS VDD} -stacked_via_bottom_layer M1 -area {12.390, 12.450 780.030, 16.450}

#addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 4 -stacked_via_top_layer M4 -padcore_ring_top_layer_limit M4 -spacing 5 -merge_stripes_value 4.9 -layer M3 -block_ring_bottom_layer_limit M4 -width 4 -nets {VSS VDD} -stacked_via_bottom_layer M1 -area {124.290 143.560 881.690 147.560}
#addStripe -layer M3 -area {119.170 810.120 125.170 946.4} -nets VDD -spacing 1 -width 4 -number_of_sets 1  
#addStripe -layer M3 -area {1 143.560 125 147.560} -nets VSS -spacing 1 -width 4 -number_of_sets 1 -block_ring_bottom_layer_limit M2 -block_ring_top_layer_limit M4 -stacked_via_bottom_layer M1 -direction horizontal 


#final
#Bottom VDD
addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 4 -stacked_via_top_layer M4 -padcore_ring_top_layer_limit M4 -spacing 5 -merge_stripes_value 4.9 -layer M3 -block_ring_bottom_layer_limit M4 -width 2 -nets {VDD} -stacked_via_bottom_layer M1 -area {12.390, 12.450 780.030, 14.450}
addStripe -layer M4 -area {18.5 6 780.030 16.450} -nets VDD -spacing 1 -width 4 -number_of_sets 1 -start_from top -switch_layer_over_obs 1 -orthogonal_only 0
#Top VDD
addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 4 -stacked_via_top_layer M4 -padcore_ring_top_layer_limit M4 -spacing 5 -merge_stripes_value 4.9 -layer M3 -block_ring_bottom_layer_limit M4 -width 4 -nets {VSS VDD} -stacked_via_bottom_layer M1 -area {12.390 684.130 780.030 688.130}

#Bottom VSS
addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 4 -stacked_via_top_layer M4 -padcore_ring_top_layer_limit M4 -spacing 5 -merge_stripes_value 4.9 -layer M3 -block_ring_bottom_layer_limit M4 -width 4 -nets {VSS} -stacked_via_bottom_layer M1 -area {2 16.510 775.280 20.510} -orthogonal_only 0
#Top VSS
addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 4 -stacked_via_top_layer M4 -padcore_ring_top_layer_limit M4 -spacing 5 -merge_stripes_value 4.9 -layer M3 -block_ring_bottom_layer_limit M4 -width 4 -nets {VSS} -stacked_via_bottom_layer M1 -area {2 677.950 775.280 681.950} -orthogonal_only 0


#sroute -connect {padRing} -nets {VDD VSS}  


Puts "###################"
Puts "###"
Puts "### Pre-Route Optimization..."
Puts "###"
Puts "###################"
 ##dont have to do this once you use -inplaceopt option in placeDesign
 #loadTimingCon "$designName.sdc"
 #setOptMode -fixFanoutLoad 
 #setOptMode -highEffort
 #setOptMode -moveInst
 #setOptMode -reclaimArea
 #optDesign -preCTS


Puts "################################"
Puts "###"
Puts "### Clock Tree Synthesis   .... "
Puts "###"
Puts "################################"
## Manual synthesis using the .cts.manual file
specifyClockTree -file "$designName.cts.manual"
setCTSMode -engine ck
ckSynthesis -clk clk -fix_added_buffers -forceReconvergent
redraw

######### Find and fill out the command to show min & max paths of the clock tree ############
## Take a screenshot of the min/max paths shown in the GUI and include it in the report

##############################################################################################

#Save design 
 saveDesign "$designName.opted.enc"
 savePlace "$designName.place"

Puts "################################"
Puts "###"
Puts "### Route critical signal first "
Puts "###"
Puts "################################"
## Unfix the clock nets to avoid routing problems
changeUseClockNetStatus -noFixedNetWires

########################## Route resetn first (FILL OUT) ###########################
 #setAttribute -net resetn
 #selectNet resetn
 #It routes just fine without these options
 
 #setNanoRouteMode 
 #setNanoRouteMode 
 #setNanoRouteMode 
 #setNanoRouteMode 
####################################################################################
 #globalDetailRoute -select resetn
 #redraw




 globalDetailRoute
 redraw

Puts "################################"
Puts "###"
Puts "### Extract and Optimization.... "
Puts "###"
Puts "################################"
#RC extraction
 setExtractRCMode -engine postRoute -effortLevel low -coupled true
 extractRC
#addStripe -layer M3 -direction horizontal -nets VDD -extend_to first_padring -max_pin_width 4 -start_x 124.290 -start_y 143.560 -stop_x 881.690 -stop_y 147.560 -spacing 1 -width 4 -number_of_sets 1


# Optimization
 setAnalysisMode -analysisType onChipVariation
 setOptMode -yieldEffort none
 setOptMode -effort high
 setOptMode -drcMargin 0.0
 setOptMode -holdTargetSlack 0.2 -setupTargetSlack 0.0
 setOptMode -simplifyNetlist false
 setOptMode -usefulSkew false
 setOptMode -moveInst true
 setOptMode -reclaimArea true
 setOptMode -fixDRC true
 setOptMode -fixCap true
 optDesign -postRoute -hold

# Connect all new cells to VDD/GND
 globalNetConnect VDD -type pgpin -pin {VDD } -override
 globalNetConnect VSS -type pgpin -pin {VSS } -override
 globalNetConnect VDD -type tiehi
 globalNetConnect VSS -type tielo
 applyGlobalNets


## Save design 
saveDesign "$designName.routed.enc"

Puts "################################"
Puts "###"
Puts "### Add decap or fillers    .... "
Puts "###"
Puts "################################"

# Add filler cells
 verifyGeometry
 #addFiller -cell FILL16TS FILL1TS FILL2TS FILL32TS FILL4TS FILL64TS FILL8TS -prefix IBM13RFLPVT_FILLER
 addFiller -cell FILL16TS FILL1TS FILL2TS FILL32TS FILL4TS FILL64TS FILL8TS -prefix IBM13RFLPVT_FILLER -fillBoundary 
 #deleteFiller -cell FILL16TS FILL1TS FILL2TS FILL32TS FILL4TS FILL64TS FILL8TS -prefix IBM13RFLPVT_FILLER -area 186 10 188.90 888.4
 verifyGeometry
 redraw

Puts "################################"
Puts "###"
Puts "### Verify .... "
Puts "###"
Puts "################################"
 clearDrc
 verifyGeometry
 verifyConnectivity -type regular -error 1000 -warning 50
 verifyProcessAntenna

Puts "################################"
Puts "###"
Puts "### Producing outputs    .... "
Puts "###"
Puts "################################"
#Report
 report_power -leakage -cap -nworst -pg_pin
 reportGateCount
#Output LEF
 lefOut "$designName.lef" -5.5 -PGpinLayers 4 -specifyTopLayer 4 -stripePin
#Output DEF
 set dbgLefDefOutVersion 5.5
 defOut -floorplan -netlist -routing "$designName.final.def"
#Output GDSII
 streamOut "$designName.gds" -mapFile "/tools2/courses/ee6321/share/ibm13rflpvt/mapfiles/enc2gds.map" -libName ibm13rflpvt -structureName $designName -stripes 1 -units 1000 -mode ALL
 saveNetlist -excludeLeafCell "$designName.final.v"
 #saveNetlist -phys -excludeLeafCell -excludeCellInst "FILL1TS FILL2TS FILL4TS FILL8TS FILL16TS FILL32TS FILL64TS" $designName.phy.v
 saveNetlist "$designName.nophy.v" 
#Generate SDF
 extractRC -outfile "$designName.cap"
 rcOut -spef "$designName.spef"
 write_sdf "$designName.sdf"
#Report hold/setup violation
 setAnalysisMode -checkType hold -useDetailRC true
 report_timing > "$designName.hold.rpt"
 setAnalysisMode -checkType setup -useDetailRC true
 report_timing > "$designName.setup.rpt"
 reportCapViolation -outfile final_cap.tarpt
#Run DRC and Connection checks
 verifyGeometry
 reportCritNet -outfile "$designName.critnet.rpt"

 #clearDrc
puts "**************************************"
puts "*                                    *"
puts "* And finally....                    *"
puts "*                                    *"
puts "* Encounter script finished          *"
puts "*                                    *"
puts "*                                    *"
puts "*                                    *"
puts "**************************************"

 exit
