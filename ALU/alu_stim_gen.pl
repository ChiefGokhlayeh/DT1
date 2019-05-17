#!/usr/bin/perl -w
#!/contrib/bin/perl -w
use strict;
use vars qw($opt_s $opt_d $opt_o);
use Getopt::Std;
###########################################################################
##
##  Digitaltechnik 2
##  (c) 2007 R.Keller, W.Lindermeir, W.Zimmermann
##  Hochschule Esslingen
##  Author:  Walter Lindermeir, 15.2.2007
##
###########################################################################
# Dieses perl Skript generiert die Stimuli für das CA1 Labor ALU
###########################################################################

##
## variables
##

my $myname = $0;
my $usage = "Usage:\n" .
            "\t$myname -d -o func_name -s no_stimuli\n" .
            "\t-s number\tNumber of stimuli to be generated\n" .
            "\t-o func_name\tgenerate only stimuli for func_name (optional)\n" .
            "\t-d Debug mode\t(optional)";
my $no_stim;
my $i;
my $j;
my $sign;
my $op1_ext;
my $op2_ext;
my $op1;
my $op2;
my $c_in;
my $func;
my $alu_res;
my $alu_res_ext;
my ($alu_stat_z, $alu_stat_n, $alu_stat_o, $alu_stat_c);
# bit masks
my $mask_bit_7      = hex("80");
my $mask_bit_8      = hex("100");
my $mask_bit_3_to_0 = hex("0F");
my $mask_bit_7_to_0 = hex("FF");
my $mask_bit_8_to_0 = hex("1FF");
# func code
my $func_select_memnonic;
my $func_select_code;
my @func_arr = (  ["alu_add"     ,  0],  #  "0000" 
                  ["alu_add_c"   ,  1],  #  "0001" 
                  ["alu_sub"     ,  2],  #  "0010" 
                  ["alu_sub_b"   ,  3],  #  "0011" 
                  ["alu_and"     ,  4],  #  "0100" 
                  ["alu_or"      ,  5],  #  "0101" 
                  ["alu_xor"     ,  6],  #  "0110" 
                  ["undefed"     ,  7],  #  "0111" 
                  ["alu_sll"     ,  8],  #  "1000" 
                  ["alu_srl"     ,  9],  #  "1001" 
                  ["alu_sra"     , 10],  #  "1010" 
                  ["undefed"     , 11],  #  "1011" 
                  ["alu_pass_s1" , 12],  #  "1100" 
                  ["alu_pass_s2" , 13],  #  "1101" 
                  ["undefed"     , 14],  #  "1110" 
                  ["undefed"     , 15],  #  "1111" 
   );

#
# beginning of main routine
#

# check for correct invocation
$myname =~ s%.*/%%;
$opt_s = -1;
getopts('ds:o:') || die ($usage);
$no_stim = $opt_s;
(@ARGV == 0 && $no_stim > 0) || die ($usage);

# initialize seed for rand
srand(time() ^ ($$ + ($$<<15)));
#srand(5);  

# generate required number of stimuli 
stim:
for($i=0; $i < $no_stim; $i++){
  # randomly generate operands for alu
  $op1  = int(rand(256)); 
  $op2  = int(rand(256));
  $func = int(rand(16));
  $c_in = int(rand(2));

  # initialize flags
  $alu_stat_o = 0;
  $alu_stat_c = 0;

  # get random or determined alu function memnonic and code 
  if( $opt_o ){
    $func_select_memnonic = $opt_o;
    for($j=0; $j <= $#func_arr; $j++){
      if($opt_o =~ m/^$func_arr[$j][0]$/){
        $func_select_code = $func_arr[$j][1];
      }
    }
  }else{
    $func_select_memnonic = $func_arr[$func][0];
    $func_select_code     = $func_arr[$func][1];
  }

  # now decide what to do
  for( $func_select_memnonic ){
    /^alu_add$/       && do {
                              # add the two operands
                              $alu_res = $op1 + $op2;
                              #
                              # cut $alu_res to bits 7..0
                              $alu_res = $alu_res & $mask_bit_7_to_0;   
                              #
                              # determine carry condition flag on difference in results 
                              $alu_stat_c =  ($op1 + $op2) != $alu_res;
                              #
                              # determine overflow condition flag
                              #
                              # sign extend op1, op2 and result
                              $op1_ext     = sign_extend($op1);
                              $op2_ext     = sign_extend($op2);
                              $alu_res_ext = sign_extend($alu_res);

                              # overflow condition if difference in results
                              $alu_stat_o = ($op1_ext + $op2_ext) != $alu_res_ext;

                              # debug
                              if( $opt_d ){
                                printf("\n\n");
                                printf("DEBUG: alu_add UNsigned\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t+%4d\t%40s\n", $op2, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1 + $op2), int2bitstring(($op1 + $op2), 8) ); 
                                printf("DEBUG:\n");
                                printf("DEBUG: alu_add signed\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1_ext, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t+%4d\t%40s\n", $op2_ext, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res_ext, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1_ext + $op2_ext), int2bitstring(($op1_ext + $op2_ext), 8) ); 
                              }
                        last; };
    /^alu_add_c$/     && do {
                              # add the two operands with input carry condition flag
                              $alu_res = $op1 + $op2 + $c_in;
                              #
                              # cut $alu_res to bits 7..0
                              $alu_res = $alu_res & $mask_bit_7_to_0;   
                              #
                              # determine carry condition flag on difference in results 
                              $alu_stat_c =  ($op1 + $op2 + $c_in) != $alu_res;
                              #
                              # determine overflow condition flag
                              #
                              # sign extend op1, op2 and result -- c_in does not need to be sign extended !!
                              $op1_ext     = sign_extend($op1);
                              $op2_ext     = sign_extend($op2);
                              $alu_res_ext = sign_extend($alu_res);

                              # overflow condition if difference in results
                              $alu_stat_o = ($op1_ext + $op2_ext + $c_in) != $alu_res_ext;

                              # debug
                              if( $opt_d ){
                                printf("\n\n");
                                printf("DEBUG: alu_add_c UNsigned\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t+%4d\t%40s\n", $op2, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \tc_in\t+%4d\t%40s\n", $c_in, int2bitstring($c_in, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1 + $op2 + $c_in), int2bitstring(($op1 + $op2 + $c_in), 8) ); 
                                printf("DEBUG:\n");
                                printf("DEBUG: alu_add_c signed\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1_ext, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t+%4d\t%40s\n", $op2_ext, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \tc_in\t+%4d\t%40s\n", $c_in, int2bitstring($c_in, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res_ext, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1_ext + $op2_ext + $c_in), int2bitstring(($op1_ext + $op2_ext + $c_in), 8) ); 
                              }
                        last; };
    /^alu_sub$/       && do { 
                              # subtract the two operands
                              $alu_res = $op1 - $op2;
                              #
                              # cut $alu_res to bits 7..0
                              $alu_res = $alu_res & $mask_bit_7_to_0;   
                              #
                              # determine carry condition flag on difference in results 
                              $alu_stat_c =  ($op1 - $op2) != $alu_res;
                              #
                              # determine overflow condition flag
                              #
                              # sign extend op1, op2 and result
                              $op1_ext     = sign_extend($op1);
                              $op2_ext     = sign_extend($op2);
                              $alu_res_ext = sign_extend($alu_res);

                              # overflow condition if difference in results
                              $alu_stat_o = ($op1_ext - $op2_ext) != $alu_res_ext;

                              # debug
                              if( $opt_d ){
                                printf("\n\n");
                                printf("DEBUG: alu_sub UNsigned\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t-%4d\t%40s\n", $op2, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1 - $op2), int2bitstring(($op1 - $op2), 8) ); 
                                printf("DEBUG:\n");
                                printf("DEBUG: alu_sub signed\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1_ext, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t-%4d\t%40s\n", $op2_ext, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res_ext, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1_ext - $op2_ext), int2bitstring(($op1_ext - $op2_ext), 8) ); 
                              }
                        last; };
    /^alu_sub_b$/     && do { 
                              # subtract the two operands with input carry condition flag
                              $alu_res = $op1 - $op2 - $c_in;
                              #
                              # cut $alu_res to bits 7..0
                              $alu_res = $alu_res & $mask_bit_7_to_0;   
                              #
                              # determine carry condition flag on difference in results 
                              $alu_stat_c =  ($op1 - $op2 - $c_in) != $alu_res;
                              #
                              # determine overflow condition flag
                              #
                              # sign extend op1, op2 and result -- c_in does not need to be sign extended !!
                              $op1_ext     = sign_extend($op1);
                              $op2_ext     = sign_extend($op2);
                              $alu_res_ext = sign_extend($alu_res);

                              # overflow condition if difference in results
                              $alu_stat_o = ($op1_ext - $op2_ext - $c_in) != $alu_res_ext;

                              # debug
                              if( $opt_d ){
                                printf("\n\n");
                                printf("DEBUG: alu_sub_b UNsigned\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t-%4d\t%40s\n", $op2, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \tc_in\t-%4d\t%40s\n", $c_in, int2bitstring($c_in, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1 - $op2 - $c_in), int2bitstring(($op1 - $op2 - $c_in), 8) ); 
                                printf("DEBUG:\n");
                                printf("DEBUG: alu_sub_b signed\n");
                                printf("DEBUG: \t    \t %4d\t%40s\n", $op1_ext, int2bitstring($op1, 2) ); 
                                printf("DEBUG: \t    \t-%4d\t%40s\n", $op2_ext, int2bitstring($op2, 2) ); 
                                printf("DEBUG: \tc_in\t-%4d\t%40s\n", $c_in, int2bitstring($c_in, 2) ); 
                                printf("DEBUG: \talu \t=%4d\t%40s\n", $alu_res_ext, int2bitstring($alu_res, 2) ); 
                                printf("DEBUG: \tOK  \t=%4d\t%40s\n", ($op1_ext - $op2_ext - $c_in), int2bitstring(($op1_ext - $op2_ext - $c_in), 8) ); 
                              }
                        last; };
    /^alu_and$/       && do {
                              $alu_res = $op1 & $op2;
                        last; };
    /^alu_or$/        && do {
                              $alu_res = $op1 | $op2;
                        last; };
    /^alu_xor$/       && do {
                              $alu_res = $op1 ^ $op2;
                        last; };
    /^alu_sll$/       && do { # shift left logical (fill with zeros)
                              $alu_res = int($op1 * (2**($mask_bit_3_to_0 & $op2)));
                              # cut $alu_res to bits 7..0
                              $alu_res = $alu_res & $mask_bit_7_to_0;   
                              
                              # determine carry condition flag on difference in results 
                              $alu_stat_c =  (int($op1 * (2**($mask_bit_3_to_0 & $op2)))) != $alu_res;
                              #
                              # determine overflow condition flag
                              #
                              # sign extend op1 and result
			      $op1_ext     = sign_extend($op1);
			      $alu_res_ext = sign_extend($alu_res);

                              # overflow condition if difference in results
			      $alu_stat_o = (int($op1_ext * (2**($mask_bit_3_to_0 & $op2)))) != $alu_res_ext;
                        last; };
    /^alu_srl$/       && do { # shift right logical
                              $alu_res = int($op1 / (2**($mask_bit_3_to_0 & $op2)));
                        last; };
    /^alu_sra$/       && do { # shift right arithmetic
	                      # get sign of $op1 at bit position 7
	                      $sign = ($op1 & $mask_bit_7);
	                      $alu_res = $op1;
	                      for($j=0; $j<($mask_bit_3_to_0 & $op2);$j++){
		                $alu_res = $alu_res >> 1;
		                $alu_res = $alu_res | $sign;
		              }
                        last; };
    /^alu_pass_s1$/   && do {    
                               $alu_res = $op1;
                        last; };
    /^alu_pass_s2$/   && do { 
                               $alu_res = $op2;
                        last; };
    /^undefed$/       && do {  # no stimulus line is printed
                               $i--;
                               next stim;
                        last; };
    die "unbekannter Memnonic";
  }

  # determine negative condition flag
  $alu_stat_n = ($alu_res & $mask_bit_7) != 0;
  # determine zero condition flag
  $alu_stat_z = $alu_res == 0;


  if( ! $opt_d ){
    # stimulus generation 
    printf("  16#%03X# => (ALU_func_s => X\"%X\", ALU_in1_s => X\"%02X\", ALU_in2_s => X\"%02X\", ALU_c_in_s => '%X', " .
                 "ALU_exp_res_s => X\"%02X\", ALU_exp_s_s => \"%d%d%d%d\")%s -- %s\n",
            $i, $func_select_code, $op1, $op2, $c_in, $alu_res, 
            $alu_stat_c, $alu_stat_o, $alu_stat_z, $alu_stat_n,
            (($i != $no_stim -1) ? "," : " "), $func_select_memnonic );
  }else{
    # debug mode
    printf("memnonic %12s o1 %02X (%s), o2 %02X (%s), c_in %X res: %02X (%s) C%d O%d Z%d N%d \n", 
                  $func_select_memnonic, 
                  $op1, int2bitstring($op1, 2), 
                  $op2, int2bitstring($op2, 2), $c_in,
                  $alu_res, int2bitstring($alu_res, 2),
                  $alu_stat_c, $alu_stat_o, $alu_stat_z, $alu_stat_n);
  }
}

exit 0;

# __END__ of main


# int2bitstring
# input: integer to be converted to bitstring
# input: integer representing the minimal number of hex-chars of input integer
# ouput: binary representation of input integer
sub int2bitstring {
 my $x;
 my $ret;
 my $fill;

 # init
 $x = sprintf("%0$_[1]X", $_[0]);
 $ret  = "";
 $fill = "";
 while($x =~ /\w/){
   $x =~ s/(\w)(\w*)/$2/;
   for( $1 ){
     /^0$/   && do { $ret = $ret . $fill . "0000"; last; };
     /^1$/   && do { $ret = $ret . $fill . "0001"; last; };
     /^2$/   && do { $ret = $ret . $fill . "0010"; last; };
     /^3$/   && do { $ret = $ret . $fill . "0011"; last; };
     /^4$/   && do { $ret = $ret . $fill . "0100"; last; };
     /^5$/   && do { $ret = $ret . $fill . "0101"; last; };
     /^6$/   && do { $ret = $ret . $fill . "0110"; last; };
     /^7$/   && do { $ret = $ret . $fill . "0111"; last; };
     /^8$/   && do { $ret = $ret . $fill . "1000"; last; };
     /^9$/   && do { $ret = $ret . $fill . "1001"; last; };
     /^A$/   && do { $ret = $ret . $fill . "1010"; last; };
     /^B$/   && do { $ret = $ret . $fill . "1011"; last; };
     /^C$/   && do { $ret = $ret . $fill . "1100"; last; };
     /^D$/   && do { $ret = $ret . $fill . "1101"; last; };
     /^E$/   && do { $ret = $ret . $fill . "1110"; last; };
     /^F$/   && do { $ret = $ret . $fill . "1111"; last; };
     die "unbekannte Hexzahl";
   }
   $fill = "_";
 }
  return $ret;
}

# sign_extend
#
# input: 8 bit number
# output: number sign extended
sub sign_extend {
 my $in = $_[0];
 my $out;

 if( $in & $mask_bit_7 ){
     # sign bit set
     $in = $in | ~$mask_bit_7_to_0;
 }
 # make sure perl understands our data types
 $out = sprintf "%d", $in;
 return($out);
}
__END__












