-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\CordicKernelMag.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CordicKernelMag
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Coarse Frequency Compensator/Coarse Frequency 
-- Estimator/Extract Frequency/HDL_CMA_core/CordicKernelMa
-- Hierarchy Level: 6
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CordicKernelMag IS
  PORT( xin                               :   IN    std_logic_vector(32 DOWNTO 0);  -- sfix33_En24
        yin                               :   IN    std_logic_vector(32 DOWNTO 0);  -- sfix33_En24
        zin                               :   IN    std_logic_vector(34 DOWNTO 0);  -- sfix35_En34
        lut_value                         :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En34
        idx                               :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        xout                              :   OUT   std_logic_vector(32 DOWNTO 0);  -- sfix33_En24
        yout                              :   OUT   std_logic_vector(32 DOWNTO 0);  -- sfix33_En24
        zout                              :   OUT   std_logic_vector(34 DOWNTO 0)  -- sfix35_En34
        );
END CordicKernelMag;


ARCHITECTURE rtl OF CordicKernelMag IS

  -- Signals
  SIGNAL yin_signed                       : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL yLessThanZero                    : std_logic;
  SIGNAL xin_signed                       : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL idx_unsigned                     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL dynamic_shift_cast               : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL yShifted                         : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL xout2                            : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL xout1                            : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL xout_tmp                         : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL dynamic_shift_cast_1             : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL xShifted                         : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL yout2                            : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL yout1                            : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL yout_tmp                         : signed(32 DOWNTO 0);  -- sfix33_En24
  SIGNAL zin_signed                       : signed(34 DOWNTO 0);  -- sfix35_En34
  SIGNAL lut_value_unsigned               : unsigned(31 DOWNTO 0);  -- ufix32_En34
  SIGNAL ZAdder_add_cast                  : signed(34 DOWNTO 0);  -- sfix35_En34
  SIGNAL zout2                            : signed(34 DOWNTO 0);  -- sfix35_En34
  SIGNAL ZSub_sub_cast                    : signed(34 DOWNTO 0);  -- sfix35_En34
  SIGNAL zout1                            : signed(34 DOWNTO 0);  -- sfix35_En34
  SIGNAL zout_tmp                         : signed(34 DOWNTO 0);  -- sfix35_En34

BEGIN
  yin_signed <= signed(yin);

  
  yLessThanZero <= '1' WHEN yin_signed < to_signed(0, 33) ELSE
      '0';

  xin_signed <= signed(xin);

  idx_unsigned <= unsigned(idx);

  dynamic_shift_cast <= resize(idx_unsigned, 8);
  yShifted <= SHIFT_RIGHT(yin_signed, to_integer(dynamic_shift_cast));

  xout2 <= xin_signed + yShifted;

  xout1 <= xin_signed - yShifted;

  
  xout_tmp <= xout2 WHEN yLessThanZero = '0' ELSE
      xout1;

  xout <= std_logic_vector(xout_tmp);

  dynamic_shift_cast_1 <= resize(idx_unsigned, 8);
  xShifted <= SHIFT_RIGHT(xin_signed, to_integer(dynamic_shift_cast_1));

  yout2 <= yin_signed - xShifted;

  yout1 <= yin_signed + xShifted;

  
  yout_tmp <= yout2 WHEN yLessThanZero = '0' ELSE
      yout1;

  yout <= std_logic_vector(yout_tmp);

  zin_signed <= signed(zin);

  lut_value_unsigned <= unsigned(lut_value);

  ZAdder_add_cast <= signed(resize(lut_value_unsigned, 35));
  zout2 <= zin_signed + ZAdder_add_cast;

  ZSub_sub_cast <= signed(resize(lut_value_unsigned, 35));
  zout1 <= zin_signed - ZSub_sub_cast;

  
  zout_tmp <= zout2 WHEN yLessThanZero = '0' ELSE
      zout1;

  zout <= std_logic_vector(zout_tmp);

END rtl;
