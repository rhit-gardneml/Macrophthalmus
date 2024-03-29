-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\QPSK_Rx_pkg.vhd
-- Created: 2024-01-25 16:33:04
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE QPSK_Rx_pkg IS
  TYPE vector_of_signed16 IS ARRAY (NATURAL RANGE <>) OF signed(15 DOWNTO 0);
  TYPE vector_of_signed32 IS ARRAY (NATURAL RANGE <>) OF signed(31 DOWNTO 0);
  TYPE vector_of_signed33 IS ARRAY (NATURAL RANGE <>) OF signed(32 DOWNTO 0);
  TYPE vector_of_signed13 IS ARRAY (NATURAL RANGE <>) OF signed(12 DOWNTO 0);
  TYPE vector_of_signed29 IS ARRAY (NATURAL RANGE <>) OF signed(28 DOWNTO 0);
  TYPE vector_of_signed39 IS ARRAY (NATURAL RANGE <>) OF signed(38 DOWNTO 0);
  TYPE vector_of_signed2 IS ARRAY (NATURAL RANGE <>) OF signed(1 DOWNTO 0);
  TYPE vector_of_signed18 IS ARRAY (NATURAL RANGE <>) OF signed(17 DOWNTO 0);
  TYPE vector_of_signed19 IS ARRAY (NATURAL RANGE <>) OF signed(18 DOWNTO 0);
  TYPE vector_of_unsigned5 IS ARRAY (NATURAL RANGE <>) OF unsigned(4 DOWNTO 0);
  TYPE vector_of_unsigned12 IS ARRAY (NATURAL RANGE <>) OF unsigned(11 DOWNTO 0);
  TYPE vector_of_signed26 IS ARRAY (NATURAL RANGE <>) OF signed(25 DOWNTO 0);
  TYPE vector_of_signed12 IS ARRAY (NATURAL RANGE <>) OF signed(11 DOWNTO 0);
  TYPE vector_of_std_logic_vector17 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(16 DOWNTO 0);
  TYPE vector_of_signed20 IS ARRAY (NATURAL RANGE <>) OF signed(19 DOWNTO 0);
  TYPE vector_of_signed11 IS ARRAY (NATURAL RANGE <>) OF signed(10 DOWNTO 0);
  TYPE vector_of_signed40 IS ARRAY (NATURAL RANGE <>) OF signed(39 DOWNTO 0);
  TYPE vector_of_signed30 IS ARRAY (NATURAL RANGE <>) OF signed(29 DOWNTO 0);
  TYPE vector_of_unsigned2 IS ARRAY (NATURAL RANGE <>) OF unsigned(1 DOWNTO 0);
  TYPE vector_of_std_logic_vector16 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(15 DOWNTO 0);
  TYPE vector_of_signed17 IS ARRAY (NATURAL RANGE <>) OF signed(16 DOWNTO 0);
END QPSK_Rx_pkg;

