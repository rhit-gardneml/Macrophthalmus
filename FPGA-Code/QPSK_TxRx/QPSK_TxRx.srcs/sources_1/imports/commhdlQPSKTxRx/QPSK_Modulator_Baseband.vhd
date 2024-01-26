-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\QPSK_Modulator_Baseband.vhd
-- Created: 2024-01-25 16:27:39
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: QPSK_Modulator_Baseband
-- Source Path: commhdlQPSKTxRx/QPSK Tx/QPSK Modulator/QPSK Modulator Baseband
-- Hierarchy Level: 2
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.QPSK_Tx_pkg.ALL;

ENTITY QPSK_Modulator_Baseband IS
  PORT( in0                               :   IN    std_logic_vector(1 DOWNTO 0);  -- boolean [2]
        out0_re                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        out0_im                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
        );
END QPSK_Modulator_Baseband;


ARCHITECTURE rtl OF QPSK_Modulator_Baseband IS

  -- Constants
  CONSTANT t1_re                          : vector_of_signed16(0 TO 3) := 
    (to_signed(16#5A82#, 16), to_signed(-16#5A82#, 16), to_signed(16#5A82#, 16), to_signed(-16#5A82#, 16));  -- sfix16 [4]
  CONSTANT t1_im                          : vector_of_signed16(0 TO 3) := 
    (to_signed(16#5A82#, 16), to_signed(16#5A82#, 16), to_signed(-16#5A82#, 16), to_signed(-16#5A82#, 16));  -- sfix16 [4]

  -- Signals
  SIGNAL constellationLUTaddress          : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL out0_re_tmp                      : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL out0_im_tmp                      : signed(15 DOWNTO 0);  -- sfix16_En15

BEGIN
  constellationLUTaddress <= unsigned'(in0(0) & in0(1));

  out0_re_tmp <= t1_re(to_integer(constellationLUTaddress));
  out0_im_tmp <= t1_im(to_integer(constellationLUTaddress));

  out0_re <= std_logic_vector(out0_re_tmp);

  out0_im <= std_logic_vector(out0_im_tmp);

END rtl;
