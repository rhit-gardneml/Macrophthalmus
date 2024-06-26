-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Phase_Ambiguity_Corrector.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Phase_Ambiguity_Corrector
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Phase Ambiguity Estimation and Correction/Phase 
-- Ambiguity Correcto
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.QPSK_Rx_pkg.ALL;

ENTITY Phase_Ambiguity_Corrector IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        estimate_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        estimate_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        validIn                           :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        validOut                          :   OUT   std_logic
        );
END Phase_Ambiguity_Corrector;


ARCHITECTURE rtl OF Phase_Ambiguity_Corrector IS

  -- Component Declarations
  COMPONENT HDL_CMA_core_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In_re                           :   IN    std_logic_vector(11 DOWNTO 0);  -- sfix12_En10
          In_im                           :   IN    std_logic_vector(11 DOWNTO 0);  -- sfix12_En10
          validIn                         :   IN    std_logic;
          magnitude                       :   OUT   std_logic_vector(12 DOWNTO 0)  -- sfix13_En10
          );
  END COMPONENT;

  COMPONENT Reciprocal
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(12 DOWNTO 0);  -- sfix13_En10
          dataOut                         :   OUT   std_logic_vector(25 DOWNTO 0)  -- sfix26_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : HDL_CMA_core_block
    USE ENTITY work.HDL_CMA_core_block(rtl);

  FOR ALL : Reciprocal
    USE ENTITY work.Reciprocal(rtl);

  -- Signals
  SIGNAL Constant_out1                    : std_logic;
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_reg_re                     : vector_of_signed16(0 TO 14);  -- sfix16_En14 [15]
  SIGNAL Delay_reg_im                     : vector_of_signed16(0 TO 14);  -- sfix16_En14 [15]
  SIGNAL Delay_out1_re                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_out1_im                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay8_reg_re                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay8_reg_im                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay8_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay8_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay11_reg_re                   : vector_of_signed16(0 TO 6) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [7]
  SIGNAL Delay11_reg_im                   : vector_of_signed16(0 TO 6) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [7]
  SIGNAL Delay11_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay11_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay36_reg_re                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay36_reg_im                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay36_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay36_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay38_reg_re                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay38_reg_im                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay38_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay38_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay13_reg_re                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay13_reg_im                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay13_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay13_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay41_reg_re                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay41_reg_im                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay41_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay41_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL estimate_re_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL estimate_im_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Data_Type_Conversion_out1_re     : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Data_Type_Conversion_out1_im     : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay1_reg_re                    : vector_of_signed12(0 TO 14);  -- sfix12_En10 [15]
  SIGNAL Delay1_reg_im                    : vector_of_signed12(0 TO 14);  -- sfix12_En10 [15]
  SIGNAL Delay1_out1_re                   : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay1_out1_im                   : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay25_reg_re                   : vector_of_signed12(0 TO 1) := (OTHERS => to_signed(16#000#, 12));  -- sfix12_En10 [2]
  SIGNAL Delay25_reg_im                   : vector_of_signed12(0 TO 1) := (OTHERS => to_signed(16#000#, 12));  -- sfix12_En10 [2]
  SIGNAL Delay25_out1_re                  : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay25_out1_im                  : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay9_reg_re                    : vector_of_signed12(0 TO 6) := (OTHERS => to_signed(16#000#, 12));  -- sfix12_En10 [7]
  SIGNAL Delay9_reg_im                    : vector_of_signed12(0 TO 6) := (OTHERS => to_signed(16#000#, 12));  -- sfix12_En10 [7]
  SIGNAL Delay9_out1_re                   : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay9_out1_im                   : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL conj_cast                        : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL conj_cast_1                      : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL Math_Function_out1_re            : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Math_Function_out1_im            : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay28_reg_re                   : vector_of_signed12(0 TO 1) := (OTHERS => to_signed(16#000#, 12));  -- sfix12_En10 [2]
  SIGNAL Delay28_reg_im                   : vector_of_signed12(0 TO 1) := (OTHERS => to_signed(16#000#, 12));  -- sfix12_En10 [2]
  SIGNAL Delay28_out1_re                  : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Delay28_out1_im                  : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL Product2_mul_temp                : signed(27 DOWNTO 0);  -- sfix28_En24
  SIGNAL Product2_sub_cast                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product2_mul_temp_1              : signed(27 DOWNTO 0);  -- sfix28_En24
  SIGNAL Product2_sub_cast_1              : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product2_mul_temp_2              : signed(27 DOWNTO 0);  -- sfix28_En24
  SIGNAL Product2_add_cast                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product2_mul_temp_3              : signed(27 DOWNTO 0);  -- sfix28_En24
  SIGNAL Product2_add_cast_1              : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product2_out1_re                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product2_out1_im                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay4_reg_re                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay4_reg_im                    : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay4_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay4_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay15_reg_re                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay15_reg_im                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay15_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay15_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant1_out1                   : std_logic;
  SIGNAL Complex_to_Magnitude_Angle_out1  : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL Complex_to_Magnitude_Angle_out1_signed : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL Delay10_reg                      : vector_of_signed13(0 TO 1);  -- sfix13 [2]
  SIGNAL Delay10_out1                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL Reciprocal_out1                  : std_logic_vector(25 DOWNTO 0);  -- ufix26
  SIGNAL Reciprocal_out1_signed           : signed(25 DOWNTO 0);  -- sfix26_En14
  SIGNAL Delay3_reg                       : vector_of_signed26(0 TO 1) := (OTHERS => to_signed(16#0000000#, 26));  -- sfix26 [2]
  SIGNAL Delay3_out1                      : signed(25 DOWNTO 0);  -- sfix26_En14
  SIGNAL Delay7_reg                       : vector_of_signed26(0 TO 1) := (OTHERS => to_signed(16#0000000#, 26));  -- sfix26 [2]
  SIGNAL Delay7_out1                      : signed(25 DOWNTO 0);  -- sfix26_En14
  SIGNAL Delay17_reg                      : vector_of_signed26(0 TO 1) := (OTHERS => to_signed(16#0000000#, 26));  -- sfix26 [2]
  SIGNAL Delay17_out1                     : signed(25 DOWNTO 0);  -- sfix26_En14
  SIGNAL Product1_mul_temp                : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL Product1_mul_temp_1              : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL Product1_out1_re                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product1_out1_im                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay39_reg_re                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay39_reg_im                   : vector_of_signed16(0 TO 1) := (OTHERS => to_signed(16#0000#, 16));  -- sfix16_En14 [2]
  SIGNAL Delay39_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay39_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch1_out1_re        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch1_out1_im        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay5_reg                       : std_logic_vector(14 DOWNTO 0);  -- ufix1 [15]
  SIGNAL Delay5_out1                      : std_logic;
  SIGNAL Delay2_reg                       : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL Delay12_reg                      : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');  -- ufix1 [7]
  SIGNAL Delay12_out1                     : std_logic;
  SIGNAL Delay14_reg                      : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay14_out1                     : std_logic;
  SIGNAL Delay16_reg                      : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay16_out1                     : std_logic;
  SIGNAL Delay18_reg                      : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');  -- ufix1 [2]
  SIGNAL Delay18_out1                     : std_logic;
  SIGNAL Delay22_reg                      : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay22_out1                     : std_logic;

BEGIN
  -- Let Z be the complex Phase Ambiguity estimate and Xbar be the data and X be the corrected data.
  -- X = Xbar * conj(Z) * (1/abs(Z))
  -- Set this value to zero to disable phase ambiguity correction

  u_Complex_to_Magnitude_Angle : HDL_CMA_core_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In_re => std_logic_vector(Data_Type_Conversion_out1_re),  -- sfix12_En10
              In_im => std_logic_vector(Data_Type_Conversion_out1_im),  -- sfix12_En10
              validIn => Constant1_out1,
              magnitude => Complex_to_Magnitude_Angle_out1  -- sfix13_En10
              );

  u_Reciprocal : Reciprocal
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn => std_logic_vector(Delay10_out1),  -- sfix13_En10
              dataOut => Reciprocal_out1  -- sfix26_En14
              );

  Constant_out1 <= '1';

  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      Delay_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_reg_im(0) <= dataIn_im_signed;
        Delay_reg_im(1 TO 14) <= Delay_reg_im(0 TO 13);
        Delay_reg_re(0) <= dataIn_re_signed;
        Delay_reg_re(1 TO 14) <= Delay_reg_re(0 TO 13);
      END IF;
    END IF;
  END PROCESS Delay_process;

  Delay_out1_re <= Delay_reg_re(14);
  Delay_out1_im <= Delay_reg_im(14);

  Delay8_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay8_reg_im(0) <= Delay_out1_im;
        Delay8_reg_im(1) <= Delay8_reg_im(0);
        Delay8_reg_re(0) <= Delay_out1_re;
        Delay8_reg_re(1) <= Delay8_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay8_process;

  Delay8_out1_re <= Delay8_reg_re(1);
  Delay8_out1_im <= Delay8_reg_im(1);

  Delay11_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay11_reg_im(0) <= Delay8_out1_im;
        Delay11_reg_im(1 TO 6) <= Delay11_reg_im(0 TO 5);
        Delay11_reg_re(0) <= Delay8_out1_re;
        Delay11_reg_re(1 TO 6) <= Delay11_reg_re(0 TO 5);
      END IF;
    END IF;
  END PROCESS Delay11_process;

  Delay11_out1_re <= Delay11_reg_re(6);
  Delay11_out1_im <= Delay11_reg_im(6);

  Delay36_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay36_reg_im(0) <= Delay11_out1_im;
        Delay36_reg_im(1) <= Delay36_reg_im(0);
        Delay36_reg_re(0) <= Delay11_out1_re;
        Delay36_reg_re(1) <= Delay36_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay36_process;

  Delay36_out1_re <= Delay36_reg_re(1);
  Delay36_out1_im <= Delay36_reg_im(1);

  Delay38_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay38_reg_im(0) <= Delay36_out1_im;
        Delay38_reg_im(1) <= Delay38_reg_im(0);
        Delay38_reg_re(0) <= Delay36_out1_re;
        Delay38_reg_re(1) <= Delay38_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay38_process;

  Delay38_out1_re <= Delay38_reg_re(1);
  Delay38_out1_im <= Delay38_reg_im(1);

  Delay13_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay13_reg_im(0) <= Delay38_out1_im;
        Delay13_reg_im(1) <= Delay13_reg_im(0);
        Delay13_reg_re(0) <= Delay38_out1_re;
        Delay13_reg_re(1) <= Delay13_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay13_process;

  Delay13_out1_re <= Delay13_reg_re(1);
  Delay13_out1_im <= Delay13_reg_im(1);

  Delay41_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay41_reg_im(0) <= Delay13_out1_im;
        Delay41_reg_im(1) <= Delay41_reg_im(0);
        Delay41_reg_re(0) <= Delay13_out1_re;
        Delay41_reg_re(1) <= Delay41_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay41_process;

  Delay41_out1_re <= Delay41_reg_re(1);
  Delay41_out1_im <= Delay41_reg_im(1);

  estimate_re_signed <= signed(estimate_re);

  estimate_im_signed <= signed(estimate_im);

  Data_Type_Conversion_out1_re <= estimate_re_signed(15 DOWNTO 4);
  Data_Type_Conversion_out1_im <= estimate_im_signed(15 DOWNTO 4);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_reg_re <= (OTHERS => to_signed(16#000#, 12));
      Delay1_reg_im <= (OTHERS => to_signed(16#000#, 12));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_reg_im(0) <= Data_Type_Conversion_out1_im;
        Delay1_reg_im(1 TO 14) <= Delay1_reg_im(0 TO 13);
        Delay1_reg_re(0) <= Data_Type_Conversion_out1_re;
        Delay1_reg_re(1 TO 14) <= Delay1_reg_re(0 TO 13);
      END IF;
    END IF;
  END PROCESS Delay1_process;

  Delay1_out1_re <= Delay1_reg_re(14);
  Delay1_out1_im <= Delay1_reg_im(14);

  Delay25_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay25_reg_im(0) <= Delay1_out1_im;
        Delay25_reg_im(1) <= Delay25_reg_im(0);
        Delay25_reg_re(0) <= Delay1_out1_re;
        Delay25_reg_re(1) <= Delay25_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay25_process;

  Delay25_out1_re <= Delay25_reg_re(1);
  Delay25_out1_im <= Delay25_reg_im(1);

  Delay9_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay9_reg_im(0) <= Delay25_out1_im;
        Delay9_reg_im(1 TO 6) <= Delay9_reg_im(0 TO 5);
        Delay9_reg_re(0) <= Delay25_out1_re;
        Delay9_reg_re(1 TO 6) <= Delay9_reg_re(0 TO 5);
      END IF;
    END IF;
  END PROCESS Delay9_process;

  Delay9_out1_re <= Delay9_reg_re(6);
  Delay9_out1_im <= Delay9_reg_im(6);

  Math_Function_out1_re <= Delay9_out1_re;
  conj_cast <= resize(Delay9_out1_im, 13);
  conj_cast_1 <=  - (conj_cast);
  
  Math_Function_out1_im <= "011111111111" WHEN (conj_cast_1(12) = '0') AND (conj_cast_1(11) /= '0') ELSE
      "100000000000" WHEN (conj_cast_1(12) = '1') AND (conj_cast_1(11) /= '1') ELSE
      conj_cast_1(11 DOWNTO 0);

  Delay28_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay28_reg_im(0) <= Math_Function_out1_im;
        Delay28_reg_im(1) <= Delay28_reg_im(0);
        Delay28_reg_re(0) <= Math_Function_out1_re;
        Delay28_reg_re(1) <= Delay28_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay28_process;

  Delay28_out1_re <= Delay28_reg_re(1);
  Delay28_out1_im <= Delay28_reg_im(1);

  Product2_mul_temp <= Delay36_out1_re * Delay28_out1_re;
  Product2_sub_cast <= Product2_mul_temp(25 DOWNTO 10);
  Product2_mul_temp_1 <= Delay36_out1_im * Delay28_out1_im;
  Product2_sub_cast_1 <= Product2_mul_temp_1(25 DOWNTO 10);
  Product2_out1_re <= Product2_sub_cast - Product2_sub_cast_1;
  Product2_mul_temp_2 <= Delay36_out1_im * Delay28_out1_re;
  Product2_add_cast <= Product2_mul_temp_2(25 DOWNTO 10);
  Product2_mul_temp_3 <= Delay36_out1_re * Delay28_out1_im;
  Product2_add_cast_1 <= Product2_mul_temp_3(25 DOWNTO 10);
  Product2_out1_im <= Product2_add_cast + Product2_add_cast_1;

  Delay4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_reg_im(0) <= Product2_out1_im;
        Delay4_reg_im(1) <= Delay4_reg_im(0);
        Delay4_reg_re(0) <= Product2_out1_re;
        Delay4_reg_re(1) <= Delay4_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay4_process;

  Delay4_out1_re <= Delay4_reg_re(1);
  Delay4_out1_im <= Delay4_reg_im(1);

  Delay15_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay15_reg_im(0) <= Delay4_out1_im;
        Delay15_reg_im(1) <= Delay15_reg_im(0);
        Delay15_reg_re(0) <= Delay4_out1_re;
        Delay15_reg_re(1) <= Delay15_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay15_process;

  Delay15_out1_re <= Delay15_reg_re(1);
  Delay15_out1_im <= Delay15_reg_im(1);

  Constant1_out1 <= '1';

  Complex_to_Magnitude_Angle_out1_signed <= signed(Complex_to_Magnitude_Angle_out1);

  Delay10_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay10_reg <= (OTHERS => to_signed(16#0000#, 13));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay10_reg(0) <= Complex_to_Magnitude_Angle_out1_signed;
        Delay10_reg(1) <= Delay10_reg(0);
      END IF;
    END IF;
  END PROCESS Delay10_process;

  Delay10_out1 <= Delay10_reg(1);

  Reciprocal_out1_signed <= signed(Reciprocal_out1);

  Delay3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_reg(0) <= Reciprocal_out1_signed;
        Delay3_reg(1) <= Delay3_reg(0);
      END IF;
    END IF;
  END PROCESS Delay3_process;

  Delay3_out1 <= Delay3_reg(1);

  Delay7_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay7_reg(0) <= Delay3_out1;
        Delay7_reg(1) <= Delay7_reg(0);
      END IF;
    END IF;
  END PROCESS Delay7_process;

  Delay7_out1 <= Delay7_reg(1);

  Delay17_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay17_reg(0) <= Delay7_out1;
        Delay17_reg(1) <= Delay17_reg(0);
      END IF;
    END IF;
  END PROCESS Delay17_process;

  Delay17_out1 <= Delay17_reg(1);

  Product1_mul_temp <= Delay15_out1_re * Delay17_out1;
  Product1_out1_re <= Product1_mul_temp(29 DOWNTO 14);
  Product1_mul_temp_1 <= Delay15_out1_im * Delay17_out1;
  Product1_out1_im <= Product1_mul_temp_1(29 DOWNTO 14);

  Delay39_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay39_reg_im(0) <= Product1_out1_im;
        Delay39_reg_im(1) <= Delay39_reg_im(0);
        Delay39_reg_re(0) <= Product1_out1_re;
        Delay39_reg_re(1) <= Delay39_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay39_process;

  Delay39_out1_re <= Delay39_reg_re(1);
  Delay39_out1_im <= Delay39_reg_im(1);

  
  Multiport_Switch1_out1_re <= Delay41_out1_re WHEN Constant_out1 = '0' ELSE
      Delay39_out1_re;
  
  Multiport_Switch1_out1_im <= Delay41_out1_im WHEN Constant_out1 = '0' ELSE
      Delay39_out1_im;

  dataOut_re <= std_logic_vector(Multiport_Switch1_out1_re);

  dataOut_im <= std_logic_vector(Multiport_Switch1_out1_im);

  Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_reg(0) <= validIn;
        Delay5_reg(14 DOWNTO 1) <= Delay5_reg(13 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS Delay5_process;

  Delay5_out1 <= Delay5_reg(14);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_reg(0) <= Delay5_out1;
        Delay2_reg(1) <= Delay2_reg(0);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1 <= Delay2_reg(1);

  Delay12_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay12_reg(0) <= Delay2_out1;
        Delay12_reg(6 DOWNTO 1) <= Delay12_reg(5 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS Delay12_process;

  Delay12_out1 <= Delay12_reg(6);

  Delay14_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay14_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay14_reg(0) <= Delay12_out1;
        Delay14_reg(1) <= Delay14_reg(0);
      END IF;
    END IF;
  END PROCESS Delay14_process;

  Delay14_out1 <= Delay14_reg(1);

  Delay16_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay16_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay16_reg(0) <= Delay14_out1;
        Delay16_reg(1) <= Delay16_reg(0);
      END IF;
    END IF;
  END PROCESS Delay16_process;

  Delay16_out1 <= Delay16_reg(1);

  Delay18_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay18_reg(0) <= Delay16_out1;
        Delay18_reg(1) <= Delay18_reg(0);
      END IF;
    END IF;
  END PROCESS Delay18_process;

  Delay18_out1 <= Delay18_reg(1);

  Delay22_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay22_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay22_reg(0) <= Delay18_out1;
        Delay22_reg(1) <= Delay22_reg(0);
      END IF;
    END IF;
  END PROCESS Delay22_process;

  Delay22_out1 <= Delay22_reg(1);

  validOut <= Delay22_out1;

END rtl;

