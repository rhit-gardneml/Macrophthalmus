-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\CFO_step_change_detector.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CFO_step_change_detector
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Coarse Frequency Compensator/CFO step change 
-- detecto
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CFO_step_change_detector IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1                               :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En21
        Out1                              :   OUT   std_logic
        );
END CFO_step_change_detector;


ARCHITECTURE rtl OF CFO_step_change_detector IS

  -- Signals
  SIGNAL In1_signed                       : signed(20 DOWNTO 0);  -- sfix21_En21
  SIGNAL Delay1_out1                      : signed(20 DOWNTO 0);  -- sfix21_En21
  SIGNAL Add_sub_cast                     : signed(21 DOWNTO 0);  -- sfix22_En21
  SIGNAL Add_sub_cast_1                   : signed(21 DOWNTO 0);  -- sfix22_En21
  SIGNAL Add_out1                         : signed(21 DOWNTO 0);  -- sfix22_En21
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL Delay_reg                        : std_logic_vector(5 DOWNTO 0);  -- ufix1 [6]
  SIGNAL Delay_out1                       : std_logic;

BEGIN
  -- fixed point precision loss warning supressed for this subsystem

  In1_signed <= signed(In1);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= In1_signed;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Add_sub_cast <= resize(In1_signed, 22);
  Add_sub_cast_1 <= resize(Delay1_out1, 22);
  Add_out1 <= Add_sub_cast - Add_sub_cast_1;

  
  Compare_To_Constant_out1 <= '1' WHEN Add_out1 > to_signed(16#000CCD#, 22) ELSE
      '0';

  
  Compare_To_Constant1_out1 <= '1' WHEN Add_out1 < to_signed(-16#000CCD#, 22) ELSE
      '0';

  Logical_Operator_out1 <= Compare_To_Constant_out1 OR Compare_To_Constant1_out1;

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_reg(0) <= Logical_Operator_out1;
        Delay_reg(5 DOWNTO 1) <= Delay_reg(4 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS Delay_process;

  Delay_out1 <= Delay_reg(5);

  Out1 <= Delay_out1;

END rtl;

