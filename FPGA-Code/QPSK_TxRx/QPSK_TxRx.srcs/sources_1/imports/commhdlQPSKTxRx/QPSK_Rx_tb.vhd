-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\QPSK_Rx_tb.vhd
-- Created: 2024-01-25 16:34:32
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
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: QPSK_Rx_tb
-- Source Path: 
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_textio.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
LIBRARY work;
USE work.QPSK_Rx_pkg.ALL;
USE work.QPSK_Rx_tb_pkg.ALL;

ENTITY QPSK_Rx_tb IS
END QPSK_Rx_tb;


ARCHITECTURE rtl OF QPSK_Rx_tb IS

  -- Component Declarations
  COMPONENT QPSK_Rx
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          validIn                         :   IN    std_logic;
          rstCS                           :   IN    std_logic;
          ce_out                          :   OUT   std_logic;
          dataOut                         :   OUT   std_logic;
          ctrlOut_startOut                :   OUT   std_logic;
          ctrlOut_endOut                  :   OUT   std_logic;
          ctrlOut_validOut                :   OUT   std_logic;
          rxDiagBus_nSynced               :   OUT   std_logic;
          rxDiagBus_normCoarseFreqEst     :   OUT   std_logic_vector(20 DOWNTO 0);  -- sfix21_En21
          rxDiagBus_QPSKConstellationPoints_re :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          rxDiagBus_QPSKConstellationPoints_im :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          rxDiagBus_QPSKConstellationValid :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : QPSK_Rx
    USE ENTITY work.QPSK_Rx(rtl);

  -- Signals
  SIGNAL clk                              : std_logic;
  SIGNAL reset                            : std_logic;
  SIGNAL clk_enable                       : std_logic;
  SIGNAL rawData_rstCS                    : std_logic;
  SIGNAL rxDiagBus_QPSKConstellationValid_done : std_logic;  -- ufix1
  SIGNAL rdEnb                            : std_logic;
  SIGNAL rxDiagBus_QPSKConstellationValid_done_enb : std_logic;  -- ufix1
  SIGNAL dataOut_addr                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rxDiagBus_QPSKConstellationValid_lastAddr : std_logic;  -- ufix1
  SIGNAL resetn                           : std_logic;
  SIGNAL check8_done                      : std_logic;  -- ufix1
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_done : std_logic;  -- ufix1
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_done_enb : std_logic;  -- ufix1
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_lastAddr : std_logic;  -- ufix1
  SIGNAL check7_done                      : std_logic;  -- ufix1
  SIGNAL rxDiagBus_normCoarseFreqEst_done : std_logic;  -- ufix1
  SIGNAL rxDiagBus_normCoarseFreqEst_done_enb : std_logic;  -- ufix1
  SIGNAL rxDiagBus_normCoarseFreqEst_lastAddr : std_logic;  -- ufix1
  SIGNAL check6_done                      : std_logic;  -- ufix1
  SIGNAL rxDiagBus_nSynced_done           : std_logic;  -- ufix1
  SIGNAL rxDiagBus_nSynced_done_enb       : std_logic;  -- ufix1
  SIGNAL rxDiagBus_nSynced_lastAddr       : std_logic;  -- ufix1
  SIGNAL check5_done                      : std_logic;  -- ufix1
  SIGNAL ctrlOut_validOut_done            : std_logic;  -- ufix1
  SIGNAL ctrlOut_validOut_done_enb        : std_logic;  -- ufix1
  SIGNAL ctrlOut_validOut_lastAddr        : std_logic;  -- ufix1
  SIGNAL check4_done                      : std_logic;  -- ufix1
  SIGNAL ctrlOut_endOut_done              : std_logic;  -- ufix1
  SIGNAL ctrlOut_endOut_done_enb          : std_logic;  -- ufix1
  SIGNAL ctrlOut_endOut_lastAddr          : std_logic;  -- ufix1
  SIGNAL check3_done                      : std_logic;  -- ufix1
  SIGNAL ctrlOut_startOut_done            : std_logic;  -- ufix1
  SIGNAL ctrlOut_startOut_done_enb        : std_logic;  -- ufix1
  SIGNAL ctrlOut_startOut_lastAddr        : std_logic;  -- ufix1
  SIGNAL check2_done                      : std_logic;  -- ufix1
  SIGNAL dataOut_done                     : std_logic;  -- ufix1
  SIGNAL dataOut_done_enb                 : std_logic;  -- ufix1
  SIGNAL dataOut_active                   : std_logic;  -- ufix1
  SIGNAL holdData_rstCS                   : std_logic;
  SIGNAL rstCS_offset                     : std_logic;
  SIGNAL rstCS_1                          : std_logic;
  SIGNAL Data_Type_Conversion7_out1_addr  : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL Channel_out2_addr_delay_1        : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL tb_enb_delay                     : std_logic;
  SIGNAL rawData_validIn                  : std_logic;
  SIGNAL holdData_validIn                 : std_logic;
  SIGNAL validIn_offset                   : std_logic;
  SIGNAL validIn                          : std_logic;
  SIGNAL Data_Type_Conversion7_out1_addr_delay : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rawData_dataIn_im                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL holdData_dataIn_im               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_offset                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_1                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Data_Type_Conversion7_out1_active : std_logic;  -- ufix1
  SIGNAL Data_Type_Conversion7_out1_enb   : std_logic;  -- ufix1
  SIGNAL rawData_dataIn_re                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL holdData_dataIn_re               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re_offset                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re_1                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL snkDone                          : std_logic;
  SIGNAL snkDonen                         : std_logic;
  SIGNAL tb_enb                           : std_logic;
  SIGNAL ce_out                           : std_logic;
  SIGNAL dataOut                          : std_logic;
  SIGNAL ctrlOut_startOut                 : std_logic;
  SIGNAL ctrlOut_endOut                   : std_logic;
  SIGNAL ctrlOut_validOut                 : std_logic;
  SIGNAL rxDiagBus_nSynced                : std_logic;
  SIGNAL rxDiagBus_normCoarseFreqEst      : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL rxDiagBus_QPSKConstellationPoints_re : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL rxDiagBus_QPSKConstellationPoints_im : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL rxDiagBus_QPSKConstellationValid : std_logic;
  SIGNAL dataOut_enb                      : std_logic;  -- ufix1
  SIGNAL dataOut_lastAddr                 : std_logic;  -- ufix1
  SIGNAL check1_done                      : std_logic;  -- ufix1
  SIGNAL dataOut_addr_delay_1             : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL dataOut_expected                 : std_logic;
  SIGNAL dataOut_ref                      : std_logic;
  SIGNAL dataOut_testFailure              : std_logic;  -- ufix1
  SIGNAL ctrlOut_startOut_addr_delay_1    : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL ctrlOut_startOut_expected        : std_logic;
  SIGNAL ctrlOut_startOut_ref             : std_logic;
  SIGNAL ctrlOut_startOut_testFailure     : std_logic;  -- ufix1
  SIGNAL ctrlOut_endOut_addr_delay_1      : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL ctrlOut_endOut_expected          : std_logic;
  SIGNAL ctrlOut_endOut_ref               : std_logic;
  SIGNAL ctrlOut_endOut_testFailure       : std_logic;  -- ufix1
  SIGNAL ctrlOut_validOut_addr_delay_1    : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL ctrlOut_validOut_expected        : std_logic;
  SIGNAL ctrlOut_validOut_ref             : std_logic;
  SIGNAL ctrlOut_validOut_testFailure     : std_logic;  -- ufix1
  SIGNAL rxDiagBus_nSynced_addr_delay_1   : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rxDiagBus_nSynced_expected       : std_logic;
  SIGNAL rxDiagBus_nSynced_ref            : std_logic;
  SIGNAL rxDiagBus_nSynced_testFailure    : std_logic;  -- ufix1
  SIGNAL rxDiagBus_normCoarseFreqEst_signed : signed(20 DOWNTO 0);  -- sfix21_En21
  SIGNAL rxDiagBus_normCoarseFreqEst_addr_delay_1 : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rxDiagBus_normCoarseFreqEst_expected : signed(20 DOWNTO 0);  -- sfix21_En21
  SIGNAL rxDiagBus_normCoarseFreqEst_ref  : signed(20 DOWNTO 0);  -- sfix21_En21
  SIGNAL rxDiagBus_normCoarseFreqEst_testFailure : std_logic;  -- ufix1
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_addr_delay_1 : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_expected : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_ref : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL rxDiagBus_QPSKConstellationPoints_re_testFailure : std_logic;  -- ufix1
  SIGNAL rxDiagBus_QPSKConstellationPoints_im_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL rxDiagBus_QPSKConstellationPoints_im_expected : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL rxDiagBus_QPSKConstellationPoints_im_ref : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL rxDiagBus_QPSKConstellationPoints_im_testFailure : std_logic;  -- ufix1
  SIGNAL rxDiagBus_QPSKConstellationValid_addr_delay_1 : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rxDiagBus_QPSKConstellationValid_expected : std_logic;
  SIGNAL rxDiagBus_QPSKConstellationValid_ref : std_logic;
  SIGNAL rxDiagBus_QPSKConstellationValid_testFailure : std_logic;  -- ufix1
  SIGNAL testFailure                      : std_logic;  -- ufix1

BEGIN
  u_QPSK_Rx : QPSK_Rx
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              dataIn_re => dataIn_re_1,  -- sfix16_En14
              dataIn_im => dataIn_im_1,  -- sfix16_En14
              validIn => validIn,
              rstCS => rstCS_1,
              ce_out => ce_out,
              dataOut => dataOut,
              ctrlOut_startOut => ctrlOut_startOut,
              ctrlOut_endOut => ctrlOut_endOut,
              ctrlOut_validOut => ctrlOut_validOut,
              rxDiagBus_nSynced => rxDiagBus_nSynced,
              rxDiagBus_normCoarseFreqEst => rxDiagBus_normCoarseFreqEst,  -- sfix21_En21
              rxDiagBus_QPSKConstellationPoints_re => rxDiagBus_QPSKConstellationPoints_re,  -- sfix16_En14
              rxDiagBus_QPSKConstellationPoints_im => rxDiagBus_QPSKConstellationPoints_im,  -- sfix16_En14
              rxDiagBus_QPSKConstellationValid => rxDiagBus_QPSKConstellationValid
              );

  -- Data source for rstCS
  rawData_rstCS <= '0';

  rxDiagBus_QPSKConstellationValid_done_enb <= rxDiagBus_QPSKConstellationValid_done AND rdEnb;

  
  rxDiagBus_QPSKConstellationValid_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  rxDiagBus_QPSKConstellationValid_done <= rxDiagBus_QPSKConstellationValid_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_8_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check8_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF rxDiagBus_QPSKConstellationValid_done_enb = '1' THEN
        check8_done <= rxDiagBus_QPSKConstellationValid_done;
      END IF;
    END IF;
  END PROCESS checkDone_8_process;

  rxDiagBus_QPSKConstellationPoints_re_done_enb <= rxDiagBus_QPSKConstellationPoints_re_done AND rdEnb;

  
  rxDiagBus_QPSKConstellationPoints_re_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  rxDiagBus_QPSKConstellationPoints_re_done <= rxDiagBus_QPSKConstellationPoints_re_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_7_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check7_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF rxDiagBus_QPSKConstellationPoints_re_done_enb = '1' THEN
        check7_done <= rxDiagBus_QPSKConstellationPoints_re_done;
      END IF;
    END IF;
  END PROCESS checkDone_7_process;

  rxDiagBus_normCoarseFreqEst_done_enb <= rxDiagBus_normCoarseFreqEst_done AND rdEnb;

  
  rxDiagBus_normCoarseFreqEst_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  rxDiagBus_normCoarseFreqEst_done <= rxDiagBus_normCoarseFreqEst_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_6_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check6_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF rxDiagBus_normCoarseFreqEst_done_enb = '1' THEN
        check6_done <= rxDiagBus_normCoarseFreqEst_done;
      END IF;
    END IF;
  END PROCESS checkDone_6_process;

  rxDiagBus_nSynced_done_enb <= rxDiagBus_nSynced_done AND rdEnb;

  
  rxDiagBus_nSynced_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  rxDiagBus_nSynced_done <= rxDiagBus_nSynced_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_5_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check5_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF rxDiagBus_nSynced_done_enb = '1' THEN
        check5_done <= rxDiagBus_nSynced_done;
      END IF;
    END IF;
  END PROCESS checkDone_5_process;

  ctrlOut_validOut_done_enb <= ctrlOut_validOut_done AND rdEnb;

  
  ctrlOut_validOut_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  ctrlOut_validOut_done <= ctrlOut_validOut_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_4_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check4_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ctrlOut_validOut_done_enb = '1' THEN
        check4_done <= ctrlOut_validOut_done;
      END IF;
    END IF;
  END PROCESS checkDone_4_process;

  ctrlOut_endOut_done_enb <= ctrlOut_endOut_done AND rdEnb;

  
  ctrlOut_endOut_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  ctrlOut_endOut_done <= ctrlOut_endOut_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_3_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check3_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ctrlOut_endOut_done_enb = '1' THEN
        check3_done <= ctrlOut_endOut_done;
      END IF;
    END IF;
  END PROCESS checkDone_3_process;

  ctrlOut_startOut_done_enb <= ctrlOut_startOut_done AND rdEnb;

  
  ctrlOut_startOut_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  ctrlOut_startOut_done <= ctrlOut_startOut_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check2_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ctrlOut_startOut_done_enb = '1' THEN
        check2_done <= ctrlOut_startOut_done;
      END IF;
    END IF;
  END PROCESS checkDone_2_process;

  dataOut_done_enb <= dataOut_done AND rdEnb;

  
  dataOut_active <= '1' WHEN dataOut_addr /= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  -- holdData reg for Reset_Carrier_Synchronizer_out1
  stimuli_Reset_Carrier_Synchronizer_out1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_rstCS <= 'X';
    ELSIF clk'event AND clk = '1' THEN
      holdData_rstCS <= rawData_rstCS;
    END IF;
  END PROCESS stimuli_Reset_Carrier_Synchronizer_out1_process;

  stimuli_Reset_Carrier_Synchronizer_out1_1: PROCESS (rawData_rstCS, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      rstCS_offset <= holdData_rstCS;
    ELSE
      rstCS_offset <= rawData_rstCS;
    END IF;
  END PROCESS stimuli_Reset_Carrier_Synchronizer_out1_1;

  rstCS_1 <= rstCS_offset AFTER 2 ns;

  Channel_out2_addr_delay_1 <= Data_Type_Conversion7_out1_addr AFTER 1 ns;

  -- Data source for validIn
  validIn_fileread: PROCESS (Channel_out2_addr_delay_1, tb_enb_delay, rdEnb)
    FILE fp: TEXT open READ_MODE is "validIn.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic;

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      READ(l, read_data);
    END IF;
    rawData_validIn <= read_data;
  END PROCESS validIn_fileread;

  -- holdData reg for Channel_out2
  stimuli_Channel_out2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_validIn <= 'X';
    ELSIF clk'event AND clk = '1' THEN
      holdData_validIn <= rawData_validIn;
    END IF;
  END PROCESS stimuli_Channel_out2_process;

  stimuli_Channel_out2_1: PROCESS (rawData_validIn, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      validIn_offset <= holdData_validIn;
    ELSE
      validIn_offset <= rawData_validIn;
    END IF;
  END PROCESS stimuli_Channel_out2_1;

  validIn <= validIn_offset AFTER 2 ns;

  -- Data source for dataIn_im
  dataIn_im_fileread: PROCESS (Data_Type_Conversion7_out1_addr_delay, tb_enb_delay, rdEnb)
    FILE fp: TEXT open READ_MODE is "dataIn_im.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_dataIn_im <= signed(read_data(15 DOWNTO 0));
  END PROCESS dataIn_im_fileread;

  -- holdData reg for Data_Type_Conversion7_out1
  stimuli_Data_Type_Conversion7_out1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_dataIn_im <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_dataIn_im <= rawData_dataIn_im;
    END IF;
  END PROCESS stimuli_Data_Type_Conversion7_out1_process;

  stimuli_Data_Type_Conversion7_out1_1: PROCESS (rawData_dataIn_im, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      dataIn_im_offset <= holdData_dataIn_im;
    ELSE
      dataIn_im_offset <= rawData_dataIn_im;
    END IF;
  END PROCESS stimuli_Data_Type_Conversion7_out1_1;

  dataIn_im <= dataIn_im_offset AFTER 2 ns;

  dataIn_im_1 <= std_logic_vector(dataIn_im);

  
  Data_Type_Conversion7_out1_active <= '1' WHEN Data_Type_Conversion7_out1_addr /= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  Data_Type_Conversion7_out1_enb <= Data_Type_Conversion7_out1_active AND (rdEnb AND tb_enb_delay);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 281760
  DataTypeConversion7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Data_Type_Conversion7_out1_addr <= to_unsigned(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF Data_Type_Conversion7_out1_enb = '1' THEN
        IF Data_Type_Conversion7_out1_addr >= to_unsigned(16#44CA0#, 19) THEN 
          Data_Type_Conversion7_out1_addr <= to_unsigned(16#00000#, 19);
        ELSE 
          Data_Type_Conversion7_out1_addr <= Data_Type_Conversion7_out1_addr + to_unsigned(16#00001#, 19);
        END IF;
      END IF;
    END IF;
  END PROCESS DataTypeConversion7_process;


  Data_Type_Conversion7_out1_addr_delay <= Data_Type_Conversion7_out1_addr AFTER 1 ns;

  -- Data source for dataIn_re
  dataIn_re_fileread: PROCESS (Data_Type_Conversion7_out1_addr_delay, tb_enb_delay, rdEnb)
    FILE fp: TEXT open READ_MODE is "dataIn_re.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_dataIn_re <= signed(read_data(15 DOWNTO 0));
  END PROCESS dataIn_re_fileread;

  -- holdData reg for Data_Type_Conversion7_out1
  stimuli_Data_Type_Conversion7_out1_2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_dataIn_re <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_dataIn_re <= rawData_dataIn_re;
    END IF;
  END PROCESS stimuli_Data_Type_Conversion7_out1_2_process;

  stimuli_Data_Type_Conversion7_out1_3: PROCESS (rawData_dataIn_re, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      dataIn_re_offset <= holdData_dataIn_re;
    ELSE
      dataIn_re_offset <= rawData_dataIn_re;
    END IF;
  END PROCESS stimuli_Data_Type_Conversion7_out1_3;

  dataIn_re <= dataIn_re_offset AFTER 2 ns;

  dataIn_re_1 <= std_logic_vector(dataIn_re);

  snkDonen <=  NOT snkDone;

  resetn <=  NOT reset;

  tb_enb <= resetn AND snkDonen;

  -- Delay inside enable generation: register depth 1
  u_enable_delay_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tb_enb_delay <= '0';
    ELSIF clk'event AND clk = '1' THEN
      tb_enb_delay <= tb_enb;
    END IF;
  END PROCESS u_enable_delay_process;

  
  rdEnb <= tb_enb_delay WHEN snkDone = '0' ELSE
      '0';

  clk_enable <= rdEnb AFTER 2 ns;

  reset_gen: PROCESS 
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    WAIT UNTIL clk'event AND clk = '1';
    WAIT FOR 2 ns;
    reset <= '0';
    WAIT;
  END PROCESS reset_gen;

  clk_gen: PROCESS 
  BEGIN
    clk <= '1';
    WAIT FOR 5 ns;
    clk <= '0';
    WAIT FOR 5 ns;
    IF snkDone = '1' THEN
      clk <= '1';
      WAIT FOR 5 ns;
      clk <= '0';
      WAIT FOR 5 ns;
      WAIT;
    END IF;
  END PROCESS clk_gen;

  dataOut_enb <= ce_out AND dataOut_active;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 281760
  c_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataOut_addr <= to_unsigned(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF dataOut_enb = '1' THEN
        IF dataOut_addr >= to_unsigned(16#44CA0#, 19) THEN 
          dataOut_addr <= to_unsigned(16#00000#, 19);
        ELSE 
          dataOut_addr <= dataOut_addr + to_unsigned(16#00001#, 19);
        END IF;
      END IF;
    END IF;
  END PROCESS c_3_process;


  
  dataOut_lastAddr <= '1' WHEN dataOut_addr >= to_unsigned(16#44CA0#, 19) ELSE
      '0';

  dataOut_done <= dataOut_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check1_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF dataOut_done_enb = '1' THEN
        check1_done <= dataOut_done;
      END IF;
    END IF;
  END PROCESS checkDone_1_process;

  snkDone <= check8_done AND (check7_done AND (check6_done AND (check5_done AND (check4_done AND (check3_done AND (check1_done AND check2_done))))));

  dataOut_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for dataOut_expected
  dataOut_expected_fileread: PROCESS (dataOut_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "dataOut_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic;

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      READ(l, read_data);
    END IF;
    dataOut_expected <= read_data;
  END PROCESS dataOut_expected_fileread;

  dataOut_ref <= dataOut_expected;

  dataOut_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataOut_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND dataOut /= dataOut_ref THEN
        dataOut_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in dataOut: Expected " & to_hex(dataOut_ref) & (" Actual " & to_hex(dataOut))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS dataOut_checker;

  ctrlOut_startOut_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for ctrlOut_startOut_expected
  ctrlOut_startOut_expected_fileread: PROCESS (ctrlOut_startOut_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "ctrlOut_startOut_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic;

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      READ(l, read_data);
    END IF;
    ctrlOut_startOut_expected <= read_data;
  END PROCESS ctrlOut_startOut_expected_fileread;

  ctrlOut_startOut_ref <= ctrlOut_startOut_expected;

  ctrlOut_startOut_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ctrlOut_startOut_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND ctrlOut_startOut /= ctrlOut_startOut_ref THEN
        ctrlOut_startOut_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in ctrlOut_startOut: Expected " & to_hex(ctrlOut_startOut_ref) & (" Actual " & to_hex(ctrlOut_startOut))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS ctrlOut_startOut_checker;

  ctrlOut_endOut_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for ctrlOut_endOut_expected
  ctrlOut_endOut_expected_fileread: PROCESS (ctrlOut_endOut_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "ctrlOut_endOut_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic;

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      READ(l, read_data);
    END IF;
    ctrlOut_endOut_expected <= read_data;
  END PROCESS ctrlOut_endOut_expected_fileread;

  ctrlOut_endOut_ref <= ctrlOut_endOut_expected;

  ctrlOut_endOut_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ctrlOut_endOut_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND ctrlOut_endOut /= ctrlOut_endOut_ref THEN
        ctrlOut_endOut_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in ctrlOut_endOut: Expected " & to_hex(ctrlOut_endOut_ref) & (" Actual " & to_hex(ctrlOut_endOut))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS ctrlOut_endOut_checker;

  ctrlOut_validOut_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for ctrlOut_validOut_expected
  ctrlOut_validOut_expected_fileread: PROCESS (ctrlOut_validOut_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "ctrlOut_validOut_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic;

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      READ(l, read_data);
    END IF;
    ctrlOut_validOut_expected <= read_data;
  END PROCESS ctrlOut_validOut_expected_fileread;

  ctrlOut_validOut_ref <= ctrlOut_validOut_expected;

  ctrlOut_validOut_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ctrlOut_validOut_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND ctrlOut_validOut /= ctrlOut_validOut_ref THEN
        ctrlOut_validOut_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in ctrlOut_validOut: Expected " & to_hex(ctrlOut_validOut_ref) & (" Actual " & to_hex(ctrlOut_validOut))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS ctrlOut_validOut_checker;

  rxDiagBus_nSynced_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for rxDiagBus_nSynced_expected
  rxDiagBus_nSynced_expected_fileread: PROCESS (rxDiagBus_nSynced_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "rxDiagBus_nSynced_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic;

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      READ(l, read_data);
    END IF;
    rxDiagBus_nSynced_expected <= read_data;
  END PROCESS rxDiagBus_nSynced_expected_fileread;

  rxDiagBus_nSynced_ref <= rxDiagBus_nSynced_expected;

  rxDiagBus_nSynced_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rxDiagBus_nSynced_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND rxDiagBus_nSynced /= rxDiagBus_nSynced_ref THEN
        rxDiagBus_nSynced_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in rxDiagBus_nSynced: Expected " & to_hex(rxDiagBus_nSynced_ref) & (" Actual " & to_hex(rxDiagBus_nSynced))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS rxDiagBus_nSynced_checker;

  rxDiagBus_normCoarseFreqEst_signed <= signed(rxDiagBus_normCoarseFreqEst);

  rxDiagBus_normCoarseFreqEst_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for rxDiagBus_normCoarseFreqEst_expected
  rxDiagBus_normCoarseFreqEst_expected_fileread: PROCESS (rxDiagBus_normCoarseFreqEst_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "rxDiagBus_normCoarseFreqEst_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(23 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rxDiagBus_normCoarseFreqEst_expected <= signed(read_data(20 DOWNTO 0));
  END PROCESS rxDiagBus_normCoarseFreqEst_expected_fileread;

  rxDiagBus_normCoarseFreqEst_ref <= rxDiagBus_normCoarseFreqEst_expected;

  rxDiagBus_normCoarseFreqEst_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rxDiagBus_normCoarseFreqEst_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND rxDiagBus_normCoarseFreqEst_signed /= rxDiagBus_normCoarseFreqEst_ref THEN
        rxDiagBus_normCoarseFreqEst_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in rxDiagBus_normCoarseFreqEst_signed: Expected " & to_hex(rxDiagBus_normCoarseFreqEst_ref) & (" Actual " & to_hex(rxDiagBus_normCoarseFreqEst_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS rxDiagBus_normCoarseFreqEst_signed_checker;

  rxDiagBus_QPSKConstellationPoints_re_signed <= signed(rxDiagBus_QPSKConstellationPoints_re);

  rxDiagBus_QPSKConstellationPoints_re_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for rxDiagBus_QPSKConstellationPoints_re_expected
  rxDiagBus_QPSKConstellationPoints_re_expected_fileread: PROCESS (rxDiagBus_QPSKConstellationPoints_re_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "rxDiagBus_QPSKConstellationPoints_re_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rxDiagBus_QPSKConstellationPoints_re_expected <= signed(read_data(15 DOWNTO 0));
  END PROCESS rxDiagBus_QPSKConstellationPoints_re_expected_fileread;

  rxDiagBus_QPSKConstellationPoints_re_ref <= rxDiagBus_QPSKConstellationPoints_re_expected;

  rxDiagBus_QPSKConstellationPoints_re_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rxDiagBus_QPSKConstellationPoints_re_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND rxDiagBus_QPSKConstellationPoints_re_signed /= rxDiagBus_QPSKConstellationPoints_re_ref THEN
        rxDiagBus_QPSKConstellationPoints_re_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in rxDiagBus_QPSKConstellationPoints_re_signed: Expected " & to_hex(rxDiagBus_QPSKConstellationPoints_re_ref) & (" Actual " & to_hex(rxDiagBus_QPSKConstellationPoints_re_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS rxDiagBus_QPSKConstellationPoints_re_signed_checker;

  rxDiagBus_QPSKConstellationPoints_im_signed <= signed(rxDiagBus_QPSKConstellationPoints_im);

  -- Data source for rxDiagBus_QPSKConstellationPoints_im_expected
  rxDiagBus_QPSKConstellationPoints_im_expected_fileread: PROCESS (rxDiagBus_QPSKConstellationPoints_re_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "rxDiagBus_QPSKConstellationPoints_im_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rxDiagBus_QPSKConstellationPoints_im_expected <= signed(read_data(15 DOWNTO 0));
  END PROCESS rxDiagBus_QPSKConstellationPoints_im_expected_fileread;

  rxDiagBus_QPSKConstellationPoints_im_ref <= rxDiagBus_QPSKConstellationPoints_im_expected;

  rxDiagBus_QPSKConstellationPoints_im_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rxDiagBus_QPSKConstellationPoints_im_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND rxDiagBus_QPSKConstellationPoints_im_signed /= rxDiagBus_QPSKConstellationPoints_im_ref THEN
        rxDiagBus_QPSKConstellationPoints_im_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in rxDiagBus_QPSKConstellationPoints_im_signed: Expected " & to_hex(rxDiagBus_QPSKConstellationPoints_im_ref) & (" Actual " & to_hex(rxDiagBus_QPSKConstellationPoints_im_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS rxDiagBus_QPSKConstellationPoints_im_signed_checker;

  rxDiagBus_QPSKConstellationValid_addr_delay_1 <= dataOut_addr AFTER 1 ns;

  -- Data source for rxDiagBus_QPSKConstellationValid_expected
  rxDiagBus_QPSKConstellationValid_expected_fileread: PROCESS (rxDiagBus_QPSKConstellationValid_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "rxDiagBus_QPSKConstellationValid_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic;

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      READ(l, read_data);
    END IF;
    rxDiagBus_QPSKConstellationValid_expected <= read_data;
  END PROCESS rxDiagBus_QPSKConstellationValid_expected_fileread;

  rxDiagBus_QPSKConstellationValid_ref <= rxDiagBus_QPSKConstellationValid_expected;

  rxDiagBus_QPSKConstellationValid_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rxDiagBus_QPSKConstellationValid_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND rxDiagBus_QPSKConstellationValid /= rxDiagBus_QPSKConstellationValid_ref THEN
        rxDiagBus_QPSKConstellationValid_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in rxDiagBus_QPSKConstellationValid: Expected " & to_hex(rxDiagBus_QPSKConstellationValid_ref) & (" Actual " & to_hex(rxDiagBus_QPSKConstellationValid))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS rxDiagBus_QPSKConstellationValid_checker;

  testFailure <= rxDiagBus_QPSKConstellationValid_testFailure OR (rxDiagBus_QPSKConstellationPoints_im_testFailure OR (rxDiagBus_QPSKConstellationPoints_re_testFailure OR (rxDiagBus_normCoarseFreqEst_testFailure OR (rxDiagBus_nSynced_testFailure OR (ctrlOut_validOut_testFailure OR (ctrlOut_endOut_testFailure OR (dataOut_testFailure OR ctrlOut_startOut_testFailure)))))));

  completed_msg: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF snkDone = '1' THEN
        IF testFailure = '0' THEN
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (PASSED)**************"
            SEVERITY NOTE;
        ELSE
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (FAILED)**************"
            SEVERITY NOTE;
        END IF;
      END IF;
    END IF;
  END PROCESS completed_msg;

END rtl;

