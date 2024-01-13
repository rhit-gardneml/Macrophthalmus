-- Test bench configuration created by tb_gen_vhdl.pl
-- Copyright Doulos Ltd
-- SD, 10 May 2002
configuration cfg_sine_wave_tb of sine_wave_tb is
  for bench
    for uut: sine_wave
      use entity work.sine_wave(arch1);
    end for;
  end for;
end cfg_sine_wave_tb;
