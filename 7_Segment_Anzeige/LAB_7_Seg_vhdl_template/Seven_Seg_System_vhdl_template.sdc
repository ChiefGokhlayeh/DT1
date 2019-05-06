#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 10.0 Build 262 08/18/2010 Service Pack 1 SJ Web Edition
#
#************************************************************

# Copyright (C) 1991-2010 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

create_clock -name "b0clk" -period 20ns [get_ports {b_0}] -waveform {0.000ns 10.000ns}
create_clock -name "b1clk" -period 20ns [get_ports {b_1}] -waveform {0.000ns 10.000ns}
create_clock -name "b2clk" -period 20ns [get_ports {b_2}] -waveform {0.000ns 10.000ns}
create_clock -name "b3clk" -period 20ns [get_ports {b_3}] -waveform {0.000ns 10.000ns}


# clock uncertainty
set_clock_uncertainty -from [get_clocks {*}] -to [get_clocks {*}] 0.1


set_false_path -to [get_ports {*}] 


# tco constraints

# tpd constraints

