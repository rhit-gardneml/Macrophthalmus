-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Compare_To_Constant5.vhd
-- Created: 2024-01-25 16:27:39
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Compare_To_Constant5
-- Source Path: commhdlQPSKTxRx/QPSK Tx/Bit Packetizer/Data Bits FIFO/Compare To Constant5
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Compare_To_Constant5 IS
  PORT( u                                 :   IN    std_logic;  -- ufix1
        y                                 :   OUT   std_logic
        );
END Compare_To_Constant5;


ARCHITECTURE rtl OF Compare_To_Constant5 IS

  -- Signals
  SIGNAL Constant_out1                    : std_logic;  -- ufix1
  SIGNAL Compare_relop1                   : std_logic;

BEGIN
  Constant_out1 <= '1';

  
  Compare_relop1 <= '1' WHEN u = Constant_out1 ELSE
      '0';

  y <= Compare_relop1;

END rtl;
