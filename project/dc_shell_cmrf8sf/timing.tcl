# Timing setup for synthesis

# Setting variables 
set clk_period 12
set clk_uncertainty 0
set clk_transition 1.5
set typical_input_delay 0
set typical_output_delay 3
set typical_wire_load 0.001

#Create real clock if clock port is found
if {[sizeof_collection [get_ports clk]] > 0} {
  set clk_name "clk"
  set clk_port "clk"
  #If no waveform is specified, 50% duty cycle is assumed
  create_clock -name $clk_name -period $clk_period [get_ports $clk_port] 
  set_drive 0 [get_clocks $clk_name] 
}

#Set clock uncertainty
set_clock_uncertainty $clk_uncertainty [get_clocks $clk_name]
#Propagated clock used for gated clocks only
set_clock_transition $clk_transition [get_clocks $clk_name]


# Configure the clock network
set_dont_touch_network $clk_port 

# Set delays: Input, Output
set_input_delay $typical_input_delay [all_inputs] -clock $clk_name 
remove_input_delay -clock $clk_name [find port $clk_port]

set_output_delay $typical_output_delay [all_outputs] -clock $clk_name 

# Set loading of outputs 
set_load $typical_wire_load [all_outputs] 
