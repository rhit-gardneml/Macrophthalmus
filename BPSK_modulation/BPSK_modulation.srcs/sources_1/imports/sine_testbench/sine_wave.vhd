-- Synthesisable design for a sine wave generator
-- Copyright Doulos Ltd
-- SD, 07 Aug 2003

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sine_package.all;

entity sine_wave is
  port( clock, reset, enable: in std_logic;
        wave_out: out sine_vector_type);
end;

architecture arch1 of sine_wave is
  type state_type is ( counting_up, change_down, counting_down, change_up );
  signal state, next_state: state_type;
  signal table_index: table_index_type;
  signal positive_cycle: boolean;
begin

  process( clock, reset )
  begin
    if reset = '1' then
      state <= counting_up;
    elsif rising_edge( clock ) then
      if enable = '1' then
        state <= next_state;
      end if;
    end if;
  end process;

  process( state, table_index )
  begin
    next_state <= state;
    case state is
      when counting_up =>
        if table_index = max_table_index then
          next_state <= change_down;
        end if;
      when change_down =>
        next_state <= counting_down;
      when counting_down =>
        if table_index = 0 then
          next_state <= change_up;
        end if;
      when others => -- change_up
        next_state <= counting_up;
    end case;
  end process;

  process( clock, reset )
  begin
    if reset = '1' then
      table_index <= 0;
      positive_cycle <= true;
    elsif rising_edge( clock ) then
      if enable = '1' then
        case next_state is
          when counting_up =>
            table_index <= table_index + 1;
          when counting_down =>
            table_index <= table_index - 1;
          when change_up =>
            positive_cycle <= not positive_cycle;
          when others =>
            -- nothing to do
        end case;
      end if;
    end if;
  end process;

  process( table_index, positive_cycle )
    variable table_value: table_value_type;
  begin
    table_value := get_table_value( table_index );
    if positive_cycle then
      wave_out <= std_logic_vector(to_signed(table_value,sine_vector_type'length));
    else
      wave_out <= std_logic_vector(to_signed(-table_value,sine_vector_type'length));
    end if;
  end process;

end;

