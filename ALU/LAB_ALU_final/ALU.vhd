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
-- Created on Thu Feb 17 08:12:55 2005

--  Digitaltechnik 2
--  (c) 2007 R.Keller, W.Lindermeir, W.Zimmermann
--  Hochschule Esslingen
--  Letzte Aenderung: W. Lindermeir, 11/07


LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity halbaddierer is
  port(a, b : in  std_logic;
       s, u : out std_logic  );
end halbaddierer;

architecture behav of halbaddierer is
begin
  s <= (a nor b) nor (a and b);
  u <= a and b;
end behav;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity volladdierer is
  port(a, b, adder_c_in : in  std_logic;
       s, c_out   : out std_logic   );
end volladdierer;

architecture behav of volladdierer is
signal s_ha1 : std_logic;
signal u_ha1 : std_logic;
signal u_ha2 : std_logic;
begin
ha1: entity work.halbaddierer
     port map ( a => a, b => b, s => s_ha1, u => u_ha1 );
  
ha2: entity work.halbaddierer
     port map ( a => s_ha1, b => adder_c_in, s => s, u => u_ha2 );

c_out <= u_ha1 or u_ha2;
end behav;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity word_adder is
  generic (n : natural := 8 );
  port( adder_c_in   : in std_logic;
        op1    : in std_logic_vector(n-1 downto 0);
        op2    : in std_logic_vector(n-1 downto 0);
        result : out std_logic_vector(n-1 downto 0);
        c_prev : out std_logic;
        c_out  : out std_logic       );
end word_adder;

architecture addierer_architecture of word_adder is
signal c : std_logic_vector(n-1 downto 0);
begin

wordadd: for posindex in 0 to n-1 generate
begin
  cell_0: if posindex = 0 generate
  begin
  bitpos0: entity work.volladdierer
           port map ( a => op1(0), b => op2(0), adder_c_in => adder_c_in,
                      s => result(0), c_out => c(0) );
  end generate cell_0;

  inner_cell: if posindex > 0 generate 
  begin
  bitpos: entity work.volladdierer
          port map ( a => op1(posindex), b => op2(posindex), adder_c_in => c(posindex-1),
                     s => result(posindex), c_out => c(posindex) );
  end generate inner_cell;
end generate wordadd;

c_out  <= c(n-1);
c_prev <= c(n-2);

end addierer_architecture;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.alu_types.all;

--  Entity Declaration


--  Digitaltechnik 2
--  (c) 2007 R.Keller, W.Lindermeir, W.Zimmermann
--  Hochschule Esslingen
--  Letzte Aenderung: W. Lindermeir, 11/07


ENTITY ALU IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(
		ALU_in1 : IN STD_LOGIC_VECTOR(7 downto 0);
		ALU_in2 : IN STD_LOGIC_VECTOR(7 downto 0);
		ALU_func : IN STD_LOGIC_VECTOR(3 downto 0);
		ALU_c_in : IN STD_LOGIC;
		ALU_result : OUT STD_LOGIC_VECTOR(7 downto 0);
		ALU_cozn : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!
        
END ALU;


--  Architecture Body

ARCHITECTURE ALU_architecture OF ALU IS
signal adder_c_in   : std_logic;
signal c_prev       : std_logic;
signal c_out        : std_logic;
signal adder_op2    : std_logic_vector(7 downto 0);
signal adder_result : std_logic_vector(7 downto 0);
BEGIN
        
-- instanciate wordadder
wordadder: entity work.word_adder
           generic map (n => 8)
           port map (adder_c_in => adder_c_in, op1 => ALU_in1, op2 => adder_op2, result => adder_result, 
                     c_prev => c_prev, c_out => c_out );


       
alu_op: process (ALU_in1, ALU_in2, ALU_c_in, ALU_func, adder_result, c_prev, c_out) is
  variable adder_op2_var     : std_logic_vector(7 downto 0);
  variable result_var        : std_logic_vector(7 downto 0);
  variable carry_var         : std_logic;
  variable overflow_var      : std_logic;
  variable zero_var          : std_logic;
  variable negative_var      : std_logic;
  variable c_in_var          : std_logic;
  variable i                 : natural;
begin

  -- init for wordadder
  c_in_var      := '0';
  adder_op2_var := (others => '0');

  carry_var    := '0';
  overflow_var := '0';
  case ALU_func is
     when alu_inc     => result_var    := adder_result;
                         adder_op2_var := "00000001";
                         carry_var     := c_out;
                         overflow_var  := c_out xor c_prev;     

     when alu_add     => result_var    := adder_result;
                         adder_op2_var := ALU_in2;
                         carry_var     := c_out;
                         overflow_var  := c_out xor c_prev;

     when alu_add_c   => result_var    := adder_result;
                         adder_op2_var := ALU_in2;
                         c_in_var      := ALU_c_in;
                         carry_var     := c_out;
                         overflow_var  := c_out xor c_prev;
     when alu_dec     => result_var    := adder_result;
                         c_in_var      := '1';
                         adder_op2_var := not "00000001";
                         carry_var     := not c_out;
                         overflow_var  := c_out xor c_prev;

     when alu_sub     => result_var    := adder_result;
                         c_in_var      := '1';
                         adder_op2_var := not ALU_in2;
                         carry_var     := not c_out;
                         overflow_var  := c_out xor c_prev;

     when alu_sub_b   => result_var    := adder_result;
                         c_in_var      := not ALU_c_in;
                         adder_op2_var := not ALU_in2;
                         carry_var     := not c_out;
                         overflow_var  := c_out xor c_prev;

     when alu_and     => result_var := ALU_in1 AND ALU_in2;  
     when alu_or      => result_var := ALU_in1 OR  ALU_in2;  
     when alu_xor     => result_var := ALU_in1 XOR ALU_in2;  
     when alu_sll     => i := to_integer(unsigned(ALU_in2(3 downto 0)));
                         result_var := ALU_in1;
                         for index in 0 to 7 loop
                           if index < i then
                              -- determine carry condition flag
                              carry_var := carry_var or result_var(7);
                              -- determine overflow condition flag
                              overflow_var := overflow_var or (result_var(7) xor result_var(6));
                              result_var := to_stdlogicvector(to_bitvector(result_var) sll 1);
                           end if;
                         end loop;

     when alu_srl     => i := to_integer(unsigned(ALU_in2(3 downto 0)));
                         result_var := ALU_in1;
                         result_var := to_stdlogicvector(to_bitvector(result_var) srl i);

     when alu_sra     => i := to_integer(unsigned(ALU_in2(3 downto 0)));
                         result_var := ALU_in1;
                         result_var := to_stdlogicvector(to_bitvector(result_var) sra i);

     when alu_pass_s1 => result_var := ALU_in1;  

     when alu_pass_s2 => result_var := ALU_in2;  

     when others      => report "illegal function code"
                           severity note;
                         result_var := (others => '0');  
  end case;
 
  zero_var     := to_stdulogic(bit'val(boolean'pos(result_var = "00000000")));
  negative_var := result_var(7);

  ALU_result <= result_var;
  ALU_cozn   <= carry_var & overflow_var & zero_var & negative_var;

  -- wordadder assignments
  adder_c_in <= c_in_var;
  adder_op2  <= adder_op2_var;

end process alu_op;


END ALU_architecture;