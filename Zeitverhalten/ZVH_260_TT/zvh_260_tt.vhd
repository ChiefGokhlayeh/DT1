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
-- CREATED		"Sat Jun 15 14:19:45 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ZVH_260_TT IS 
	PORT
	(
		T :  IN  STD_LOGIC;
		CLR_n :  IN  STD_LOGIC;
		SET_n :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC
	);
END ZVH_260_TT;

ARCHITECTURE bdf_type OF ZVH_260_TT IS 

COMPONENT not_v
GENERIC (TP_HL : INTEGER;
			TP_LH : INTEGER
			);
	PORT(IN1 : IN STD_LOGIC;
		 OUTP : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT jkff_v
GENERIC (TP_CLK_Q_HL : INTEGER;
			TP_CLK_Q_LH : INTEGER;
			TP_CLK_Qn_HL : INTEGER;
			TP_CLK_Qn_LH : INTEGER
			);
	PORT(J : IN STD_LOGIC;
		 K : IN STD_LOGIC;
		 SET_n : IN STD_LOGIC;
		 CLR_n : IN STD_LOGIC;
		 CLK_n : IN STD_LOGIC;
		 Q : OUT STD_LOGIC;
		 Q_n : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	C :  STD_LOGIC;
SIGNAL	Q_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	Q_n :  STD_LOGIC;
SIGNAL	T_n :  STD_LOGIC;


BEGIN 



b2v_U1_1 : not_v
GENERIC MAP(TP_HL => 7,
			TP_LH => 7
			)
PORT MAP(IN1 => T,
		 OUTP => T_n);


b2v_U1_2 : not_v
GENERIC MAP(TP_HL => 7,
			TP_LH => 7
			)
PORT MAP(IN1 => T_n,
		 OUTP => C);


b2v_U8_Mod : jkff_v
GENERIC MAP(TP_CLK_Q_HL => 7,
			TP_CLK_Q_LH => 7,
			TP_CLK_Qn_HL => 7,
			TP_CLK_Qn_LH => 7
			)
PORT MAP(J => Q_n,
		 K => Q_ALTERA_SYNTHESIZED,
		 SET_n => SET_n,
		 CLR_n => CLR_n,
		 CLK_n => C,
		 Q => Q_ALTERA_SYNTHESIZED,
		 Q_n => Q_n);

Q <= Q_ALTERA_SYNTHESIZED;

END bdf_type;