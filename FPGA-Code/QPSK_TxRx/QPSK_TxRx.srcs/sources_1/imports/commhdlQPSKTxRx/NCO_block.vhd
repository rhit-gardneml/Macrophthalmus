-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\NCO_block.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: NCO_block
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Coarse Frequency Compensator/NCO
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- NCO
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY NCO_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        inc                               :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21
        validIn                           :   IN    std_logic;
        complexexp_re                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        complexexp_im                     :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END NCO_block;


ARCHITECTURE rtl OF NCO_block IS

  -- Component Declarations
  COMPONENT WaveformGen_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          phaseIdx                        :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14_E7
          exp_re                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          exp_im                          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : WaveformGen_block
    USE ENTITY work.WaveformGen_block(rtl);

  -- Signals
  SIGNAL outsel_reg_reg                   : std_logic_vector(4 DOWNTO 0);  -- ufix1 [5]
  SIGNAL outsel                           : std_logic;
  SIGNAL outzero_re                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL outzero_im                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL const0                           : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL inc_signed                       : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL validPInc                        : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL accphase_reg                     : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL addpInc                          : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL pOffset                          : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL accoffset                        : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL accoffsete_reg                   : signed(20 DOWNTO 0);  -- sfix21
  SIGNAL accQuantized                     : unsigned(13 DOWNTO 0);  -- ufix14_E7
  SIGNAL outs_re                          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL outs_im                          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL outs_re_signed                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL outs_im_signed                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL validouts_re                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL validouts_im                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL complexexp_re_tmp                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL complexexp_im_tmp                : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  u_Wave_inst : WaveformGen_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              phaseIdx => std_logic_vector(accQuantized),  -- ufix14_E7
              exp_re => outs_re,  -- sfix16_En14
              exp_im => outs_im  -- sfix16_En14
              );

  outsel_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      outsel_reg_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        outsel_reg_reg(0) <= validIn;
        outsel_reg_reg(4 DOWNTO 1) <= outsel_reg_reg(3 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS outsel_reg_process;

  outsel <= outsel_reg_reg(4);

  outzero_re <= to_signed(16#0000#, 16);
  outzero_im <= to_signed(16#0000#, 16);

  -- Constant Zero
  const0 <= to_signed(16#000000#, 21);

  inc_signed <= signed(inc);

  
  validPInc <= const0 WHEN validIn = '0' ELSE
      inc_signed;

  -- Add phase increment
  addpInc <= accphase_reg + validPInc;

  -- Phase increment accumulator register
  AccPhaseRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accphase_reg <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        accphase_reg <= addpInc;
      END IF;
    END IF;
  END PROCESS AccPhaseRegister_process;


  pOffset <= to_signed(16#000000#, 21);

  -- Add phase offset
  accoffset <= accphase_reg + pOffset;

  -- Phase offset accumulator register
  AccOffsetRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accoffsete_reg <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        accoffsete_reg <= accoffset;
      END IF;
    END IF;
  END PROCESS AccOffsetRegister_process;


  -- Phase quantization
  accQuantized <= unsigned(accoffsete_reg(20 DOWNTO 7));

  outs_re_signed <= signed(outs_re);

  outs_im_signed <= signed(outs_im);

  
  validouts_re <= outzero_re WHEN outsel = '0' ELSE
      outs_re_signed;
  
  validouts_im <= outzero_im WHEN outsel = '0' ELSE
      outs_im_signed;

  -- Output register
  OutputRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      complexexp_re_tmp <= to_signed(16#0000#, 16);
      complexexp_im_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        complexexp_re_tmp <= validouts_re;
        complexexp_im_tmp <= validouts_im;
      END IF;
    END IF;
  END PROCESS OutputRegister_process;


  complexexp_re <= std_logic_vector(complexexp_re_tmp);

  complexexp_im <= std_logic_vector(complexexp_im_tmp);

END rtl;
