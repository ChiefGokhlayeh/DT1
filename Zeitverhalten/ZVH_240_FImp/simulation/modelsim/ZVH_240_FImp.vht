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
-- Generated on "05/31/2010 15:12:49"
                                                            
-- Vhdl Test Bench template for design  :  ZVH_240_FImp
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

ENTITY ZVH_240_FImp_vhd_tst IS
END ZVH_240_FImp_vhd_tst;
ARCHITECTURE ZVH_240_FImp_arch OF ZVH_240_FImp_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL A : STD_LOGIC;
SIGNAL B : STD_LOGIC;
SIGNAL S : STD_LOGIC;
SIGNAL Y : STD_LOGIC;
COMPONENT ZVH_240_FImp
	PORT (
	A : IN STD_LOGIC;
	B : IN STD_LOGIC;
	S : IN STD_LOGIC;
	Y : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : ZVH_240_FImp
	PORT MAP (
-- list connections between master ports and signals
	A => A,
	B => B,
	S => S,
	Y => Y
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
-- Signale A und B
--
Sig_AB: PROCESS 
BEGIN
  A <= '0';
  B <= '0';
  wait;
END PROCESS Sig_AB;
--
-- Signal S (Taktsignal)
--
Sig_S: PROCESS 
BEGIN
  --S <= '1'; wait for 500 ns;
  S <= '1'; wait for 480 ns;
  S <= '0'; wait for   1 ns; -- Spike für Inertial-Simulation 
  S <= '1'; wait for  19 ns;
  S <= '0'; wait for 500 ns;
END PROCESS Sig_S;
--
END ZVH_240_FImp_arch;
