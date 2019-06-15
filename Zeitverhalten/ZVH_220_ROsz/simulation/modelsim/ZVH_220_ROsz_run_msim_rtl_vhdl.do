transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {../../NAND2_V.vhd}

do "ZVH_ROsz_specific_msim.do"
