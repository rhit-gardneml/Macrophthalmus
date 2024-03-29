-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Magnitude_Squared.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Magnitude_Squared
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Preamble Detector/Correlator/Magnitude Squared
-- Hierarchy Level: 4
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.QPSK_Rx_pkg.ALL;

ENTITY Magnitude_Squared IS
  PORT( clk                               :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1_re                            :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        In1_im                            :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        Out1_re                           :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En26
        );
END Magnitude_Squared;


ARCHITECTURE rtl OF Magnitude_Squared IS

  -- Signals
  SIGNAL In1_re_signed                    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL In1_im_signed                    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Delay2_reg_re                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En13 [2]
  SIGNAL Delay2_reg_im                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En13 [2]
  SIGNAL Delay2_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Delay2_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL conj_cast                        : signed(16 DOWNTO 0);  -- sfix17_En13
  SIGNAL conj_cast_1                      : signed(16 DOWNTO 0);  -- sfix17_En13
  SIGNAL Math_Function_out1_re            : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Math_Function_out1_im            : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Delay1_reg_re                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En13 [2]
  SIGNAL Delay1_reg_im                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En13 [2]
  SIGNAL Delay1_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Delay1_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Product_mul_temp                 : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Product_mul_temp_1               : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Product_mul_temp_2               : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Product_mul_temp_3               : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Product_out1_re                  : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Product_out1_im                  : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Delay3_reg_re                    : vector_of_signed32(0 TO 1) := (OTHERS => to_signed(0, 32));  -- sfix32_En26 [2]
  SIGNAL Delay3_reg_im                    : vector_of_signed32(0 TO 1) := (OTHERS => to_signed(0, 32));  -- sfix32_En26 [2]
  SIGNAL Delay3_out1_re                   : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Delay3_out1_im                   : signed(31 DOWNTO 0);  -- sfix32_En26

BEGIN
  In1_re_signed <= signed(In1_re);

  In1_im_signed <= signed(In1_im);

  Delay2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_reg_im(0) <= In1_im_signed;
        Delay2_reg_im(1) <= Delay2_reg_im(0);
        Delay2_reg_re(0) <= In1_re_signed;
        Delay2_reg_re(1) <= Delay2_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1_re <= Delay2_reg_re(1);
  Delay2_out1_im <= Delay2_reg_im(1);

  Math_Function_out1_re <= In1_re_signed;
  conj_cast <= resize(In1_im_signed, 17);
  conj_cast_1 <=  - (conj_cast);
  
  Math_Function_out1_im <= X"7FFF" WHEN (conj_cast_1(16) = '0') AND (conj_cast_1(15) /= '0') ELSE
      X"8000" WHEN (conj_cast_1(16) = '1') AND (conj_cast_1(15) /= '1') ELSE
      conj_cast_1(15 DOWNTO 0);

  Delay1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_reg_im(0) <= Math_Function_out1_im;
        Delay1_reg_im(1) <= Delay1_reg_im(0);
        Delay1_reg_re(0) <= Math_Function_out1_re;
        Delay1_reg_re(1) <= Delay1_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay1_process;

  Delay1_out1_re <= Delay1_reg_re(1);
  Delay1_out1_im <= Delay1_reg_im(1);

  Product_mul_temp <= Delay2_out1_re * Delay1_out1_re;
  Product_mul_temp_1 <= Delay2_out1_im * Delay1_out1_im;
  Product_out1_re <= Product_mul_temp - Product_mul_temp_1;
  Product_mul_temp_2 <= Delay2_out1_im * Delay1_out1_re;
  Product_mul_temp_3 <= Delay2_out1_re * Delay1_out1_im;
  Product_out1_im <= Product_mul_temp_2 + Product_mul_temp_3;

  Delay3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_reg_im(0) <= Product_out1_im;
        Delay3_reg_im(1) <= Delay3_reg_im(0);
        Delay3_reg_re(0) <= Product_out1_re;
        Delay3_reg_re(1) <= Delay3_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay3_process;

  Delay3_out1_re <= Delay3_reg_re(1);
  Delay3_out1_im <= Delay3_reg_im(1);

  Out1_re <= std_logic_vector(Delay3_out1_re);


END rtl;

