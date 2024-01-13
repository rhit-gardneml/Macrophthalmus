-- Test bench created by tb_gen_vhdl.pl
-- Copyright Doulos Ltd
-- SD, 10 May 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.sine_package.all;

entity sine_wave_tb is
end;

architecture bench of sine_wave_tb is

component sine_wave
  port( clock, reset, enable: in std_logic;
        wave_out: out sine_vector_type);
end component;

  signal clock, reset, enable: std_logic;
  signal wave_out: sine_vector_type;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: sine_wave port map ( clock, reset, enable, wave_out );

  stimulus: process
  begin
  
    -- Put initialisation code here

    enable <= '0';
    reset <= '1';
    wait for 5 ns;
    reset <= '0';

    wait for 5115 ns;
    enable <= '1';

    -- Put test bench stimulus code here
    wait for 1 ms;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '1', '0' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
