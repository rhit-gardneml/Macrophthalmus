-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Validate_Input_Push_Pop.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Validate_Input_Push_Pop
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Preamble Detector/FIFO/Validate Input Push 
-- Po
-- Hierarchy Level: 4
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Validate_Input_Push_Pop IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        rst                               :   IN    std_logic;
        push                              :   IN    std_logic;
        pop                               :   IN    std_logic;
        valid_push                        :   OUT   std_logic;
        valid_pop                         :   OUT   std_logic
        );
END Validate_Input_Push_Pop;


ARCHITECTURE rtl OF Validate_Input_Push_Pop IS

  -- Component Declarations
  COMPONENT Compare_To_Constant1
    PORT( u                               :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT MATLAB_Function_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          rst                             :   IN    std_logic;
          enb_1                           :   IN    std_logic;
          dir                             :   IN    std_logic;
          count                           :   OUT   std_logic_vector(10 DOWNTO 0)  -- ufix11
          );
  END COMPONENT;

  COMPONENT Compare_To_Constant
    PORT( u                               :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Compare_To_Constant1
    USE ENTITY work.Compare_To_Constant1(rtl);

  FOR ALL : MATLAB_Function_block
    USE ENTITY work.MATLAB_Function_block(rtl);

  FOR ALL : Compare_To_Constant
    USE ENTITY work.Compare_To_Constant(rtl);

  -- Signals
  SIGNAL Constant_out1                    : std_logic;
  SIGNAL Constant1_out1                   : std_logic;
  SIGNAL Delay_out1                       : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL Logical_Operator7_out1           : std_logic;
  SIGNAL Switch_out1                      : std_logic;
  SIGNAL Logical_Operator9_out1           : std_logic;
  SIGNAL Logical_Operator1_out1           : std_logic;
  SIGNAL count                            : std_logic_vector(10 DOWNTO 0);  -- ufix11
  SIGNAL count_unsigned                   : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL pop_on_empty_FIFO                : std_logic;
  SIGNAL Logical_Operator6_out1           : std_logic;
  SIGNAL Logical_Operator8_out1           : std_logic;
  SIGNAL Logical_Operator5_out1           : std_logic;
  SIGNAL push_on_full_FIFO                : std_logic;
  SIGNAL Logical_Operator2_out1           : std_logic;

BEGIN
  u_Compare_To_Constant1 : Compare_To_Constant1
    PORT MAP( u => std_logic_vector(Delay_out1),  -- ufix11
              y => Compare_To_Constant1_out1
              );

  u_MATLAB_Function : MATLAB_Function_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              rst => rst,
              enb_1 => Logical_Operator1_out1,
              dir => Switch_out1,
              count => count  -- ufix11
              );

  u_Compare_To_Constant : Compare_To_Constant
    PORT MAP( u => std_logic_vector(Delay_out1),  -- ufix11
              y => Compare_To_Constant_out1
              );

  Constant_out1 <= '1';

  Constant1_out1 <= '0';

  
  Switch_out1 <= Constant_out1 WHEN Logical_Operator7_out1 = '0' ELSE
      Constant1_out1;

  Logical_Operator1_out1 <= Logical_Operator9_out1 XOR Logical_Operator7_out1;

  count_unsigned <= unsigned(count);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_unsigned(16#000#, 11);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= count_unsigned;
      END IF;
    END IF;
  END PROCESS Delay_process;


  pop_on_empty_FIFO <= Compare_To_Constant_out1 AND pop;

  Logical_Operator6_out1 <=  NOT pop_on_empty_FIFO;

  Logical_Operator7_out1 <= pop AND Logical_Operator6_out1;

  Logical_Operator8_out1 <=  NOT Logical_Operator7_out1;

  Logical_Operator5_out1 <= push AND Logical_Operator8_out1;

  push_on_full_FIFO <= Logical_Operator5_out1 AND Compare_To_Constant1_out1;

  Logical_Operator2_out1 <=  NOT push_on_full_FIFO;

  Logical_Operator9_out1 <= push AND Logical_Operator2_out1;

  valid_push <= Logical_Operator9_out1;

  valid_pop <= Logical_Operator7_out1;

END rtl;

