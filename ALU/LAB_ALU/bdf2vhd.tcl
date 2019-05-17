###############################################################################
# bdf2vhd.tcl
#
#  Digitaltechnik 2
#  (c) 2009 R.Keller, W.Lindermeir, W.Zimmermann
#  Hochschule Esslingen
#  Author:  Walter Lindermeir, 4.12.2009
#
###############################################################################

package require ::quartus::flow

puts "Executing quartus_map for CA12_ALU.vhd generation ...."
execute_module -tool map -args "--read_settings_files=on --write_settings_files=off --convert_bdf_to_vhdl=CA12_ALU.bdf"


