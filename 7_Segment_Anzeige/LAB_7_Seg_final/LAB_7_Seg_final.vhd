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
-- CREATED		"Mon May 06 21:18:38 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY LAB_7_Seg_final IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		buttons :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		seven_segs :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		state :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END LAB_7_Seg_final;

ARCHITECTURE bdf_type OF LAB_7_Seg_final IS 

COMPONENT entpreller
	PORT(clk : IN STD_LOGIC;
		 buttons : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 buttons_entprellt : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT seven_seg_dec
	PORT(state : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 seven_segs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT toggle_reg
	PORT(clk : IN STD_LOGIC;
		 buttons_entprellt : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 state : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN 
state <= SYNTHESIZED_WIRE_0;



b2v_inst : entpreller
PORT MAP(clk => clk,
		 buttons => buttons,
		 buttons_entprellt => SYNTHESIZED_WIRE_1);


b2v_inst3 : seven_seg_dec
PORT MAP(state => SYNTHESIZED_WIRE_0,
		 seven_segs => seven_segs);


b2v_inst4 : toggle_reg
PORT MAP(clk => clk,
		 buttons_entprellt => SYNTHESIZED_WIRE_1,
		 state => SYNTHESIZED_WIRE_0);


END bdf_type;