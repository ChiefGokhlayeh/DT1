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
-- CREATED		"Sun May 19 19:36:55 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ZVH_240_FImp IS 
	PORT
	(
		A :  IN  STD_LOGIC;
		S :  IN  STD_LOGIC;
		B :  IN  STD_LOGIC;
		Y :  OUT  STD_LOGIC
	);
END ZVH_240_FImp;

ARCHITECTURE bdf_type OF ZVH_240_FImp IS 

COMPONENT not_v
GENERIC (TP_HL : INTEGER;
			TP_LH : INTEGER
			);
	PORT(IN1 : IN STD_LOGIC;
		 OUTP : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT nand2_v
GENERIC (TP_HL : INTEGER;
			TP_LH : INTEGER
			);
	PORT(IN1 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 OUTP : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	X0 :  STD_LOGIC;
SIGNAL	X1 :  STD_LOGIC;
SIGNAL	X2 :  STD_LOGIC;
SIGNAL	X3 :  STD_LOGIC;


BEGIN 



b2v_U1_1 : not_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => S,
		 OUTP => X0);


b2v_U3_1 : nand2_v
GENERIC MAP(TP_HL => 1,
			TP_LH => 1
			)
PORT MAP(IN1 => X0,
		 IN2 => X0,
		 OUTP => X1);


b2v_U3_2 : nand2_v
GENERIC MAP(TP_HL => 1,
			TP_LH => 1
			)
PORT MAP(IN1 => X1,
		 IN2 => A,
		 OUTP => X3);


b2v_U3_3 : nand2_v
GENERIC MAP(TP_HL => 1,
			TP_LH => 1
			)
PORT MAP(IN1 => B,
		 IN2 => X0,
		 OUTP => X2);


b2v_U3_4 : nand2_v
GENERIC MAP(TP_HL => 1,
			TP_LH => 1
			)
PORT MAP(IN1 => X2,
		 IN2 => X3,
		 OUTP => Y);


END bdf_type;