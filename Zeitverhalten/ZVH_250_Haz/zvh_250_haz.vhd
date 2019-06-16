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
-- CREATED		"Sat Jun 15 14:10:38 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ZVH_250_Haz IS 
	PORT
	(
		D :  IN  STD_LOGIC;
		T :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC
	);
END ZVH_250_Haz;

ARCHITECTURE bdf_type OF ZVH_250_Haz IS 

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

SIGNAL	A :  STD_LOGIC;
SIGNAL	B :  STD_LOGIC;
SIGNAL	C :  STD_LOGIC;
SIGNAL	Q_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	X1 :  STD_LOGIC;


BEGIN 



b2v_U1_1 : not_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => T,
		 OUTP => C);


b2v_U3_1 : nand2_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => C,
		 IN2 => C,
		 OUTP => X1);


b2v_U3_2 : nand2_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => X1,
		 IN2 => Q_ALTERA_SYNTHESIZED,
		 OUTP => B);


b2v_U3_3 : nand2_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => D,
		 IN2 => C,
		 OUTP => A);


b2v_U3_4 : nand2_v
GENERIC MAP(TP_HL => 5,
			TP_LH => 5
			)
PORT MAP(IN1 => A,
		 IN2 => B,
		 OUTP => Q_ALTERA_SYNTHESIZED);

Q <= Q_ALTERA_SYNTHESIZED;

END bdf_type;