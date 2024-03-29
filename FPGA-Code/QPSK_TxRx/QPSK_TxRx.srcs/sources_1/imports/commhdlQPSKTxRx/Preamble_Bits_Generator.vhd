-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Preamble_Bits_Generator.vhd
-- Created: 2024-01-25 16:27:39
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Preamble_Bits_Generator
-- Source Path: commhdlQPSKTxRx/QPSK Tx/Bit Packetizer/Preamble Bits Generator
-- Hierarchy Level: 2
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Preamble_Bits_Generator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        activeFrame                       :   IN    std_logic;
        sampleCount                       :   IN    std_logic_vector(11 DOWNTO 0);  -- ufix12
        sampleCountValid                  :   IN    std_logic;
        preambleBits                      :   OUT   std_logic
        );
END Preamble_Bits_Generator;


ARCHITECTURE rtl OF Preamble_Bits_Generator IS

  -- Component Declarations
  COMPONENT Compare_To_Constant2_block
    PORT( u                               :   IN    std_logic_vector(11 DOWNTO 0);  -- ufix12
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Preamble_Bits_Store
    PORT( actualPreamble                  :   IN    std_logic;
          sampleCount                     :   IN    std_logic_vector(11 DOWNTO 0);  -- ufix12
          preamble                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Compare_To_Constant2_block
    USE ENTITY work.Compare_To_Constant2_block(rtl);

  FOR ALL : Preamble_Bits_Store
    USE ENTITY work.Preamble_Bits_Store(rtl);

  -- Signals
  SIGNAL Compare_To_Constant2_out1        : std_logic;
  SIGNAL Logical_Operator3_out1           : std_logic;
  SIGNAL Unit_Delay_Enabled_Synchronous_out1 : std_logic;
  SIGNAL Preamble_Bits_Store_out1         : std_logic;

BEGIN
  u_Compare_To_Constant2 : Compare_To_Constant2_block
    PORT MAP( u => sampleCount,  -- ufix12
              y => Compare_To_Constant2_out1
              );

  u_Preamble_Bits_Store : Preamble_Bits_Store
    PORT MAP( actualPreamble => Unit_Delay_Enabled_Synchronous_out1,
              sampleCount => sampleCount,  -- ufix12
              preamble => Preamble_Bits_Store_out1
              );

  Logical_Operator3_out1 <= Compare_To_Constant2_out1 AND sampleCountValid;

  Unit_Delay_Enabled_Synchronous_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_Enabled_Synchronous_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND Logical_Operator3_out1 = '1' THEN
        Unit_Delay_Enabled_Synchronous_out1 <= activeFrame;
      END IF;
    END IF;
  END PROCESS Unit_Delay_Enabled_Synchronous_process;


  preambleBits <= Preamble_Bits_Store_out1;

END rtl;

