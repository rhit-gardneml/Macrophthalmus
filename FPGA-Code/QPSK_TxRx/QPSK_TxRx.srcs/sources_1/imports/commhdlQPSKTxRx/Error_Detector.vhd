-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Error_Detector.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Error_Detector
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Automatic Gain Control/Error Detector
-- Hierarchy Level: 2
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.QPSK_Rx_pkg.ALL;

ENTITY Error_Detector IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        err_re                            :   OUT   std_logic_vector(32 DOWNTO 0);  -- sfix33_En28
        err_im                            :   OUT   std_logic_vector(32 DOWNTO 0)  -- sfix33_En28
        );
END Error_Detector;


ARCHITECTURE rtl OF Error_Detector IS

  -- Signals
  SIGNAL Ref_out1                         : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_reg_re                    : vector_of_signed16(0 TO 1);  -- sfix16_En14 [2]
  SIGNAL Delay1_reg_im                    : vector_of_signed16(0 TO 1);  -- sfix16_En14 [2]
  SIGNAL Delay1_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL conj_cast                        : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL conj_cast_1                      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Conj_out1_re                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Conj_out1_im                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_reg_re                     : vector_of_signed16(0 TO 1);  -- sfix16_En14 [2]
  SIGNAL Delay_reg_im                     : vector_of_signed16(0 TO 1);  -- sfix16_En14 [2]
  SIGNAL Delay_out1_re                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_out1_im                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_mul_temp                 : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_mul_temp_1               : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_mul_temp_2               : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_mul_temp_3               : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_out1_re                  : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_out1_im                  : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Delay2_reg_re                    : vector_of_signed32(0 TO 1);  -- sfix32_En28 [2]
  SIGNAL Delay2_reg_im                    : vector_of_signed32(0 TO 1);  -- sfix32_En28 [2]
  SIGNAL Delay2_out1_re                   : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Delay2_out1_im                   : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Add1_sub_cast                    : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Add1_sub_cast_1                  : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Add1_cast                        : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Add1_out1_re                     : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Add1_out1_im                     : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Delay3_reg_re                    : vector_of_signed33(0 TO 1);  -- sfix33_En28 [2]
  SIGNAL Delay3_reg_im                    : vector_of_signed33(0 TO 1);  -- sfix33_En28 [2]
  SIGNAL Delay3_out1_re                   : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Delay3_out1_im                   : signed(32 DOWNTO 0);  -- sfix33_En28

BEGIN
  Ref_out1 <= to_signed(16#1000#, 16);

  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      Delay1_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_reg_im(0) <= dataIn_im_signed;
        Delay1_reg_im(1) <= Delay1_reg_im(0);
        Delay1_reg_re(0) <= dataIn_re_signed;
        Delay1_reg_re(1) <= Delay1_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay1_process;

  Delay1_out1_re <= Delay1_reg_re(1);
  Delay1_out1_im <= Delay1_reg_im(1);

  Conj_out1_re <= dataIn_re_signed;
  conj_cast <= resize(dataIn_im_signed, 17);
  conj_cast_1 <=  - (conj_cast);
  
  Conj_out1_im <= X"7FFF" WHEN (conj_cast_1(16) = '0') AND (conj_cast_1(15) /= '0') ELSE
      X"8000" WHEN (conj_cast_1(16) = '1') AND (conj_cast_1(15) /= '1') ELSE
      conj_cast_1(15 DOWNTO 0);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      Delay_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_reg_im(0) <= Conj_out1_im;
        Delay_reg_im(1) <= Delay_reg_im(0);
        Delay_reg_re(0) <= Conj_out1_re;
        Delay_reg_re(1) <= Delay_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay_process;

  Delay_out1_re <= Delay_reg_re(1);
  Delay_out1_im <= Delay_reg_im(1);

  Product_mul_temp <= Delay1_out1_re * Delay_out1_re;
  Product_mul_temp_1 <= Delay1_out1_im * Delay_out1_im;
  Product_out1_re <= Product_mul_temp - Product_mul_temp_1;
  Product_mul_temp_2 <= Delay1_out1_im * Delay_out1_re;
  Product_mul_temp_3 <= Delay1_out1_re * Delay_out1_im;
  Product_out1_im <= Product_mul_temp_2 + Product_mul_temp_3;

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_reg_re <= (OTHERS => to_signed(0, 32));
      Delay2_reg_im <= (OTHERS => to_signed(0, 32));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_reg_im(0) <= Product_out1_im;
        Delay2_reg_im(1) <= Delay2_reg_im(0);
        Delay2_reg_re(0) <= Product_out1_re;
        Delay2_reg_re(1) <= Delay2_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1_re <= Delay2_reg_re(1);
  Delay2_out1_im <= Delay2_reg_im(1);

  Add1_sub_cast <= resize(Ref_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 33);
  Add1_sub_cast_1 <= resize(Delay2_out1_re, 33);
  Add1_out1_re <= Add1_sub_cast - Add1_sub_cast_1;
  Add1_cast <= resize(Delay2_out1_im, 33);
  Add1_out1_im <=  - (Add1_cast);

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_reg_re <= (OTHERS => to_signed(0, 33));
      Delay3_reg_im <= (OTHERS => to_signed(0, 33));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_reg_im(0) <= Add1_out1_im;
        Delay3_reg_im(1) <= Delay3_reg_im(0);
        Delay3_reg_re(0) <= Add1_out1_re;
        Delay3_reg_re(1) <= Delay3_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay3_process;

  Delay3_out1_re <= Delay3_reg_re(1);
  Delay3_out1_im <= Delay3_reg_im(1);

  err_re <= std_logic_vector(Delay3_out1_re);

  err_im <= std_logic_vector(Delay3_out1_im);

END rtl;

