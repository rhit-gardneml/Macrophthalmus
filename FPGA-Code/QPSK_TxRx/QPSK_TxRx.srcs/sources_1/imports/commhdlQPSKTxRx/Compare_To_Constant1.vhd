-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Compare_To_Constant1.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Compare_To_Constant1
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Preamble Detector/FIFO/Validate Input Push 
-- Pop/Compare To Constant
-- Hierarchy Level: 5
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Compare_To_Constant1 IS
  PORT( u                                 :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
        y                                 :   OUT   std_logic
        );
END Compare_To_Constant1;


ARCHITECTURE rtl OF Compare_To_Constant1 IS

  -- Signals
  SIGNAL u_unsigned                       : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Constant_out1                    : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Compare_relop1                   : std_logic;

BEGIN
  u_unsigned <= unsigned(u);

  Constant_out1 <= to_unsigned(16#46D#, 11);

  
  Compare_relop1 <= '1' WHEN u_unsigned = Constant_out1 ELSE
      '0';

  y <= Compare_relop1;

END rtl;

