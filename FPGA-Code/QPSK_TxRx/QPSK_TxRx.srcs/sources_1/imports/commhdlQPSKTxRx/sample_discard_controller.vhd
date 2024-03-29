-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\sample_discard_controller.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: sample_discard_controller
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Packet Controller/sample discard controller
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY sample_discard_controller IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        validIn                           :   IN    std_logic;
        startIn                           :   IN    std_logic;
        endIn                             :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        startOut                          :   OUT   std_logic;
        endOut                            :   OUT   std_logic;
        validOut                          :   OUT   std_logic
        );
END sample_discard_controller;


ARCHITECTURE rtl OF sample_discard_controller IS

  -- Signals
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_re_tmp                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_im_tmp                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL active                           : std_logic;
  SIGNAL dataOutReg_re                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOutReg_im                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL validOutReg                      : std_logic;
  SIGNAL startOutReg                      : std_logic;
  SIGNAL endOutReg                        : std_logic;
  SIGNAL active_next                      : std_logic;
  SIGNAL dataOutReg_next_re               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOutReg_next_im               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL validOutReg_next                 : std_logic;
  SIGNAL startOutReg_next                 : std_logic;
  SIGNAL endOutReg_next                   : std_logic;

BEGIN
  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  sample_discard_controller_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      active <= '0';
      dataOutReg_re <= to_signed(16#0000#, 16);
      dataOutReg_im <= to_signed(16#0000#, 16);
      validOutReg <= '0';
      startOutReg <= '0';
      endOutReg <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        active <= active_next;
        dataOutReg_re <= dataOutReg_next_re;
        dataOutReg_im <= dataOutReg_next_im;
        validOutReg <= validOutReg_next;
        startOutReg <= startOutReg_next;
        endOutReg <= endOutReg_next;
      END IF;
    END IF;
  END PROCESS sample_discard_controller_1_process;

  sample_discard_controller_1_output : PROCESS (active, dataIn_im_signed, dataIn_re_signed, dataOutReg_im, dataOutReg_re,
       endIn, endOutReg, startIn, startOutReg, validIn, validOutReg)
    VARIABLE active_temp : std_logic;
  BEGIN
    active_temp := active;
    startOutReg_next <= startIn;
    endOutReg_next <= endIn;
    IF startIn = '1' THEN 
      active_temp := '1';
    END IF;
    IF active_temp = '1' THEN 
      dataOutReg_next_re <= dataIn_re_signed;
      dataOutReg_next_im <= dataIn_im_signed;
      validOutReg_next <= validIn;
    ELSE 
      dataOutReg_next_re <= to_signed(16#0000#, 16);
      dataOutReg_next_im <= to_signed(16#0000#, 16);
      validOutReg_next <= '0';
    END IF;
    IF endIn = '1' THEN 
      endOutReg_next <= active_temp;
      active_temp := '0';
    END IF;
    dataOut_re_tmp <= dataOutReg_re;
    dataOut_im_tmp <= dataOutReg_im;
    startOut <= startOutReg;
    endOut <= endOutReg;
    validOut <= validOutReg;
    active_next <= active_temp;
  END PROCESS sample_discard_controller_1_output;


  dataOut_re <= std_logic_vector(dataOut_re_tmp);

  dataOut_im <= std_logic_vector(dataOut_im_tmp);

END rtl;

