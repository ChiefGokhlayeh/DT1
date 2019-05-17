###############################################################################
# pin_assign.tcl
#
#  Digitaltechnik 2
#  (c) 2007 R.Keller, W.Lindermeir, W.Zimmermann
#  Hochschule Esslingen
#  Author:  Walter Lindermeir, 15.2.2007
#
# You can run this script from Quartus by observing the following steps:
# 1. Place this TCL script in your project directory
# 2. Open your project
# 3. Go to the View Menu and Auxilary Windows -> TCL console
# 4. In the TCL console type:
#						source pin_assign.tcl
# 5. The script will assign pins and return an "assignment made" message.
###############################################################################

set top_name DT_LAB_7_Seg_simple

########## Set the pin location variables ############
### Control Pins
set clk K17
set reset_n AC9

### PIOs
set button_0 W5
set button_1 W6
set button_2 AB2
set button_3 AB1

set seven_seg_1_a   B18
set seven_seg_1_b   B20
set seven_seg_1_c   A20
set seven_seg_1_d   C20
set seven_seg_1_e   A21
set seven_seg_1_f   B21
set seven_seg_1_g   C21
set seven_seg_1_dot D21

set seven_seg_10_a   A18
set seven_seg_10_b   C18
set seven_seg_10_c   D18
set seven_seg_10_d   A19
set seven_seg_10_e   B19
set seven_seg_10_f   C19
set seven_seg_10_g   E19
set seven_seg_10_dot D19

set led_0 H27
set led_1 H28
set led_2 L23
set led_3 L24
set led_4 J25
set led_5 J26
set led_6 L20
set led_7 L19

# prototype connector J12
set lcd_rw   M8
set lcd_rs   M7
set lcd_e    K3
set lcd_db_0 H3
set lcd_db_1 L7
set lcd_db_2 L8
set lcd_db_3 H2
set lcd_db_4 H1
set lcd_db_5 L6
set lcd_db_6 L5
set lcd_db_7 J4

################################################
#### Make the clock and reset_n signal assignments
cmp add_assignment $top_name "" clk LOCATION "Pin_$clk"

#################################
#### Make the PIO pin assignments
cmp add_assignment $top_name "" "next_stim_n_button" LOCATION "Pin_$button_0" 
cmp add_assignment $top_name "" "prev_stim_n_button" LOCATION "Pin_$button_1" 
cmp add_assignment $top_name "" "reset_n_button"     LOCATION "Pin_$button_3" 

#################################
#### Make the LED pin assignments
cmp add_assignment $top_name "" "result_ok_n"         LOCATION "Pin_$led_0" 
cmp add_assignment $top_name "" "ALU_c_in"          LOCATION "Pin_$led_1" 
cmp add_assignment $top_name "" "result_history_ok_n" LOCATION "Pin_$led_7" 

#################################
#### Make the LCD pin assignments

cmp add_assignment $top_name "" "LCD_RW"      LOCATION "Pin_$lcd_rw" 
cmp add_assignment $top_name "" "LCD_RS"      LOCATION "Pin_$lcd_rs" 
cmp add_assignment $top_name "" "LCD_E"       LOCATION "Pin_$lcd_e" 
cmp add_assignment $top_name "" "LCD_DB\[0\]" LOCATION "Pin_$lcd_db_0" 
cmp add_assignment $top_name "" "LCD_DB\[1\]" LOCATION "Pin_$lcd_db_1" 
cmp add_assignment $top_name "" "LCD_DB\[2\]" LOCATION "Pin_$lcd_db_2" 
cmp add_assignment $top_name "" "LCD_DB\[3\]" LOCATION "Pin_$lcd_db_3" 
cmp add_assignment $top_name "" "LCD_DB\[4\]" LOCATION "Pin_$lcd_db_4" 
cmp add_assignment $top_name "" "LCD_DB\[5\]" LOCATION "Pin_$lcd_db_5" 
cmp add_assignment $top_name "" "LCD_DB\[6\]" LOCATION "Pin_$lcd_db_6" 
cmp add_assignment $top_name "" "LCD_DB\[7\]" LOCATION "Pin_$lcd_db_7" 

#################################
#### Make the dual seven segment pin assignments

cmp add_assignment $top_name "" "seven_segs\[0\]" LOCATION  "Pin_$seven_seg_1_g" 
cmp add_assignment $top_name "" "seven_segs\[1\]" LOCATION  "Pin_$seven_seg_1_f" 
cmp add_assignment $top_name "" "seven_segs\[2\]" LOCATION  "Pin_$seven_seg_1_e" 
cmp add_assignment $top_name "" "seven_segs\[3\]" LOCATION  "Pin_$seven_seg_1_d" 
cmp add_assignment $top_name "" "seven_segs\[4\]" LOCATION  "Pin_$seven_seg_1_c" 
cmp add_assignment $top_name "" "seven_segs\[5\]" LOCATION  "Pin_$seven_seg_1_b" 
cmp add_assignment $top_name "" "seven_segs\[6\]" LOCATION  "Pin_$seven_seg_1_a" 

cmp add_assignment $top_name "" "seven_segs\[7\]" LOCATION  "Pin_$seven_seg_10_g"  
cmp add_assignment $top_name "" "seven_segs\[8\]" LOCATION  "Pin_$seven_seg_10_f"  
cmp add_assignment $top_name "" "seven_segs\[9\]" LOCATION  "Pin_$seven_seg_10_e"  
cmp add_assignment $top_name "" "seven_segs\[10\]" LOCATION "Pin_$seven_seg_10_d"  
cmp add_assignment $top_name "" "seven_segs\[11\]" LOCATION "Pin_$seven_seg_10_c"  
cmp add_assignment $top_name "" "seven_segs\[12\]" LOCATION "Pin_$seven_seg_10_b"  
cmp add_assignment $top_name "" "seven_segs\[13\]" LOCATION "Pin_$seven_seg_10_a"  







#################################
# ab hier werden nur nicht benutzte Pins auf Anschluesse gelegt, so dass nicht 
# irgendwelche LEDs etc verwirred blinken ...


# Expansion prototype connector 1
# J11
# 1 reset_n
# 2 GND
set J11_3  P3
set J11_4  N10
set J11_5  N9
set J11_6  M2
set J11_7  N1
set J11_8  N5
set J11_9  N6
set J11_10 M3
set J11_11 M4
set J11_12 N7
set J11_13 N8
set J11_14 L1
set J11_15 L2
set J11_16 N4
set J11_17 N3
set J11_18 L3
# 19 GND
# 20 NC
set J11_21 L4
# 22 GND
set J11_23 M10
# 24 GND
set J11_25 M9
# 26 GND
set J11_27 K1
set J11_28 K2
set J11_29 M6
# 30 GND
set J11_31 M5
set J11_32 K4
set J11_33 J3
# 34 NC
set J11_35 L9
set J11_36 L10
set J11_37 J2
set J11_38 G1
set J11_39 J1
# 40 GND

# Expansion prototype connector 2
# J16
# 1 reset_n
# 2 GND
set J16_3  AD19 
set J16_4  AE19
set J16_5  AF18 
set J16_6  AH20
set J16_7  AH21 
set J16_8  AF20 
set J16_9  AE20 
set J16_10 AF21
set J16_11 AG21
set J16_12 AE21
set J16_13 AD21
set J16_14 AG20
set J16_15 AG22
set J16_16 AH22
set J16_17 AF22
set J16_18 AE22
# 19 GND
# 20 NC
set J16_21 AH23
# 22 GND
set J16_23 AF23
# 24 GND
set J16_25 AD23
# 26 GND
set J16_27 AG23
set J16_28 AE23
set J16_29 AH24
# 30 GND
set J16_31 AE24
set J16_32 AG24
set J16_33 AF25
# 34 NC
set J16_35 AH25
set J16_36 AG25
set J16_37 AH26
set J16_38 AB18
set J16_39 AG26
# 40 GND

