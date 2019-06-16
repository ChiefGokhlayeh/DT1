-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Sat Jun 15 14:12:01 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ZVH_220_ROsz IS 
	PORT
	(
		Reset_n :  IN  STD_LOGIC;
		Y_Out :  OUT  STD_LOGIC
	);
END ZVH_220_ROsz;

ARCHITECTURE bdf_type OF ZVH_220_ROsz IS 

COMPONENT nand2_v
GENERIC (TP_HL : INTEGER;
			TP_LH : INTEGER
			);
	PORT(IN1 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 OUTP : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	X1 :  STD_LOGIC;
SIGNAL	X2 :  STD_LOGIC;
SIGNAL	X3 :  STD_LOGIC;


BEGIN 



b2v_U3_1 : nand2_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => Reset_n,
		 IN2 => X3,
		 OUTP => X1);


b2v_U3_2 : nand2_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => X1,
		 IN2 => X1,
		 OUTP => X2);


b2v_U3_3 : nand2_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => X2,
		 IN2 => X2,
		 OUTP => X3);

Y_Out <= X3;

END bdf_type;