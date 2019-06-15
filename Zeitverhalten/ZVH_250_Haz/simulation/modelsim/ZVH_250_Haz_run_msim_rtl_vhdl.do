transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {../../NOT_V.vhd}
vcom -93 -work work {../../NAND2_V.vhd}

do "ZVH_Haz_specific_msim.do"
