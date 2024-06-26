-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\End_Generator.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: End_Generator
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Packet Controller/End Generator
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY End_Generator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        validIn                           :   IN    std_logic;
        rst                               :   IN    std_logic;
        endOut                            :   OUT   std_logic
        );
END End_Generator;


ARCHITECTURE rtl OF End_Generator IS

  -- Signals
  SIGNAL count_step                       : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL count_from                       : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL count_reset                      : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL HDL_Counter_out1                 : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL count                            : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL need_to_wrap                     : std_logic;
  SIGNAL count_value                      : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL count_1                          : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL count_2                          : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Logical_Operator1_out1           : std_logic;
  SIGNAL Delay6_out1                      : std_logic;

BEGIN
  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 1119
  count_step <= to_unsigned(16#001#, 11);

  count_from <= to_unsigned(16#000#, 11);

  count_reset <= to_unsigned(16#000#, 11);

  count <= HDL_Counter_out1 + count_step;

  
  need_to_wrap <= '1' WHEN HDL_Counter_out1 = to_unsigned(16#45F#, 11) ELSE
      '0';

  
  count_value <= count WHEN need_to_wrap = '0' ELSE
      count_from;

  
  count_1 <= HDL_Counter_out1 WHEN validIn = '0' ELSE
      count_value;

  
  count_2 <= count_1 WHEN rst = '0' ELSE
      count_reset;

  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#000#, 11);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        HDL_Counter_out1 <= count_2;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Compare_To_Constant_out1 <= '1' WHEN HDL_Counter_out1 = to_unsigned(16#45F#, 11) ELSE
      '0';

  Logical_Operator1_out1 <= Compare_To_Constant_out1 AND validIn;

  Delay6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay6_out1 <= Logical_Operator1_out1;
      END IF;
    END IF;
  END PROCESS Delay6_process;


  endOut <= Delay6_out1;

END rtl;

