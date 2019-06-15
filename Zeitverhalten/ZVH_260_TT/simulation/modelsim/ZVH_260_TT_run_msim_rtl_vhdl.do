transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {../../NOT_V.vhd}
vcom -93 -work work {../../JKFF_V.vhd}

do "ZVH_TT_specific_msim.do"
