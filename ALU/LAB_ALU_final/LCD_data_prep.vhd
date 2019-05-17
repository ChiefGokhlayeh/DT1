-- WARNING: Do NOT edit the input and output ports in this file in a text
-- editor if you plan to continue editing the block that represents it in
-- the Block Editor! File corruption is VERY likely to occur.

-- Copyright (C) 1991-2004 Altera Corporation
-- Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
-- support information,  device programming or simulation file,  and any other
-- associated  documentation or information  provided by  Altera  or a partner
-- under  Altera's   Megafunction   Partnership   Program  may  be  used  only
-- to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
-- other  use  of such  megafunction  design,  netlist,  support  information,
-- device programming or simulation file,  or any other  related documentation
-- or information  is prohibited  for  any  other purpose,  including, but not
-- limited to  modification,  reverse engineering,  de-compiling, or use  with
-- any other  silicon devices,  unless such use is  explicitly  licensed under
-- a separate agreement with  Altera  or a megafunction partner.  Title to the
-- intellectual property,  including patents,  copyrights,  trademarks,  trade
-- secrets,  or maskworks,  embodied in any such megafunction design, netlist,
-- support  information,  device programming or simulation file,  or any other
-- related documentation or information provided by  Altera  or a megafunction
-- partner, remains with Altera, the megafunction partner, or their respective
-- licensors. No other licenses, including any licenses needed under any third
-- party's intellectual property, are provided herein.


-- Generated by Quartus II Version 4.2 (Build Build 157 12/07/2004)
-- Created on Thu Feb 17 08:30:26 2005

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.alu_types.all;

--  Entity Declaration


--  Digitaltechnik 2
--  (c) 2007 R.Keller, W.Lindermeir, W.Zimmermann
--  Hochschule Esslingen
--  Letzte Aenderung: W. Lindermeir, 11/07


ENTITY LCD_data_prep IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	GENERIC(enable_lcd : integer := 1 );
	PORT
	(
		ALU_result : IN STD_LOGIC_VECTOR(7 downto 0);
		ALU_in1 : IN STD_LOGIC_VECTOR(7 downto 0);
		ALU_in2 : IN STD_LOGIC_VECTOR(7 downto 0);
		clk : IN STD_LOGIC;
		LCD_ready : IN STD_LOGIC;
		next_stim_n : IN STD_LOGIC;
		prev_stim_n : IN STD_LOGIC;
		ALU_func : IN STD_LOGIC_VECTOR(3 downto 0);
		result_ok_n : IN STD_LOGIC;
		ALU_cozn : IN STD_LOGIC_VECTOR(3 downto 0);
		LCD_data : OUT STD_LOGIC_VECTOR(255 downto 0);
		refresh : OUT STD_LOGIC
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!
	
END LCD_data_prep;


--  Architecture Body

ARCHITECTURE LCD_data_prep_architecture OF LCD_data_prep IS

pure function char2ascii ( char : in character ) return std_logic_vector is
begin
  return std_logic_vector( to_unsigned(character'pos(char), 8));
end function char2ascii;

pure function hex2ascii (nibble : in std_logic_vector(3 downto 0) ) return std_logic_vector is
  variable ret : std_logic_vector(7 downto 0);
begin
  case nibble is
     when "0000" => ret := char2ascii('0');
     when "0001" => ret := char2ascii('1');
     when "0010" => ret := char2ascii('2');
     when "0011" => ret := char2ascii('3');
     when "0100" => ret := char2ascii('4');
     when "0101" => ret := char2ascii('5');
     when "0110" => ret := char2ascii('6');
     when "0111" => ret := char2ascii('7');
     when "1000" => ret := char2ascii('8');
     when "1001" => ret := char2ascii('9');
     when "1010" => ret := char2ascii('A');
     when "1011" => ret := char2ascii('b');
     when "1100" => ret := char2ascii('C');
     when "1101" => ret := char2ascii('d');
     when "1110" => ret := char2ascii('E');
     when "1111" => ret := char2ascii('F');
     when others => ret := char2ascii('X');
  end case;
  return ret;
end function hex2ascii;
	
pure function bit2ascii (input_bit : in std_logic) return std_logic_vector is
  variable ret : std_logic_vector(7 downto 0);
begin
  case input_bit is
     when '0'    => ret := char2ascii('0');
     when '1'    => ret := char2ascii('1');
     when others => ret := char2ascii('X');
  end case;
  return ret;
end function bit2ascii;

BEGIN

-- generieren eines Startzeichens fuer den LCD Controller
refresh  <= '1' when enable_lcd = 1 and LCD_ready = '1' and (next_stim_n = '0' or prev_stim_n = '0') else 
            '0';

-- obere Zeile: Z.B.   "O1:FF O2:FF ADDI"  (die letzen 4 characters f�r den Instruction code spaeter!)
LCD_data(255 downto 160) <= 
   char2ascii('O') & char2ascii('1') & char2ascii(':') & hex2ascii(ALU_in1(7 downto 4)) & hex2ascii(ALU_in1(3 downto 0)) & 
   char2ascii(' ') &
   char2ascii('O') & char2ascii('2') & char2ascii(':') & hex2ascii(ALU_in2(7 downto 4)) & hex2ascii(ALU_in2(3 downto 0)) & 
   char2ascii(' '); 

-- letzte vier Zeichen der ersten Zeile fuer den Memnonic des Alu Instruction codes
memnonic:
process (ALU_func) is
begin
  case ALU_func is
     when alu_add     => LCD_data(159 downto 128) <= char2ascii('A') & char2ascii('D') & char2ascii('D') & char2ascii(' ');
     when alu_add_c   => LCD_data(159 downto 128) <= char2ascii('A') & char2ascii('D') & char2ascii('D') & char2ascii('C');
     when alu_sub     => LCD_data(159 downto 128) <= char2ascii('S') & char2ascii('U') & char2ascii('B') & char2ascii(' ');
     when alu_sub_b   => LCD_data(159 downto 128) <= char2ascii('S') & char2ascii('U') & char2ascii('B') & char2ascii('B');
     when alu_and     => LCD_data(159 downto 128) <= char2ascii('A') & char2ascii('N') & char2ascii('D') & char2ascii(' ');
     when alu_or      => LCD_data(159 downto 128) <= char2ascii('O') & char2ascii('R') & char2ascii(' ') & char2ascii(' ');
     when alu_xor     => LCD_data(159 downto 128) <= char2ascii('X') & char2ascii('O') & char2ascii('R') & char2ascii(' ');
     when alu_sll     => LCD_data(159 downto 128) <= char2ascii('S') & char2ascii('L') & char2ascii('L') & char2ascii(' ');
     when alu_srl     => LCD_data(159 downto 128) <= char2ascii('S') & char2ascii('R') & char2ascii('L') & char2ascii(' ');
     when alu_sra     => LCD_data(159 downto 128) <= char2ascii('S') & char2ascii('R') & char2ascii('A') & char2ascii(' ');
     when alu_pass_s1 => LCD_data(159 downto 128) <= char2ascii('I') & char2ascii('D') & char2ascii('O') & char2ascii('1');
     when alu_pass_s2 => LCD_data(159 downto 128) <= char2ascii('I') & char2ascii('D') & char2ascii('O') & char2ascii('2');
     when alu_inc     => LCD_data(159 downto 128) <= char2ascii('I') & char2ascii('N') & char2ascii('C') & char2ascii(' ');
     when alu_dec     => LCD_data(159 downto 128) <= char2ascii('D') & char2ascii('E') & char2ascii('C') & char2ascii(' ');
     when others      => LCD_data(159 downto 128) <= char2ascii('E') & char2ascii('R') & char2ascii('R') & char2ascii(' ');
  end case;
end process memnonic;

-- untere Zeile: Z.B.  "R:FF C0O0Z0N0 FA"
--               oder  "R:FF C0O0Z0N0 OK" 
LCD_data(127 downto 16) <= 
   char2ascii('R') & char2ascii(':') & hex2ascii(ALU_result(7 downto 4)) & hex2ascii(ALU_result(3 downto 0)) & 
   char2ascii(' ') &
   char2ascii('C') & bit2ascii(ALU_cozn(3)) & 
   char2ascii('O') & bit2ascii(ALU_cozn(2)) & 
   char2ascii('Z') & bit2ascii(ALU_cozn(1)) & 
   char2ascii('N') & bit2ascii(ALU_cozn(0)) & 
   char2ascii(' ');

LCD_data(15 downto 0) <= char2ascii('O') & char2ascii('K') when result_ok_n = '0' else
                         char2ascii('F') & char2ascii('A');

 
END LCD_data_prep_architecture;