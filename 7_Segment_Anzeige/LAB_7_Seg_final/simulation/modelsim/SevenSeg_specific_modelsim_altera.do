###############################################################################
# modelsim_script.do for Modelsim Altera
#
#  Digitaltechnik 2
#  (c) 2009 R.Keller, W.Lindermeir, W.Zimmermann
#  Hochschule Esslingen
#  Author:  Walter Lindermeir, 4.12.2009
#
###############################################################################


# compile generated vhdl from source bdf (in case of error type in tcl console of quartus "source bdf2vhd.tcl"
vcom -93 -work work {../../lab_7_seg_final.vhd}

# test bench compile
vcom -93 -work work {LAB_7_Seg_final.vht}

# start simulation
vsim -t 1ns -novopt -L work LAB_7_Seg_final_vhd_tst


add wave -noupdate -format Logic                        /LAB_7_Seg_final_vhd_tst/clk
add wave -noupdate -format Literal -radix hexadecimal   /LAB_7_Seg_final_vhd_tst/buttons
add wave -noupdate -format Literal -radix hexadecimal   /LAB_7_Seg_final_vhd_tst/i1/b2v_inst4/buttons_entprellt
add wave -noupdate -format Literal -radix hexadecimal   /LAB_7_Seg_final_vhd_tst/state

run 60 us
wave zoomfull

