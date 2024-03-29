-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\QPSK_Rx.vhd
-- Created: 2024-01-25 16:33:04
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1.30208e-07
-- Target subsystem base rate: 1.30208e-07
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1.30208e-07
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- dataOut                       ce_out        1.30208e-07
-- ctrlOut_startOut              ce_out        1.30208e-07
-- ctrlOut_endOut                ce_out        1.30208e-07
-- ctrlOut_validOut              ce_out        1.30208e-07
-- rxDiagBus_nSynced             ce_out        1.30208e-07
-- rxDiagBus_normCoarseFreqEst   ce_out        1.30208e-07
-- rxDiagBus_QPSKConstellationPoints_rece_out        1.30208e-07
-- rxDiagBus_QPSKConstellationPoints_imce_out        1.30208e-07
-- rxDiagBus_QPSKConstellationValidce_out        1.30208e-07
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: QPSK_Rx
-- Source Path: commhdlQPSKTxRx/QPSK Rx
-- Hierarchy Level: 0
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY QPSK_Rx IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        validIn                           :   IN    std_logic;
        rstCS                             :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        dataOut                           :   OUT   std_logic;
        ctrlOut_startOut                  :   OUT   std_logic;
        ctrlOut_endOut                    :   OUT   std_logic;
        ctrlOut_validOut                  :   OUT   std_logic;
        rxDiagBus_nSynced                 :   OUT   std_logic;
        rxDiagBus_normCoarseFreqEst       :   OUT   std_logic_vector(20 DOWNTO 0);  -- sfix21_En21
        rxDiagBus_QPSKConstellationPoints_re :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        rxDiagBus_QPSKConstellationPoints_im :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        rxDiagBus_QPSKConstellationValid  :   OUT   std_logic
        );
END QPSK_Rx;


ARCHITECTURE rtl OF QPSK_Rx IS

  -- Component Declarations
  COMPONENT Automatic_Gain_Control
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          validIn                         :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT RRC_Receive_Filter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          validIn                         :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Frequency_and_Time_Synchronizer
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          validIn                         :   IN    std_logic;
          rstCS                           :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          startOut                        :   OUT   std_logic;
          endOut                          :   OUT   std_logic;
          validOut                        :   OUT   std_logic;
          nSynced                         :   OUT   std_logic;
          normCoarseFreqEst               :   OUT   std_logic_vector(20 DOWNTO 0)  -- sfix21_En21
          );
  END COMPONENT;

  COMPONENT QPSK_Demodulator
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          startIn                         :   IN    std_logic;
          endIn                           :   IN    std_logic;
          validIn                         :   IN    std_logic;
          dataOut                         :   OUT   std_logic;
          startOut                        :   OUT   std_logic;
          endOut                          :   OUT   std_logic;
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT HDL_Data_Descrambler
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn                          :   IN    std_logic;
          startIn                         :   IN    std_logic;
          endIn                           :   IN    std_logic;
          validIn                         :   IN    std_logic;
          dataOut                         :   OUT   std_logic;
          startOut                        :   OUT   std_logic;
          endOut                          :   OUT   std_logic;
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Automatic_Gain_Control
    USE ENTITY work.Automatic_Gain_Control(rtl);

  FOR ALL : RRC_Receive_Filter
    USE ENTITY work.RRC_Receive_Filter(rtl);

  FOR ALL : Frequency_and_Time_Synchronizer
    USE ENTITY work.Frequency_and_Time_Synchronizer(rtl);

  FOR ALL : QPSK_Demodulator
    USE ENTITY work.QPSK_Demodulator(rtl);

  FOR ALL : HDL_Data_Descrambler
    USE ENTITY work.HDL_Data_Descrambler(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL Automatic_Gain_Control_out1_re   : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Automatic_Gain_Control_out1_im   : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Automatic_Gain_Control_out2      : std_logic;
  SIGNAL RRC_Receive_Filter_out1_re       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL RRC_Receive_Filter_out1_im       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL RRC_Receive_Filter_out2          : std_logic;
  SIGNAL QPSKConstellationPoints_re       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL QPSKConstellationPoints_im       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL startOut                         : std_logic;
  SIGNAL endOut                           : std_logic;
  SIGNAL QPSKConstellationValid           : std_logic;
  SIGNAL nSynced                          : std_logic;
  SIGNAL normCoarseFreqEst                : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL QPSK_Demodulator_out1            : std_logic;
  SIGNAL QPSK_Demodulator_out2            : std_logic;
  SIGNAL QPSK_Demodulator_out3            : std_logic;
  SIGNAL QPSK_Demodulator_out4            : std_logic;
  SIGNAL HDL_Data_Descrambler_out1        : std_logic;
  SIGNAL startOut_1                       : std_logic;
  SIGNAL endOut_1                         : std_logic;
  SIGNAL validOut                         : std_logic;
  SIGNAL nSynced_1                        : std_logic;
  SIGNAL normCoarseFreqEst_signed         : signed(20 DOWNTO 0);  -- sfix21_En21
  SIGNAL normCoarseFreqEst_1              : signed(20 DOWNTO 0);  -- sfix21_En21
  SIGNAL QPSKConstellationPoints_re_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL QPSKConstellationPoints_im_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL QPSKConstellationPoints_re_1     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL QPSKConstellationPoints_im_1     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL QPSKConstellationValid_1         : std_logic;

BEGIN
  u_Automatic_Gain_Control : Automatic_Gain_Control
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              dataIn_re => dataIn_re,  -- sfix16_En14
              dataIn_im => dataIn_im,  -- sfix16_En14
              validIn => validIn,
              dataOut_re => Automatic_Gain_Control_out1_re,  -- sfix16_En14
              dataOut_im => Automatic_Gain_Control_out1_im,  -- sfix16_En14
              validOut => Automatic_Gain_Control_out2
              );

  u_RRC_Receive_Filter : RRC_Receive_Filter
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              dataIn_re => Automatic_Gain_Control_out1_re,  -- sfix16_En14
              dataIn_im => Automatic_Gain_Control_out1_im,  -- sfix16_En14
              validIn => Automatic_Gain_Control_out2,
              dataOut_re => RRC_Receive_Filter_out1_re,  -- sfix16_En12
              dataOut_im => RRC_Receive_Filter_out1_im,  -- sfix16_En12
              validOut => RRC_Receive_Filter_out2
              );

  u_Frequency_and_Time_Synchronizer : Frequency_and_Time_Synchronizer
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              dataIn_re => RRC_Receive_Filter_out1_re,  -- sfix16_En12
              dataIn_im => RRC_Receive_Filter_out1_im,  -- sfix16_En12
              validIn => RRC_Receive_Filter_out2,
              rstCS => rstCS,
              dataOut_re => QPSKConstellationPoints_re,  -- sfix16_En14
              dataOut_im => QPSKConstellationPoints_im,  -- sfix16_En14
              startOut => startOut,
              endOut => endOut,
              validOut => QPSKConstellationValid,
              nSynced => nSynced,
              normCoarseFreqEst => normCoarseFreqEst  -- sfix21_En21
              );

  u_QPSK_Demodulator : QPSK_Demodulator
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              dataIn_re => QPSKConstellationPoints_re,  -- sfix16_En14
              dataIn_im => QPSKConstellationPoints_im,  -- sfix16_En14
              startIn => startOut,
              endIn => endOut,
              validIn => QPSKConstellationValid,
              dataOut => QPSK_Demodulator_out1,
              startOut => QPSK_Demodulator_out2,
              endOut => QPSK_Demodulator_out3,
              validOut => QPSK_Demodulator_out4
              );

  u_HDL_Data_Descrambler : HDL_Data_Descrambler
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              dataIn => QPSK_Demodulator_out1,
              startIn => QPSK_Demodulator_out2,
              endIn => QPSK_Demodulator_out3,
              validIn => QPSK_Demodulator_out4,
              dataOut => HDL_Data_Descrambler_out1,
              startOut => startOut_1,
              endOut => endOut_1,
              validOut => validOut
              );

  enb <= clk_enable;

  Delay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      nSynced_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        nSynced_1 <= nSynced;
      END IF;
    END IF;
  END PROCESS Delay_1_process;


  normCoarseFreqEst_signed <= signed(normCoarseFreqEst);

  Delay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      normCoarseFreqEst_1 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        normCoarseFreqEst_1 <= normCoarseFreqEst_signed;
      END IF;
    END IF;
  END PROCESS Delay_2_process;


  rxDiagBus_normCoarseFreqEst <= std_logic_vector(normCoarseFreqEst_1);

  QPSKConstellationPoints_re_signed <= signed(QPSKConstellationPoints_re);

  QPSKConstellationPoints_im_signed <= signed(QPSKConstellationPoints_im);

  Delay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      QPSKConstellationPoints_re_1 <= to_signed(16#0000#, 16);
      QPSKConstellationPoints_im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        QPSKConstellationPoints_re_1 <= QPSKConstellationPoints_re_signed;
        QPSKConstellationPoints_im_1 <= QPSKConstellationPoints_im_signed;
      END IF;
    END IF;
  END PROCESS Delay_3_process;


  rxDiagBus_QPSKConstellationPoints_re <= std_logic_vector(QPSKConstellationPoints_re_1);

  rxDiagBus_QPSKConstellationPoints_im <= std_logic_vector(QPSKConstellationPoints_im_1);

  Delay_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      QPSKConstellationValid_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        QPSKConstellationValid_1 <= QPSKConstellationValid;
      END IF;
    END IF;
  END PROCESS Delay_4_process;


  ce_out <= clk_enable;

  dataOut <= HDL_Data_Descrambler_out1;

  ctrlOut_startOut <= startOut_1;

  ctrlOut_endOut <= endOut_1;

  ctrlOut_validOut <= validOut;

  rxDiagBus_nSynced <= nSynced_1;

  rxDiagBus_QPSKConstellationValid <= QPSKConstellationValid_1;

END rtl;

