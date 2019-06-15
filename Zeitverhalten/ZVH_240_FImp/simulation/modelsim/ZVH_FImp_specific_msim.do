###############################################################################
# modelsim_script.do for Modelsim Altera
#
#  Digitaltechnik 2
#  Labor 3, ZVH
#  (c) 2010 W.Lindermeir, W.Zimmermann, R.Keller
#  Hochschule Esslingen
#  Erstellt:        05.02.2010   R. Keller
#  Letzte Änderung: 25.05.2010   R. Keller
#
###############################################################################


# compile generated vhdl from source bdf (in case of error type in tcl console of quartus "source bdf2vhd.tcl"
vcom -93 -work work {../../ZVH_240_FImp.vhd}

# test bench compile
vcom -93 -work work {ZVH_240_FImp.vht}

# start simulation
vsim -t 1ns -novopt -L work ZVH_240_FImp_vhd_tst

# create graphical output (waveforms)
do ZVH_FImp_SimWF.do

# end of project specific script
