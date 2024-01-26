-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\RRC_Filter.vhd
-- Created: 2024-01-25 16:27:39
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: RRC_Filter
-- Source Path: commhdlQPSKTxRx/QPSK Tx/RRC Transmit Filter/RRC Filter
-- Hierarchy Level: 2
-- Model version: 7.26
-- 
-- Discrete FIR Filter
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RRC_Filter IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En16
        dataIn_im                         :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En16
        validIn                           :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        dataOut_im                        :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        validOut                          :   OUT   std_logic
        );
END RRC_Filter;


ARCHITECTURE rtl OF RRC_Filter IS

  -- Component Declarations
  COMPONENT Filter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En16
          dataIn_im                       :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En16
          validIn                         :   IN    std_logic;
          syncReset                       :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dataOut_im                      :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Filter
    USE ENTITY work.Filter(rtl);

  -- Signals
  SIGNAL syncReset                        : std_logic;
  SIGNAL dataOut_re_tmp                   : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL dataOut_im_tmp                   : std_logic_vector(16 DOWNTO 0);  -- ufix17

BEGIN
  u_FilterBank : Filter
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn_re => dataIn_re,  -- sfix17_En16
              dataIn_im => dataIn_im,  -- sfix17_En16
              validIn => validIn,
              syncReset => syncReset,
              dataOut_re => dataOut_re_tmp,  -- sfix17_En14
              dataOut_im => dataOut_im_tmp,  -- sfix17_En14
              validOut => validOut
              );

  syncReset <= '0';

  dataOut_re <= dataOut_re_tmp;

  dataOut_im <= dataOut_im_tmp;

END rtl;
