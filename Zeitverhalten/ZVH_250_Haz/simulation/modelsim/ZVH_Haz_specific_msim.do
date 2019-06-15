###############################################################################
# modelsim_script.do for Modelsim Altera
#
#  Digitaltechnik 1
#  Labor 3, ZVH
#  (c) 2010 W.Lindermeir, W.Zimmermann, R.Keller
#  Hochschule Esslingen
#  Erstellt:        05.02.2010   R. Keller
#  Letzte Änderung: 17.05.2019   R. Keller
#
###############################################################################


# compile generated vhdl from source bdf (in case of error type in tcl console of quartus "source bdf2vhd.tcl"
vcom -93 -work work {../../ZVH_250_Haz.vhd}

# test bench compile
vcom -93 -work work {ZVH_250_Haz.vht}

# start simulation
vsim -t 1ns -novopt -L work ZVH_250_Haz_vhd_tst

# create graphical output (waveforms)
do ZVH_Haz_SimWF.do

# end of project specific script
