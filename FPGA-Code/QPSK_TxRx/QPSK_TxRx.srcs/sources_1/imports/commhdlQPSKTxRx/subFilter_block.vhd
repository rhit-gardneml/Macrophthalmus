-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\subFilter_block.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: subFilter_block
-- Source Path: commhdlQPSKTxRx/QPSK Rx/RRC Receive Filter/Filter/subFilter
-- Hierarchy Level: 3
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.QPSK_Rx_pkg.ALL;

ENTITY subFilter_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dinReg2_0_re                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        coefIn                            :   IN    vector_of_std_logic_vector16(0 TO 16);  -- sfix16_En15 [17]
        dinRegVld                         :   IN    std_logic;
        syncReset                         :   IN    std_logic;
        dout_1_re                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
        doutVld                           :   OUT   std_logic
        );
END subFilter_block;


ARCHITECTURE rtl OF subFilter_block IS

  -- Component Declarations
  COMPONENT FilterTapSystolicPreAddWvlIn
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          dinReg2_0_re                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dinPreAdd                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          coefIn_0                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          addin                           :   IN    std_logic_vector(32 DOWNTO 0);  -- sfix33_En29
          dinRegVld                       :   IN    std_logic;
          syncReset                       :   IN    std_logic;
          dinDly2                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          tapout                          :   OUT   std_logic_vector(32 DOWNTO 0)  -- sfix33_En29
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : FilterTapSystolicPreAddWvlIn
    USE ENTITY work.FilterTapSystolicPreAddWvlIn(rtl);

  -- Signals
  SIGNAL intdelay_reg                     : std_logic_vector(12 DOWNTO 0);  -- ufix1 [13]
  SIGNAL vldShift                         : std_logic;
  SIGNAL vldOutTmp                        : std_logic;
  SIGNAL ZERO_OUT                         : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL addin                            : signed(32 DOWNTO 0);  -- sfix33_En29
  SIGNAL dinPreAdd                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dinDly2                          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dinDly2_signed                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dinDly2_1                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout                           : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL dinDly2_2                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout_1                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL dinDly2_3                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout_2                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL dinDly2_4                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout_3                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL dinDly2_5                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout_4                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL dinDly2_6                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout_5                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL dinDly2_7                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout_6                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL tapout_7                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL ZERO                             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dinDly2deadOut                   : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tapout_8                         : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL tapout_signed                    : signed(32 DOWNTO 0);  -- sfix33_En29
  SIGNAL dout_cast                        : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL muxOut                           : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL dout_1_re_tmp                    : signed(15 DOWNTO 0);  -- sfix16_En12

BEGIN
  u_FilterTap_1 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinReg2_0_re,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(0),  -- sfix16_En15
              addin => std_logic_vector(addin),  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2_1,  -- sfix16_En14
              tapout => tapout  -- sfix33_En29
              );

  u_FilterTap_2 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2_1,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(1),  -- sfix16_En15
              addin => tapout,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2_2,  -- sfix16_En14
              tapout => tapout_1  -- sfix33_En29
              );

  u_FilterTap_3 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2_2,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(2),  -- sfix16_En15
              addin => tapout_1,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2_3,  -- sfix16_En14
              tapout => tapout_2  -- sfix33_En29
              );

  u_FilterTap_4 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2_3,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(3),  -- sfix16_En15
              addin => tapout_2,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2_4,  -- sfix16_En14
              tapout => tapout_3  -- sfix33_En29
              );

  u_FilterTap_5 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2_4,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(4),  -- sfix16_En15
              addin => tapout_3,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2_5,  -- sfix16_En14
              tapout => tapout_4  -- sfix33_En29
              );

  u_FilterTap_6 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2_5,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(5),  -- sfix16_En15
              addin => tapout_4,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2_6,  -- sfix16_En14
              tapout => tapout_5  -- sfix33_En29
              );

  u_FilterTap_7 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2_6,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(6),  -- sfix16_En15
              addin => tapout_5,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2_7,  -- sfix16_En14
              tapout => tapout_6  -- sfix33_En29
              );

  u_FilterTap_8 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2_7,  -- sfix16_En14
              dinPreAdd => std_logic_vector(dinPreAdd),  -- sfix16_En14
              coefIn_0 => coefIn(7),  -- sfix16_En15
              addin => tapout_6,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2,  -- sfix16_En14
              tapout => tapout_7  -- sfix33_En29
              );

  u_FilterTap_9 : FilterTapSystolicPreAddWvlIn
    PORT MAP( clk => clk,
              enb => enb,
              dinReg2_0_re => dinDly2,  -- sfix16_En14
              dinPreAdd => std_logic_vector(ZERO),  -- sfix16_En14
              coefIn_0 => coefIn(8),  -- sfix16_En15
              addin => tapout_7,  -- sfix33_En29
              dinRegVld => dinRegVld,
              syncReset => syncReset,
              dinDly2 => dinDly2deadOut,  -- sfix16_En14
              tapout => tapout_8  -- sfix33_En29
              );

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF syncReset = '1' THEN
          intdelay_reg <= (OTHERS => '0');
        ELSIF dinRegVld = '1' THEN
          intdelay_reg(0) <= dinRegVld;
          intdelay_reg(12 DOWNTO 1) <= intdelay_reg(11 DOWNTO 0);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_process;

  vldShift <= intdelay_reg(12);

  vldOutTmp <= dinRegVld AND vldShift;

  ZERO_OUT <= to_signed(16#0000#, 16);

  addin <= to_signed(0, 33);

  dinDly2_signed <= signed(dinDly2);

  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dinPreAdd <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF syncReset = '1' THEN
          dinPreAdd <= to_signed(16#0000#, 16);
        ELSIF dinRegVld = '1' THEN
          dinPreAdd <= dinDly2_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_1_process;


  ZERO <= to_signed(16#0000#, 16);

  tapout_signed <= signed(tapout_8);

  dout_cast <= tapout_signed(32 DOWNTO 17);

  
  muxOut <= ZERO_OUT WHEN vldOutTmp = '0' ELSE
      dout_cast;

  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dout_1_re_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF syncReset = '1' THEN
          dout_1_re_tmp <= to_signed(16#0000#, 16);
        ELSE 
          dout_1_re_tmp <= muxOut;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_2_process;


  dout_1_re <= std_logic_vector(dout_1_re_tmp);

  intdelay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      doutVld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF syncReset = '1' THEN
          doutVld <= '0';
        ELSE 
          doutVld <= vldOutTmp;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_3_process;


END rtl;

