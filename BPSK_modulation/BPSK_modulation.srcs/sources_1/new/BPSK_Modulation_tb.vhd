----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 07:20:53 AM
-- Design Name: 
-- Module Name: BPSK_Modulation_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BPSK_Modulation_tb is
--  Port ( );
end BPSK_Modulation_tb;

architecture Behavioral of BPSK_Modulation_tb is
component BPSK_TopLevel is port(
    clk           : in std_logic;
    reset         : in std_logic;
    enable        : in std_logic;
    ADC_output    : in std_logic_vector(15 downto 0);
    output        : out std_logic_vector(7 downto 0)
);
end component;

signal clock : std_logic := '0';
signal reset : std_logic;

signal ADC_signal : std_logic_vector(15 downto 0);
signal  enable : std_logic;

signal output : std_logic_vector(7 downto 0);
begin

ExampleTestbench: BPSK_TopLevel
port map(
    clk => clock,
    reset => reset,
    enable => enable,
    ADC_output => ADC_signal,
    output => output
);
clock <= not clock after 5 ns;

process begin
    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    enable <= '1';
    ADC_signal <= "0111010101100011";
    wait;
end process;


end Behavioral;
