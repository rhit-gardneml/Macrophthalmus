----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2023 04:34:30 PM
-- Design Name: 
-- Module Name: BitSeperator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


-- Filename: BitSeperator.vhd
-- Author: Tori Robinson
-- Date: 10/29/2023
-- Purpose: 

entity BitSeperator is port (
    clk           : std_logic;
    reset         : std_logic;
    in_bits       : in std_logic_vector(15 downto 0);
    out_bit       : out std_logic
 );
end BitSeperator;

architecture Behavioral of BitSeperator is
signal middle : std_logic_vector(2 downto 0); 
signal hold   : std_logic_vector(15 downto 0);
signal shift  : std_logic;

signal counter : std_logic_vector(15 downto 0);
signal count    : std_logic;
signal done_counting    : std_logic;

type state_type is (S0, S1, S2, S3);
signal next_state, current_state: state_type;
begin
middle <= "111"; -- 7 bits

bitcounter: process(clk, reset, in_bits)
begin
    if(reset = '1' or done_counting = '1') then
        counter <= (others =>'0');
    elsif(clk = '1' and clk'event) then
        if(count = '1') then
            counter <= counter + 1;
        end if;
   end if;
end process;

shiftregister: process(clk, reset, in_bits)
begin
    if(reset = '1') then
        hold <= in_bits;
    elsif(clk ='1' and clk'event) then
        if(shift = '1') then
            hold <= in_bits(14 downto 0) & '0';
        end if;
    end if;
end process;

state_reg : process(clk, reset, next_state)
begin
    if(reset = '1') then
        current_state <= S0;
    elsif(clk = '1' and clk'event) then
        current_state <= next_state;
    end if;
end process;

fsm: process(current_state, counter,  in_bits)
begin
    count <= '0';
    shift <= '0';
    
    case current_state is
        when S0 => 
            if(counter = "11") then
                next_state <= S1;
            else 
                next_state <= S0;
            end if;
            count <= '1';
            shift <= '1';
        when S1 =>
            if(hold(13 downto 11) >= middle) then
                out_bit <= '1';
                next_state <= S0;
            else 
                out_bit <= '0';
                next_state <= S0;
            end if;
            done_counting <= '1';
        when others =>
            next_state <= S0;
    end case;
end process;

--output : process(output_flag, clk, reset)
--begin
  --  if(reset = '1')
       
--end process;
end Behavioral;
