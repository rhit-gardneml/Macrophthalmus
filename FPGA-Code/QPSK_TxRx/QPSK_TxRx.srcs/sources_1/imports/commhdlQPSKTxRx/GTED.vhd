-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\GTED.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: GTED
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Symbol Synchronizer/Gardner TED/GTED
-- Hierarchy Level: 4
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.QPSK_Rx_pkg.ALL;

ENTITY GTED IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1_re                            :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En12
        In1_im                            :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En12
        Out1                              :   OUT   std_logic_vector(39 DOWNTO 0)  -- sfix40_En24
        );
END GTED;


ARCHITECTURE rtl OF GTED IS

  -- Signals
  SIGNAL In1_re_signed                    : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL In1_im_signed                    : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay_out1                       : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay1_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay8_reg                       : vector_of_signed19(0 TO 1);  -- sfix19 [2]
  SIGNAL Delay8_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay2_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay3_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Add1_sub_cast                    : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Add1_sub_cast_1                  : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Add1_out1                        : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Delay9_reg                       : vector_of_signed20(0 TO 1);  -- sfix20 [2]
  SIGNAL Delay9_out1                      : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Product_out1                     : signed(38 DOWNTO 0);  -- sfix39_En24
  SIGNAL Delay10_reg                      : vector_of_signed39(0 TO 1);  -- sfix39 [2]
  SIGNAL Delay10_out1                     : signed(38 DOWNTO 0);  -- sfix39_En24
  SIGNAL Delay4_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay5_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay11_reg                      : vector_of_signed19(0 TO 1);  -- sfix19 [2]
  SIGNAL Delay11_out1                     : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay6_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Delay7_out1                      : signed(18 DOWNTO 0);  -- sfix19_En12
  SIGNAL Add2_sub_cast                    : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Add2_sub_cast_1                  : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Add2_out1                        : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Delay12_reg                      : vector_of_signed20(0 TO 1);  -- sfix20 [2]
  SIGNAL Delay12_out1                     : signed(19 DOWNTO 0);  -- sfix20_En12
  SIGNAL Product1_out1                    : signed(38 DOWNTO 0);  -- sfix39_En24
  SIGNAL Delay13_reg                      : vector_of_signed39(0 TO 1);  -- sfix39 [2]
  SIGNAL Delay13_out1                     : signed(38 DOWNTO 0);  -- sfix39_En24
  SIGNAL Add_add_cast                     : signed(39 DOWNTO 0);  -- sfix40_En24
  SIGNAL Add_add_cast_1                   : signed(39 DOWNTO 0);  -- sfix40_En24
  SIGNAL Add_out1                         : signed(39 DOWNTO 0);  -- sfix40_En24

BEGIN
  In1_re_signed <= signed(In1_re);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= In1_re_signed;
      END IF;
    END IF;
  END PROCESS Delay_process;


  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Delay_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Delay8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay8_reg <= (OTHERS => to_signed(16#00000#, 19));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay8_reg(0) <= Delay1_out1;
        Delay8_reg(1) <= Delay8_reg(0);
      END IF;
    END IF;
  END PROCESS Delay8_process;

  Delay8_out1 <= Delay8_reg(1);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= Delay1_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= Delay2_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Add1_sub_cast <= resize(Delay3_out1, 20);
  Add1_sub_cast_1 <= resize(In1_re_signed, 20);
  Add1_out1 <= Add1_sub_cast - Add1_sub_cast_1;

  Delay9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay9_reg <= (OTHERS => to_signed(16#00000#, 20));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay9_reg(0) <= Add1_out1;
        Delay9_reg(1) <= Delay9_reg(0);
      END IF;
    END IF;
  END PROCESS Delay9_process;

  Delay9_out1 <= Delay9_reg(1);

  Product_out1 <= Delay8_out1 * Delay9_out1;

  Delay10_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay10_reg <= (OTHERS => to_signed(0, 39));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay10_reg(0) <= Product_out1;
        Delay10_reg(1) <= Delay10_reg(0);
      END IF;
    END IF;
  END PROCESS Delay10_process;

  Delay10_out1 <= Delay10_reg(1);

  In1_im_signed <= signed(In1_im);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_out1 <= In1_im_signed;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_out1 <= Delay4_out1;
      END IF;
    END IF;
  END PROCESS Delay5_process;


  Delay11_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay11_reg <= (OTHERS => to_signed(16#00000#, 19));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay11_reg(0) <= Delay5_out1;
        Delay11_reg(1) <= Delay11_reg(0);
      END IF;
    END IF;
  END PROCESS Delay11_process;

  Delay11_out1 <= Delay11_reg(1);

  Delay6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay6_out1 <= Delay5_out1;
      END IF;
    END IF;
  END PROCESS Delay6_process;


  Delay7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay7_out1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay7_out1 <= Delay6_out1;
      END IF;
    END IF;
  END PROCESS Delay7_process;


  Add2_sub_cast <= resize(Delay7_out1, 20);
  Add2_sub_cast_1 <= resize(In1_im_signed, 20);
  Add2_out1 <= Add2_sub_cast - Add2_sub_cast_1;

  Delay12_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay12_reg <= (OTHERS => to_signed(16#00000#, 20));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay12_reg(0) <= Add2_out1;
        Delay12_reg(1) <= Delay12_reg(0);
      END IF;
    END IF;
  END PROCESS Delay12_process;

  Delay12_out1 <= Delay12_reg(1);

  Product1_out1 <= Delay11_out1 * Delay12_out1;

  Delay13_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay13_reg <= (OTHERS => to_signed(0, 39));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay13_reg(0) <= Product1_out1;
        Delay13_reg(1) <= Delay13_reg(0);
      END IF;
    END IF;
  END PROCESS Delay13_process;

  Delay13_out1 <= Delay13_reg(1);

  Add_add_cast <= resize(Delay10_out1, 40);
  Add_add_cast_1 <= resize(Delay13_out1, 40);
  Add_out1 <= Add_add_cast + Add_add_cast_1;

  Out1 <= std_logic_vector(Add_out1);

END rtl;

