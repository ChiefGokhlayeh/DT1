###############################################################################
# bdf2vhd.tcl
#
#  Digitaltechnik 2
#  (c) 2009 R.Keller, W.Lindermeir, W.Zimmermann
#  Hochschule Esslingen
#  Author:  Reinhard Keller, 25.05.2010
#
###############################################################################

package require ::quartus::flow

puts "Executing quartus_map for *.vhd generation ...."
execute_module -tool map -args "--read_settings_files=on --write_settings_files=off --convert_bdf_to_vhdl=ZVH_260_TT.bdf"

