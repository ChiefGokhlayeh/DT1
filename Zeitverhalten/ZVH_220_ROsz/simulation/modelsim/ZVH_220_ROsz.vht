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
-- Generated on "05/30/2010 23:00:07"
                                                            
-- Vhdl Test Bench template for design  :  ZVH_220_ROsz
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY ZVH_220_ROsz_vhd_tst IS
END ZVH_220_ROsz_vhd_tst;
ARCHITECTURE ZVH_220_ROsz_arch OF ZVH_220_ROsz_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL Reset_n : STD_LOGIC;
SIGNAL Y_Out : STD_LOGIC;
COMPONENT ZVH_220_ROsz
	PORT (
	Reset_n : IN STD_LOGIC;
	Y_Out : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : ZVH_220_ROsz
	PORT MAP (
-- list connections between master ports and signals
	Reset_n => Reset_n,
	Y_Out => Y_Out
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
-- Resetgenerator
ResetGen: PROCESS
BEGIN   
        Reset_n <= '0';                                                      
        wait for 20 ns;
        Reset_n <= '1';  
        wait;                                                     
END PROCESS ResetGen; 
--                                   
END ZVH_220_ROsz_arch;
