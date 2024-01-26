-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\HDL_CMA_core_block.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: HDL_CMA_core_block
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Phase Ambiguity Estimation and Correction/Phase 
-- Ambiguity Corrector/HDL_CMA_cor
-- Hierarchy Level: 4
-- Model version: 7.26
-- 
-- Complex to Magnitude-Angle
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY HDL_CMA_core_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In_re                             :   IN    std_logic_vector(11 DOWNTO 0);  -- sfix12_En10
        In_im                             :   IN    std_logic_vector(11 DOWNTO 0);  -- sfix12_En10
        validIn                           :   IN    std_logic;
        magnitude                         :   OUT   std_logic_vector(12 DOWNTO 0)  -- sfix13_En10
        );
END HDL_CMA_core_block;


ARCHITECTURE rtl OF HDL_CMA_core_block IS

  -- Component Declarations
  COMPONENT Quadrant_Mapper_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          xin                             :   IN    std_logic_vector(12 DOWNTO 0);  -- sfix13_En10
          yin                             :   IN    std_logic_vector(12 DOWNTO 0);  -- sfix13_En10
          xout                            :   OUT   std_logic_vector(12 DOWNTO 0);  -- sfix13_En10
          yout                            :   OUT   std_logic_vector(12 DOWNTO 0)  -- sfix13_En10
          );
  END COMPONENT;

  COMPONENT CordicKernelMag_block
    PORT( xin                             :   IN    std_logic_vector(12 DOWNTO 0);  -- sfix13_En10
          yin                             :   IN    std_logic_vector(12 DOWNTO 0);  -- sfix13_En10
          idx                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
          xout                            :   OUT   std_logic_vector(12 DOWNTO 0);  -- sfix13_En10
          yout                            :   OUT   std_logic_vector(12 DOWNTO 0)  -- sfix13_En10
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Quadrant_Mapper_block
    USE ENTITY work.Quadrant_Mapper_block(rtl);

  FOR ALL : CordicKernelMag_block
    USE ENTITY work.CordicKernelMag_block(rtl);

  -- Signals
  SIGNAL In_re_signed                     : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL In_im_signed                     : signed(11 DOWNTO 0);  -- sfix12_En10
  SIGNAL qMapReal                         : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL qMapImag                         : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL In1Register                      : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL In2Register                      : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL XQMapped                         : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yQMapped                         : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL XQMapped_signed                  : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yQMapped_signed                  : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin1                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin1                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift1                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout1                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout1                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout1_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout1_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin2                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin2                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift2                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout2                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout2                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout2_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout2_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin3                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin3                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift3                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout3                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout3                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout3_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout3_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin4                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin4                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift4                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout4                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout4                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout4_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout4_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin5                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin5                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift5                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout5                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout5                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout5_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout5_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin6                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin6                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift6                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout6                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout6                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout6_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout6_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin7                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin7                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift7                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout7                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout7                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout7_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout7_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin8                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin8                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift8                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout8                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout8                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout8_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout8_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin9                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin9                             : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift9                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout9                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout9                            : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout9_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout9_signed                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin10                            : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin10                            : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift10                          : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout10                           : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout10                           : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout10_signed                    : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yout10_signed                    : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin11                            : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL yin11                            : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL shift11                          : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout11                           : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL yout11deadOut                    : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL xout11_signed                    : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL Delay_ValidIn_reg                : std_logic_vector(13 DOWNTO 0);  -- ufix1 [14]
  SIGNAL ValidOutDelayed                  : std_logic;
  SIGNAL reset_outval                     : std_logic;
  SIGNAL xin12                            : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL CSD_Gain_Factor_mul_temp         : signed(26 DOWNTO 0);  -- sfix27_En23
  SIGNAL CSD_Gain_Factor_cast             : signed(25 DOWNTO 0);  -- sfix26_En23
  SIGNAL xoutscaled                       : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL zeroC                            : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL outSwitchMag                     : signed(12 DOWNTO 0);  -- sfix13_En10
  SIGNAL xin13                            : signed(12 DOWNTO 0);  -- sfix13_En10

BEGIN
  u_QuadrantMapper : Quadrant_Mapper_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              xin => std_logic_vector(In1Register),  -- sfix13_En10
              yin => std_logic_vector(In2Register),  -- sfix13_En10
              xout => XQMapped,  -- sfix13_En10
              yout => yQMapped  -- sfix13_En10
              );

  u_Iteration : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin1),  -- sfix13_En10
              yin => std_logic_vector(yin1),  -- sfix13_En10
              idx => std_logic_vector(shift1),  -- ufix5
              xout => xout1,  -- sfix13_En10
              yout => yout1  -- sfix13_En10
              );

  u_Iteration_1 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin2),  -- sfix13_En10
              yin => std_logic_vector(yin2),  -- sfix13_En10
              idx => std_logic_vector(shift2),  -- ufix5
              xout => xout2,  -- sfix13_En10
              yout => yout2  -- sfix13_En10
              );

  u_Iteration_2 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin3),  -- sfix13_En10
              yin => std_logic_vector(yin3),  -- sfix13_En10
              idx => std_logic_vector(shift3),  -- ufix5
              xout => xout3,  -- sfix13_En10
              yout => yout3  -- sfix13_En10
              );

  u_Iteration_3 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin4),  -- sfix13_En10
              yin => std_logic_vector(yin4),  -- sfix13_En10
              idx => std_logic_vector(shift4),  -- ufix5
              xout => xout4,  -- sfix13_En10
              yout => yout4  -- sfix13_En10
              );

  u_Iteration_4 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin5),  -- sfix13_En10
              yin => std_logic_vector(yin5),  -- sfix13_En10
              idx => std_logic_vector(shift5),  -- ufix5
              xout => xout5,  -- sfix13_En10
              yout => yout5  -- sfix13_En10
              );

  u_Iteration_5 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin6),  -- sfix13_En10
              yin => std_logic_vector(yin6),  -- sfix13_En10
              idx => std_logic_vector(shift6),  -- ufix5
              xout => xout6,  -- sfix13_En10
              yout => yout6  -- sfix13_En10
              );

  u_Iteration_6 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin7),  -- sfix13_En10
              yin => std_logic_vector(yin7),  -- sfix13_En10
              idx => std_logic_vector(shift7),  -- ufix5
              xout => xout7,  -- sfix13_En10
              yout => yout7  -- sfix13_En10
              );

  u_Iteration_7 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin8),  -- sfix13_En10
              yin => std_logic_vector(yin8),  -- sfix13_En10
              idx => std_logic_vector(shift8),  -- ufix5
              xout => xout8,  -- sfix13_En10
              yout => yout8  -- sfix13_En10
              );

  u_Iteration_8 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin9),  -- sfix13_En10
              yin => std_logic_vector(yin9),  -- sfix13_En10
              idx => std_logic_vector(shift9),  -- ufix5
              xout => xout9,  -- sfix13_En10
              yout => yout9  -- sfix13_En10
              );

  u_Iteration_9 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin10),  -- sfix13_En10
              yin => std_logic_vector(yin10),  -- sfix13_En10
              idx => std_logic_vector(shift10),  -- ufix5
              xout => xout10,  -- sfix13_En10
              yout => yout10  -- sfix13_En10
              );

  u_Iteration_10 : CordicKernelMag_block
    PORT MAP( xin => std_logic_vector(xin11),  -- sfix13_En10
              yin => std_logic_vector(yin11),  -- sfix13_En10
              idx => std_logic_vector(shift11),  -- ufix5
              xout => xout11,  -- sfix13_En10
              yout => yout11deadOut  -- sfix13_En10
              );

  In_re_signed <= signed(In_re);

  qMapReal <= resize(In_re_signed, 13);

  In_im_signed <= signed(In_im);

  qMapImag <= resize(In_im_signed, 13);

  DelayRealInput_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      In1Register <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        In1Register <= qMapReal;
      END IF;
    END IF;
  END PROCESS DelayRealInput_process;


  DelayImagInput_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      In2Register <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        In2Register <= qMapImag;
      END IF;
    END IF;
  END PROCESS DelayImagInput_process;


  XQMapped_signed <= signed(XQMapped);

  yQMapped_signed <= signed(yQMapped);

  DelayQuadMapper1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin1 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin1 <= XQMapped_signed;
      END IF;
    END IF;
  END PROCESS DelayQuadMapper1_process;


  DelayQuadMapper2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin1 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin1 <= yQMapped_signed;
      END IF;
    END IF;
  END PROCESS DelayQuadMapper2_process;


  shift1 <= to_unsigned(16#01#, 5);

  xout1_signed <= signed(xout1);

  yout1_signed <= signed(yout1);

  Pipeline1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin2 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin2 <= xout1_signed;
      END IF;
    END IF;
  END PROCESS Pipeline1_process;


  Pipeline1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin2 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin2 <= yout1_signed;
      END IF;
    END IF;
  END PROCESS Pipeline1_1_process;


  shift2 <= to_unsigned(16#02#, 5);

  xout2_signed <= signed(xout2);

  yout2_signed <= signed(yout2);

  Pipeline2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin3 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin3 <= xout2_signed;
      END IF;
    END IF;
  END PROCESS Pipeline2_process;


  Pipeline2_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin3 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin3 <= yout2_signed;
      END IF;
    END IF;
  END PROCESS Pipeline2_1_process;


  shift3 <= to_unsigned(16#03#, 5);

  xout3_signed <= signed(xout3);

  yout3_signed <= signed(yout3);

  Pipeline3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin4 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin4 <= xout3_signed;
      END IF;
    END IF;
  END PROCESS Pipeline3_process;


  Pipeline3_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin4 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin4 <= yout3_signed;
      END IF;
    END IF;
  END PROCESS Pipeline3_1_process;


  shift4 <= to_unsigned(16#04#, 5);

  xout4_signed <= signed(xout4);

  yout4_signed <= signed(yout4);

  Pipeline4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin5 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin5 <= xout4_signed;
      END IF;
    END IF;
  END PROCESS Pipeline4_process;


  Pipeline4_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin5 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin5 <= yout4_signed;
      END IF;
    END IF;
  END PROCESS Pipeline4_1_process;


  shift5 <= to_unsigned(16#05#, 5);

  xout5_signed <= signed(xout5);

  yout5_signed <= signed(yout5);

  Pipeline5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin6 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin6 <= xout5_signed;
      END IF;
    END IF;
  END PROCESS Pipeline5_process;


  Pipeline5_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin6 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin6 <= yout5_signed;
      END IF;
    END IF;
  END PROCESS Pipeline5_1_process;


  shift6 <= to_unsigned(16#06#, 5);

  xout6_signed <= signed(xout6);

  yout6_signed <= signed(yout6);

  Pipeline6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin7 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin7 <= xout6_signed;
      END IF;
    END IF;
  END PROCESS Pipeline6_process;


  Pipeline6_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin7 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin7 <= yout6_signed;
      END IF;
    END IF;
  END PROCESS Pipeline6_1_process;


  shift7 <= to_unsigned(16#07#, 5);

  xout7_signed <= signed(xout7);

  yout7_signed <= signed(yout7);

  Pipeline7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin8 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin8 <= xout7_signed;
      END IF;
    END IF;
  END PROCESS Pipeline7_process;


  Pipeline7_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin8 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin8 <= yout7_signed;
      END IF;
    END IF;
  END PROCESS Pipeline7_1_process;


  shift8 <= to_unsigned(16#08#, 5);

  xout8_signed <= signed(xout8);

  yout8_signed <= signed(yout8);

  Pipeline8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin9 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin9 <= xout8_signed;
      END IF;
    END IF;
  END PROCESS Pipeline8_process;


  Pipeline8_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin9 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin9 <= yout8_signed;
      END IF;
    END IF;
  END PROCESS Pipeline8_1_process;


  shift9 <= to_unsigned(16#09#, 5);

  xout9_signed <= signed(xout9);

  yout9_signed <= signed(yout9);

  Pipeline9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin10 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin10 <= xout9_signed;
      END IF;
    END IF;
  END PROCESS Pipeline9_process;


  Pipeline9_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin10 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin10 <= yout9_signed;
      END IF;
    END IF;
  END PROCESS Pipeline9_1_process;


  shift10 <= to_unsigned(16#0A#, 5);

  xout10_signed <= signed(xout10);

  yout10_signed <= signed(yout10);

  Pipeline10_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin11 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin11 <= xout10_signed;
      END IF;
    END IF;
  END PROCESS Pipeline10_process;


  Pipeline10_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin11 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        yin11 <= yout10_signed;
      END IF;
    END IF;
  END PROCESS Pipeline10_1_process;


  shift11 <= to_unsigned(16#0B#, 5);

  xout11_signed <= signed(xout11);

  Delay_ValidIn_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_ValidIn_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_ValidIn_reg(0) <= validIn;
        Delay_ValidIn_reg(13 DOWNTO 1) <= Delay_ValidIn_reg(12 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS Delay_ValidIn_process;

  ValidOutDelayed <= Delay_ValidIn_reg(13);

  reset_outval <=  NOT ValidOutDelayed;

  Pipeline11_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin12 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin12 <= xout11_signed;
      END IF;
    END IF;
  END PROCESS Pipeline11_process;


  -- CSD Encoding (7035) : 1001'001'00001'01'; Cost (Adders) = 4
  CSD_Gain_Factor_mul_temp <= (((resize(xin12 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 27) - resize(xin12 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 27)) - resize(xin12 & '0' & '0' & '0' & '0' & '0' & '0' & '0', 27)) - resize(xin12 & '0' & '0', 27)) - resize(xin12, 27);
  CSD_Gain_Factor_cast <= CSD_Gain_Factor_mul_temp(25 DOWNTO 0);
  xoutscaled <= CSD_Gain_Factor_cast(25 DOWNTO 13);

  zeroC <= to_signed(16#0000#, 13);

  
  outSwitchMag <= xoutscaled WHEN reset_outval = '0' ELSE
      zeroC;

  Output_Register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin13 <= to_signed(16#0000#, 13);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xin13 <= outSwitchMag;
      END IF;
    END IF;
  END PROCESS Output_Register_process;


  magnitude <= std_logic_vector(xin13);

END rtl;
