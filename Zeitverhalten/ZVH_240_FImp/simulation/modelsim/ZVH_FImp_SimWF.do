###############################################################################
# modelsim_script.do for Modelsim Altera
#
#  Digitaltechnik 1
#  Labor 3, ZVH
#  (c) 2010 W.Lindermeir, W.Zimmermann, R.Keller
#  Hochschule Esslingen
#  Erstellt:        15.03.2010   R. Keller
#  Letzte Änderung: 17.05.2019   R. Keller
#
#  Mit diesem Script wird die Graphik-Ausgabe (Impulsdiagramme) gesteuert.
#  Es können Signale aus dem Design ausgewählt und entsprechend dargestellt werden.
#  Zudem kann die Simulationsdauer (run x us) festgelegt werden.
#
###############################################################################
#
#
add wave -noupdate -divider {Eingangssignale}
add wave -noupdate -format Logic  -color green  /zvh_240_FImp_vhd_tst/A
add wave -noupdate -format Logic  -color red    /zvh_240_FImp_vhd_tst/B
add wave -noupdate -format Logic  -color yellow /zvh_240_FImp_vhd_tst/S
add wave -noupdate -divider {Interne Signale}
add wave -noupdate -format Logic  -color green  /zvh_240_FImp_vhd_tst/i1/x0
add wave -noupdate -format Logic  -color green  /zvh_240_FImp_vhd_tst/i1/x1
add wave -noupdate -format Logic  -color green  /zvh_240_FImp_vhd_tst/i1/x2
add wave -noupdate -format Logic  -color green  /zvh_240_FImp_vhd_tst/i1/x3
add wave -noupdate -divider {Ausgangssignal}
add wave -noupdate -format Logic  -color blue   /zvh_240_FImp_vhd_tst/Y
#
run 2100 ns
wave zoomfull
# end of simulation waveform generation
