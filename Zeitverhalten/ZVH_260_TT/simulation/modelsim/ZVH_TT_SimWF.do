###############################################################################
# modelsim_script.do for Modelsim Altera
#
#  Digitaltechnik 2
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
add wave -noupdate -format Logic  -color green   /zvh_260_TT_vhd_tst/CLR_n
add wave -noupdate -format Logic  -color red     /zvh_260_TT_vhd_tst/SET_n
add wave -noupdate -format Logic  -color yellow  /zvh_260_TT_vhd_tst/T
add wave -noupdate -divider {Interne Signale}
add wave -noupdate -format Logic  -color yellow  /zvh_260_TT_vhd_tst/i1/T_n
add wave -noupdate -format Logic  -color red     /zvh_260_TT_vhd_tst/i1/C
add wave -noupdate -format Logic  -color green   /zvh_260_TT_vhd_tst/i1/Q
add wave -noupdate -format Logic  -color white   /zvh_260_TT_vhd_tst/i1/Q_n
add wave -noupdate -divider {Ausgangssignal}
add wave -noupdate -format Logic  -color blue   /zvh_260_TT_vhd_tst/Q
#
run 800 ns
wave zoomfull
# end of simulation waveform generation
