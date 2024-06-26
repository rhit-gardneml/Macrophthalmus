-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\Loop_Filter_block1.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Loop_Filter_block1
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Symbol Synchronizer/Loop Filter
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.QPSK_Rx_pkg.ALL;

ENTITY Loop_Filter_block1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        e                                 :   IN    std_logic_vector(39 DOWNTO 0);  -- sfix40_En24
        v                                 :   OUT   std_logic_vector(10 DOWNTO 0)  -- sfix11_En10
        );
END Loop_Filter_block1;


ARCHITECTURE rtl OF Loop_Filter_block1 IS

  -- Signals
  SIGNAL e_signed                         : signed(39 DOWNTO 0);  -- sfix40_En24
  SIGNAL Delay2_reg                       : vector_of_signed40(0 TO 1);  -- sfix40 [2]
  SIGNAL Delay2_out1                      : signed(39 DOWNTO 0);  -- sfix40_En24
  SIGNAL K1_mul_temp                      : signed(63 DOWNTO 0);  -- sfix64_En48
  SIGNAL K1_out1                          : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Delay3_reg                       : vector_of_signed30(0 TO 1);  -- sfix30 [2]
  SIGNAL Delay3_out1                      : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Delay1_out1                      : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL K2_mul_temp                      : signed(63 DOWNTO 0);  -- sfix64_En48
  SIGNAL K2_out1                          : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Delay5_reg                       : vector_of_signed30(0 TO 1);  -- sfix30 [2]
  SIGNAL Delay5_out1                      : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Delay6_out1                      : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Add2_out1                        : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Delay_out1                       : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Delay4_out1                      : signed(29 DOWNTO 0);  -- sfix30_En23
  SIGNAL Add_add_cast                     : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Add_add_cast_1                   : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Add_out1                         : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Data_Type_Conversion17_out1      : signed(10 DOWNTO 0);  -- sfix11_En10

BEGIN
  -- Proportional-Plus-Integrator Loop Filter,
  -- Infinite DC Response to guarantee convergence

  e_signed <= signed(e);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_reg <= (OTHERS => to_signed(0, 40));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_reg(0) <= e_signed;
        Delay2_reg(1) <= Delay2_reg(0);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1 <= Delay2_reg(1);

  K1_mul_temp <= to_signed(-16#027EB2#, 24) * Delay2_out1;
  K1_out1 <= K1_mul_temp(54 DOWNTO 25);

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_reg <= (OTHERS => to_signed(16#00000000#, 30));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_reg(0) <= K1_out1;
        Delay3_reg(1) <= Delay3_reg(0);
      END IF;
    END IF;
  END PROCESS Delay3_process;

  Delay3_out1 <= Delay3_reg(1);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(16#00000000#, 30);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Delay3_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  K2_mul_temp <= to_signed(-16#000884#, 24) * Delay2_out1;
  K2_out1 <= K2_mul_temp(54 DOWNTO 25);

  Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_reg <= (OTHERS => to_signed(16#00000000#, 30));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_reg(0) <= K2_out1;
        Delay5_reg(1) <= Delay5_reg(0);
      END IF;
    END IF;
  END PROCESS Delay5_process;

  Delay5_out1 <= Delay5_reg(1);

  Delay6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_out1 <= to_signed(16#00000000#, 30);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay6_out1 <= Delay5_out1;
      END IF;
    END IF;
  END PROCESS Delay6_process;


  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_signed(16#00000000#, 30);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= Add2_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  Add2_out1 <= Delay6_out1 + Delay_out1;

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= to_signed(16#00000000#, 30);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_out1 <= Add2_out1;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Add_add_cast <= resize(Delay1_out1, 31);
  Add_add_cast_1 <= resize(Delay4_out1, 31);
  Add_out1 <= Add_add_cast + Add_add_cast_1;

  Data_Type_Conversion17_out1 <= Add_out1(23 DOWNTO 13);

  v <= std_logic_vector(Data_Type_Conversion17_out1);

END rtl;

