library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


-- Filename: BitSeperator.vhd
-- Author: Tori Robinson
-- Date: 10/29/2023
-- Purpose: 

entity Sin_Generator is port (
    clk           : std_logic;
    reset         : std_logic;
    in_bits       : in std_logic_vector(13 downto 0);
    out_bit       : out std_logic
 );
end Sin_Generator;

architecture Behavioral of Sin_Generator is
