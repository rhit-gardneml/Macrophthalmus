-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\commhdlQPSKTxRx\MATLAB_Function_block1.vhd
-- Created: 2024-01-25 16:33:03
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: MATLAB_Function_block1
-- Source Path: commhdlQPSKTxRx/QPSK Rx/Frequency and Time Synchronizer/Symbol Synchronizer/Rate Handle/FIFO/Validate 
-- Input Push Pop/MATLAB Functio
-- Hierarchy Level: 6
-- Model version: 7.26
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MATLAB_Function_block1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        rst                               :   IN    std_logic;
        enb_1                             :   IN    std_logic;
        dir                               :   IN    std_logic;
        count                             :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
        );
END MATLAB_Function_block1;


ARCHITECTURE rtl OF MATLAB_Function_block1 IS

  -- Signals
  SIGNAL count_tmp                        : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL countReg                         : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL countReg_next                    : unsigned(5 DOWNTO 0);  -- ufix6

BEGIN
  MATLAB_Function_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      countReg <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        countReg <= countReg_next;
      END IF;
    END IF;
  END PROCESS MATLAB_Function_process;

  MATLAB_Function_output : PROCESS (countReg, dir, enb_1, rst)
    VARIABLE countReg_temp : unsigned(5 DOWNTO 0);
    VARIABLE sub_cast : unsigned(6 DOWNTO 0);
    VARIABLE sub_cast_0 : signed(7 DOWNTO 0);
    VARIABLE sub_temp : signed(7 DOWNTO 0);
    VARIABLE cast : unsigned(6 DOWNTO 0);
    VARIABLE add_temp : unsigned(6 DOWNTO 0);
  BEGIN
    sub_temp := to_signed(16#00#, 8);
    add_temp := to_unsigned(16#00#, 7);
    sub_cast := to_unsigned(16#00#, 7);
    sub_cast_0 := to_signed(16#00#, 8);
    cast := to_unsigned(16#00#, 7);
    countReg_temp := countReg;
    IF rst = '1' THEN 
      countReg_temp := to_unsigned(16#00#, 6);
    ELSIF enb_1 = '1' THEN 
      IF dir = '1' THEN 
        IF countReg = to_unsigned(16#20#, 6) THEN 
          countReg_temp := to_unsigned(16#00#, 6);
        ELSE 
          add_temp := resize(countReg, 7) + to_unsigned(16#01#, 7);
          IF add_temp(6) /= '0' THEN 
            countReg_temp := "111111";
          ELSE 
            countReg_temp := add_temp(5 DOWNTO 0);
          END IF;
        END IF;
      ELSIF countReg = to_unsigned(16#00#, 6) THEN 
        countReg_temp := to_unsigned(16#20#, 6);
      ELSE 
        sub_cast := resize(countReg, 7);
        sub_cast_0 := signed(resize(sub_cast, 8));
        sub_temp := sub_cast_0 - to_signed(16#01#, 8);
        IF sub_temp(7) = '1' THEN 
          cast := "0000000";
        ELSE 
          cast := unsigned(sub_temp(6 DOWNTO 0));
        END IF;
        IF cast(6) /= '0' THEN 
          countReg_temp := "111111";
        ELSE 
          countReg_temp := cast(5 DOWNTO 0);
        END IF;
      END IF;
    END IF;
    count_tmp <= countReg_temp;
    countReg_next <= countReg_temp;
  END PROCESS MATLAB_Function_output;


  count <= std_logic_vector(count_tmp);

END rtl;

