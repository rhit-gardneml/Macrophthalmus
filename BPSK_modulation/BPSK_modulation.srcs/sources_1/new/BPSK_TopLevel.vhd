library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library std;
use ieee.std_logic_textio.all;
use work.sine_package.all;



-- Filename: BitSeperator.vhd
-- Author: Tori Robinson
-- Date: 10/29/2023
-- Purpose: 

entity BPSK_TopLevel is port (
    clk           : in std_logic;
    reset         : in std_logic;
    enable        : in std_logic;
    ADC_output    : in std_logic_vector(15 downto 0);
    output        : out std_logic_vector(7 downto 0)
 );
end BPSK_TopLevel;

architecture Behavioral of BPSK_TopLevel is

component BitSeperator
port(
    clk           : std_logic;
    reset         : std_logic;
    in_bits       : in std_logic_vector(15 downto 0);
    out_bit       : out std_logic
);
end component;

component sine_wave
port(
clock, reset, enable: in std_logic;
        wave_out: out sine_vector_type
);
end component;

constant step      : real := 1.00/real(2**5);

signal v_sine     : sine_vector_type;
signal v_sine_flip : std_logic_vector(14 downto 0) := (others=>'0');
signal outputBit       : std_logic;

begin

Sine_Generate: sine_wave
port map(
    clock=>clk,
    reset => reset,
    enable => enable,
    wave_out => v_sine 
);

BitSeperate: BitSeperator
port map(
    clk => clk,
    reset => reset,
    in_bits => ADC_output,
    out_bit => outputBit
);

process(clk, reset) begin
    if(outputBit = '1') then 
            output <= v_sine;
    else
            output <= (others=>'0');
    end if;
end process;

end Behavioral;

