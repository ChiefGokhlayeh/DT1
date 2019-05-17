-- Copyright (C) 1991-2011 Altera Corporation
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

-- PROGRAM		"Quartus II"
-- VERSION		"Version 10.1 Build 197 01/19/2011 Service Pack 1 SJ Web Edition"
-- CREATED		"Sun Feb 13 13:14:21 2011"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY CA12_ALU IS 
	PORT
	(
		reset_n_button :  IN  STD_LOGIC;
		next_stim_n_button :  IN  STD_LOGIC;
		prev_stim_n_button :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		LCD_DB :  INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		LCD_RW :  OUT  STD_LOGIC;
		LCD_E :  OUT  STD_LOGIC;
		LCD_RS :  OUT  STD_LOGIC;
		result_ok_n :  OUT  STD_LOGIC;
		result_history_ok_n :  OUT  STD_LOGIC;
		ALU_c_in :  OUT  STD_LOGIC;
		seven_segs :  OUT  STD_LOGIC_VECTOR(13 DOWNTO 0)
	);
END CA12_ALU;

ARCHITECTURE bdf_type OF CA12_ALU IS 

COMPONENT alu
	PORT(ALU_c_in : IN STD_LOGIC;
		 ALU_func : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_in1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_in2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_cozn : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dual_seven_seg_dec
	PORT(index_in_stim_file : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 seven_segs : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
	);
END COMPONENT;

COMPONENT entpreller
GENERIC (width : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset_n_button : IN STD_LOGIC;
		 next_stim_n_button : IN STD_LOGIC;
		 prev_stim_n_button : IN STD_LOGIC;
		 reset_n : OUT STD_LOGIC;
		 next_stim_n : OUT STD_LOGIC;
		 prev_stim_n : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lcd_controller
	PORT(refresh : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 LCD_data : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		 LCD_DB : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 LCD_RW : OUT STD_LOGIC;
		 LCD_E : OUT STD_LOGIC;
		 LCD_RS : OUT STD_LOGIC;
		 LCD_ready : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lcd_data_prep
	PORT(clk : IN STD_LOGIC;
		 LCD_ready : IN STD_LOGIC;
		 next_stim_n : IN STD_LOGIC;
		 prev_stim_n : IN STD_LOGIC;
		 result_ok_n : IN STD_LOGIC;
		 ALU_cozn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_func : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_in1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_in2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_result : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 refresh : OUT STD_LOGIC;
		 LCD_data : OUT STD_LOGIC_VECTOR(255 DOWNTO 0)
	);
END COMPONENT;

COMPONENT result_checker
	PORT(reset_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 ALU_cozn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_exp_cozn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_exp_result : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_result : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result_history_ok_n : OUT STD_LOGIC;
		 result_ok_n : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT stimulus_gen
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 next_stim_n : IN STD_LOGIC;
		 prev_stim_n : IN STD_LOGIC;
		 ALU_c_in : OUT STD_LOGIC;
		 ALU_exp_cozn : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_exp_result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_func : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ALU_in1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_in2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 index_in_stim_file : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(255 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 
result_ok_n <= SYNTHESIZED_WIRE_11;
ALU_c_in <= SYNTHESIZED_WIRE_0;



b2v_alu_inst : alu
PORT MAP(ALU_c_in => SYNTHESIZED_WIRE_0,
		 ALU_func => SYNTHESIZED_WIRE_25,
		 ALU_in1 => SYNTHESIZED_WIRE_26,
		 ALU_in2 => SYNTHESIZED_WIRE_27,
		 ALU_cozn => SYNTHESIZED_WIRE_31,
		 ALU_result => SYNTHESIZED_WIRE_32);


b2v_dual_seven_seg_dec_inst : dual_seven_seg_dec
PORT MAP(index_in_stim_file => SYNTHESIZED_WIRE_4,
		 seven_segs => seven_segs);


b2v_entpreller_inst : entpreller
GENERIC MAP(width => 1
			)
PORT MAP(clk => clk,
		 reset_n_button => reset_n_button,
		 next_stim_n_button => next_stim_n_button,
		 prev_stim_n_button => prev_stim_n_button,
		 reset_n => SYNTHESIZED_WIRE_28,
		 next_stim_n => SYNTHESIZED_WIRE_29,
		 prev_stim_n => SYNTHESIZED_WIRE_30);


b2v_LCD_controller_inst : lcd_controller
PORT MAP(refresh => SYNTHESIZED_WIRE_5,
		 clk => clk,
		 reset_n => SYNTHESIZED_WIRE_28,
		 LCD_data => SYNTHESIZED_WIRE_7,
		 LCD_DB => LCD_DB,
		 LCD_RW => LCD_RW,
		 LCD_E => LCD_E,
		 LCD_RS => LCD_RS,
		 LCD_ready => SYNTHESIZED_WIRE_8);


b2v_LCD_data_prep_inst : lcd_data_prep
PORT MAP(clk => clk,
		 LCD_ready => SYNTHESIZED_WIRE_8,
		 next_stim_n => SYNTHESIZED_WIRE_29,
		 prev_stim_n => SYNTHESIZED_WIRE_30,
		 result_ok_n => SYNTHESIZED_WIRE_11,
		 ALU_cozn => SYNTHESIZED_WIRE_31,
		 ALU_func => SYNTHESIZED_WIRE_25,
		 ALU_in1 => SYNTHESIZED_WIRE_26,
		 ALU_in2 => SYNTHESIZED_WIRE_27,
		 ALU_result => SYNTHESIZED_WIRE_32,
		 refresh => SYNTHESIZED_WIRE_5,
		 LCD_data => SYNTHESIZED_WIRE_7);


b2v_result_checker_inst : result_checker
PORT MAP(reset_n => SYNTHESIZED_WIRE_28,
		 clk => clk,
		 ALU_cozn => SYNTHESIZED_WIRE_31,
		 ALU_exp_cozn => SYNTHESIZED_WIRE_19,
		 ALU_exp_result => SYNTHESIZED_WIRE_20,
		 ALU_result => SYNTHESIZED_WIRE_32,
		 result_history_ok_n => result_history_ok_n,
		 result_ok_n => SYNTHESIZED_WIRE_11);


b2v_stimulus_gen_inst : stimulus_gen
PORT MAP(clk => clk,
		 reset_n => SYNTHESIZED_WIRE_28,
		 next_stim_n => SYNTHESIZED_WIRE_29,
		 prev_stim_n => SYNTHESIZED_WIRE_30,
		 ALU_c_in => SYNTHESIZED_WIRE_0,
		 ALU_exp_cozn => SYNTHESIZED_WIRE_19,
		 ALU_exp_result => SYNTHESIZED_WIRE_20,
		 ALU_func => SYNTHESIZED_WIRE_25,
		 ALU_in1 => SYNTHESIZED_WIRE_26,
		 ALU_in2 => SYNTHESIZED_WIRE_27,
		 index_in_stim_file => SYNTHESIZED_WIRE_4);


END bdf_type;