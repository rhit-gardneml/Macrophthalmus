-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\WaveformGen.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: WaveformGen
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Carrier Synchronizer/Direct Digital Synthesis/NCO/WaveformGen
-- Hierarchy Level: 5
-- Model version: 7.26
-- 
-- Wave form Generation Component
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY WaveformGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        phaseIdx                          :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14_E7
        exp_re                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        exp_im                            :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END WaveformGen;


ARCHITECTURE rtl OF WaveformGen IS

  -- Component Declarations
  COMPONENT CosLookUpTableGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          lutaddr                         :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          lutCosine                       :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  COMPONENT SinLookUpTableGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          lutaddr                         :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          lutSine                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CosLookUpTableGen
    USE ENTITY work.CosLookUpTableGen(rtl);

  FOR ALL : SinLookUpTableGen
    USE ENTITY work.SinLookUpTableGen(rtl);

  -- Signals
  SIGNAL phaseIdx_unsigned                : unsigned(13 DOWNTO 0);  -- ufix14_E7
  SIGNAL phaseIdxReg                      : unsigned(13 DOWNTO 0);  -- ufix14_E7
  SIGNAL msb1                             : std_logic;  -- ufix1
  SIGNAL msb2                             : std_logic;  -- ufix1
  SIGNAL signSel                          : std_logic;  -- ufix1
  SIGNAL signSelRegComp_reg               : std_logic_vector(2 DOWNTO 0);  -- ufix1 [3]
  SIGNAL signSelReg                       : std_logic;  -- ufix1
  SIGNAL lutaddr1                         : unsigned(11 DOWNTO 0);  -- ufix12
  SIGNAL sin45Sel                         : std_logic;  -- ufix1
  SIGNAL sin45SelRegComp_reg              : std_logic_vector(2 DOWNTO 0);  -- ufix1 [3]
  SIGNAL sin45SelReg                      : std_logic;  -- ufix1
  SIGNAL msb3                             : std_logic;  -- ufix1
  SIGNAL lutSel                           : std_logic;  -- ufix1
  SIGNAL lutSelRegComp_reg                : std_logic_vector(2 DOWNTO 0);  -- ufix1 [3]
  SIGNAL lutSelReg                        : std_logic;  -- ufix1
  SIGNAL lutaddrmax                       : unsigned(12 DOWNTO 0);  -- ufix13
  SIGNAL lutaddr2                         : unsigned(11 DOWNTO 0);  -- ufix12
  SIGNAL lutaddr                          : unsigned(11 DOWNTO 0);  -- ufix12
  SIGNAL lutaddrO                         : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL lutoutcos                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL lutoutcos_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL lutoutsin                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL lutoutsin_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL lutselcos                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL octantVal                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL fullcosmag                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL uminus_cast                      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL uminus_cast_1                    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL inverseCos                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL cosout                           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL sineSignSelRegComp_reg           : std_logic_vector(2 DOWNTO 0);  -- ufix1 [3]
  SIGNAL sineSignSelReg                   : std_logic;  -- ufix1
  SIGNAL lutselsin                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL fullsinmag                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL uminus_cast_2                    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL uminus_cast_3                    : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL inverseSin                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL sinout                           : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  u_Cos_Wave_inst : CosLookUpTableGen
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              lutaddr => std_logic_vector(lutaddrO),  -- ufix11
              lutCosine => lutoutcos  -- sfix16_En14
              );

  u_Sin_Wave_inst : SinLookUpTableGen
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              lutaddr => std_logic_vector(lutaddrO),  -- ufix11
              lutSine => lutoutsin  -- sfix16_En14
              );

  phaseIdx_unsigned <= unsigned(phaseIdx);

  phaseIdxRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phaseIdxReg <= to_unsigned(16#0000#, 14);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        phaseIdxReg <= phaseIdx_unsigned;
      END IF;
    END IF;
  END PROCESS phaseIdxRegister_process;


  -- Sine sign selection signal
  msb1 <= phaseIdxReg(13);

  msb2 <= phaseIdxReg(12);

  -- Cosine sign selection signal
  signSel <= msb1 XOR msb2;

  signSelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      signSelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        signSelRegComp_reg(0) <= signSel;
        signSelRegComp_reg(2 DOWNTO 1) <= signSelRegComp_reg(1 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS signSelRegComp_process;

  signSelReg <= signSelRegComp_reg(2);

  lutaddr1 <= phaseIdxReg(11 DOWNTO 0);

  -- 45 degree address
  
  sin45Sel <= '1' WHEN lutaddr1 = to_unsigned(16#800#, 12) ELSE
      '0';

  sin45SelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sin45SelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        sin45SelRegComp_reg(0) <= sin45Sel;
        sin45SelRegComp_reg(2 DOWNTO 1) <= sin45SelRegComp_reg(1 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS sin45SelRegComp_process;

  sin45SelReg <= sin45SelRegComp_reg(2);

  msb3 <= phaseIdxReg(11);

  -- LUT selection signal
  lutSel <= msb2 XOR msb3;

  lutSelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      lutSelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        lutSelRegComp_reg(0) <= lutSel;
        lutSelRegComp_reg(2 DOWNTO 1) <= lutSelRegComp_reg(1 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS lutSelRegComp_process;

  lutSelReg <= lutSelRegComp_reg(2);

  -- Map LUT address in correct phase
  lutaddrmax <= to_unsigned(16#1000#, 13);

  lutaddr2 <= resize(resize(lutaddrmax, 14) - resize(lutaddr1, 14), 12);

  
  lutaddr <= lutaddr1 WHEN msb3 = '0' ELSE
      lutaddr2;

  lutaddrO <= lutaddr(10 DOWNTO 0);

  lutoutcos_signed <= signed(lutoutcos);

  lutoutsin_signed <= signed(lutoutsin);

  -- Select cosine output LUT
  
  lutselcos <= lutoutcos_signed WHEN lutSelReg = '0' ELSE
      lutoutsin_signed;

  octantVal <= to_signed(16#2D41#, 16);

  -- Assign cosine pi/4 value
  
  fullcosmag <= lutselcos WHEN sin45SelReg = '0' ELSE
      octantVal;

  uminus_cast <= resize(fullcosmag, 17);
  uminus_cast_1 <=  - (uminus_cast);
  inverseCos <= uminus_cast_1(15 DOWNTO 0);

  -- Select sign of cosine ouptput
  
  cosout <= fullcosmag WHEN signSelReg = '0' ELSE
      inverseCos;

  exp_re <= std_logic_vector(cosout);

  sineSignSelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sineSignSelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        sineSignSelRegComp_reg(0) <= msb1;
        sineSignSelRegComp_reg(2 DOWNTO 1) <= sineSignSelRegComp_reg(1 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS sineSignSelRegComp_process;

  sineSignSelReg <= sineSignSelRegComp_reg(2);

  -- Select sine output LUT
  
  lutselsin <= lutoutsin_signed WHEN lutSelReg = '0' ELSE
      lutoutcos_signed;

  -- Assign sine pi/4 value
  
  fullsinmag <= lutselsin WHEN sin45SelReg = '0' ELSE
      octantVal;

  uminus_cast_2 <= resize(fullsinmag, 17);
  uminus_cast_3 <=  - (uminus_cast_2);
  inverseSin <= uminus_cast_3(15 DOWNTO 0);

  -- Select sign of sine output
  
  sinout <= fullsinmag WHEN sineSignSelReg = '0' ELSE
      inverseSin;

  exp_im <= std_logic_vector(sinout);

END rtl;

