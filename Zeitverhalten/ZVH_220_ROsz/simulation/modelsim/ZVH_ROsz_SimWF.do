###############################################################################
# modelsim_script.do for Modelsim Altera
#
#  Digitaltechnik 1
#  Labor 3, ZVH
#  (c) 2010 W.Lindermeir, W.Zimmermann, R.Keller
#  Hochschule Esslingen
#  Erstellt:        15.03.2010   R. Keller
#  Letzte �nderung: 17.05.2019   R. Keller
#
#  Mit diesem Script wird die Graphik-Ausgabe (Impulsdiagramme) gesteuert.
#  Es k�nnen Signale aus dem Design ausgew�hlt und entsprechend dargestellt werden.
#  Zudem kann die Simulationsdauer (run x us) festgelegt werden.
#
###############################################################################
#
#
add wave -noupdate -divider {Reset und Ausgangssignal}
add wave -noupdate -format Logic  -color white  /zvh_220_ROsz_vhd_tst/Reset_n
add wave -noupdate -format Logic  -color red    /zvh_220_ROsz_vhd_tst/y_out
add wave -noupdate -divider {Interne Signale}
add wave -noupdate -format Logic  -color yellow /zvh_220_ROsz_vhd_tst/i1/x1
add wave -noupdate -format Logic  -color green  /zvh_220_ROsz_vhd_tst/i1/x2
add wave -noupdate -format Logic  -color blue   /zvh_220_ROsz_vhd_tst/i1/x3
#
run 400 ns
wave zoomfull
# end of simulation waveform generation
