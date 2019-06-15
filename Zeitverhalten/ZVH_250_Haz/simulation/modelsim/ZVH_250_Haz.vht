-- Copyright (C) 1991-2010 Altera Corporation
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
-- Generated on "05/31/2010 17:08:48"
                                                            
-- Vhdl Test Bench template for design  :  ZVH_250_Haz
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 
--
-- Hochschule Esslingen, Fakultät IT
-- Copyright W. Zimmermann, W. Lindermeir, R. Keller   04/2010
-- Letzte Änderung: R. Keller  03/2019
--
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY ZVH_250_Haz_vhd_tst IS
END ZVH_250_Haz_vhd_tst;
ARCHITECTURE ZVH_250_Haz_arch OF ZVH_250_Haz_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL D : STD_LOGIC;
SIGNAL Q : STD_LOGIC;
SIGNAL T : STD_LOGIC;
COMPONENT ZVH_250_Haz
	PORT (
	D : IN STD_LOGIC;
	Q : OUT STD_LOGIC;
	T : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : ZVH_250_Haz
	PORT MAP (
-- list connections between master ports and signals
	D => D,
	Q => Q,
	T => T
	);
--init : PROCESS                                               
---- variable declarations                                     
--BEGIN                                                        
--        -- code that executes only once                      
--WAIT;                                                       
--END PROCESS init;                                           
--always : PROCESS                                              
---- optional sensitivity list                                  
---- (        )                                                 
---- variable declarations                                      
--BEGIN                                                         
--        -- code executes for every event on sensitivity list  
--WAIT;                                                        
--END PROCESS always;                                          
--
-- Signal T (Taktsignal)
--
Sig_T: PROCESS 
BEGIN
  T <= '0'; wait for 100 ns;
  T <= '1'; wait for 100 ns;
END PROCESS Sig_T;
--
--
-- Signal D 
--
Sig_D: PROCESS 
BEGIN
  D <= '1'; wait for 350 ns;
  D <= '0'; wait for 400 ns;
  D <= '1'; wait for 300 ns;
  D <= '0'; wait for 200 ns;
  D <= '1'; wait for 250 ns;
END PROCESS Sig_D;
--
END ZVH_250_Haz_arch;
