
# Clock constraints
create_clock -name "sys_clk" -period 20ns [get_ports {clk}] -waveform {0.000ns 10.000ns}

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks


# clock uncertainty
set_clock_uncertainty -from [get_clocks {*}] -to [get_clocks {*}] 0.1


# INPUT timing constraints

# button inputs (asynchronous inputs)
set_false_path -from [get_ports {next_stim_n_button prev_stim_n_button reset_n_button}] 
# input from LCD: LCD busy indication
set_false_path -from [get_ports {LCD_DB[7]}] 

# OUTPUT timing constraints

# LED/7-Seg outputs (not critical)
set_false_path -to [get_ports {seven_segs[0] seven_segs[1] seven_segs[2] seven_segs[3] seven_segs[4] seven_segs[5] seven_segs[6]}] 
set_false_path -to [get_ports {seven_segs[7] seven_segs[8] seven_segs[9] seven_segs[10] seven_segs[11] seven_segs[12] seven_segs[13]}] 
set_false_path -to [get_ports {ALU_c_in result_history_ok_n result_ok_n}] 
# LCD data and control lines (not critical)
set_false_path -to [get_ports {LCD_DB[0] LCD_DB[1] LCD_DB[2] LCD_DB[3] LCD_DB[4] LCD_DB[5] LCD_DB[6] LCD_DB[7]}] 
# LCD control lines
set_false_path -to [get_ports {LCD_E LCD_RS LCD_RW}] 

# tpd constraints

