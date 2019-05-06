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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to
-- suit user's needs .Comments are provided in each section to help the user
-- fill out necessary details.
-- ***************************************************************************
-- Generated on "05/06/2019 20:23:47"

-- Vhdl Test Bench template for design  :  LAB_7_Seg_final
--
-- Simulation tool : ModelSim-Altera (VHDL)
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

ENTITY LAB_7_Seg_final_vhd_tst IS
END LAB_7_Seg_final_vhd_tst;
ARCHITECTURE LAB_7_Seg_final_arch OF LAB_7_Seg_final_vhd_tst IS
-- constants
-- signals
SIGNAL buttons : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL seven_segs : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL state : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT LAB_7_Seg_final
	PORT (
	buttons : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	clk : IN STD_LOGIC;
	seven_segs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	state : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : LAB_7_Seg_final
	PORT MAP (
-- list connections between master ports and signals
	buttons => buttons,
	clk => clk,
	seven_segs => seven_segs,
	state => state
	);

	clk_gen : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
	END PROCESS clk_gen;

	init : PROCESS
	BEGIN
		--reset <= '0';
		WAIT FOR 10 ns;
		--reset <= '1';
		WAIT FOR 30 ns;
		--reset <= '0';
		WAIT;
	END PROCESS init;

	always : PROCESS
	BEGIN
	WAIT;
	END PROCESS always;

	buttons_gen : PROCESS
		VARIABLE i : integer;
	BEGIN
		buttons <= "1111";
		FOR i IN 0 TO 15 LOOP
			WAIT FOR 100 ns;
			buttons <= NOT(state XOR std_logic_vector(to_unsigned(i, 4)));
			WAIT FOR 100 ns;
			buttons <= "1111";
		END LOOP;
	END PROCESS buttons_gen;

	checker_a : PROCESS(seven_segs)
		VARIABLE i : integer;
	BEGIN
		i := to_integer(unsigned(state));

		IF (i=0 OR i=2 OR i=3 OR i=5 OR i=6 OR i=7 OR i=8 OR i=9 OR i=10 OR i=12 OR i=14 OR i=15) THEN
			ASSERT NOT seven_segs(6) = '1'
				REPORT "segment 'a' leuchtet fälschlich nicht"
				SEVERITY error;
		END IF;
		IF (i=1 OR i=4 OR i=11 OR i=13) THEN
			ASSERT NOT seven_segs(6) = '0'
				REPORT "segment 'a' leuchtet fälschlich"
				SEVERITY error;
		END IF;
	END PROCESS checker_a;

	checker_b : PROCESS(seven_segs)
		VARIABLE i : integer;
	BEGIN
		i := to_integer(unsigned(state));

		IF (i=0 OR i=1 OR i=2 OR i=3 OR i=4 OR i=7 OR i=8 OR i=9 OR i=10 OR i=13) THEN
			ASSERT NOT seven_segs(5) = '1'
				REPORT "segment 'b' leuchtet fälschlich nicht"
				SEVERITY error;
		END IF;
		IF (i=5 OR i=6 OR i=11 OR i=12 OR i=14 OR i=15) THEN
			ASSERT NOT seven_segs(5) = '0'
				REPORT "segment 'b' leuchtet fälschlich"
				SEVERITY error;
		END IF;
	END PROCESS checker_b;
END LAB_7_Seg_final_arch;
