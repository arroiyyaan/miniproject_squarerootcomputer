-- sqrt_a1

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std.unsigned;

entity sqrt_a1 is
    generic (n : integer := 2);
    port(
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      input : in unsigned(2*n-1 downto 0);
      done_flag : out std_logic;
      result : out unsigned(n-1 downto 0)
    );
end sqrt_a1;


architecture a1 of sqrt_a1 is

  type statetype is (idle, comp, final);
  signal state : statetype;
  -- signal i : integer := 0;
  signal num_in : unsigned(2*n-1 downto 0);
  -- signal V : unsigned(2*n-1 downto 0);
  signal temp_result : unsigned(n-1 downto 0);

begin

  p_sqrt : process(reset, clk)

  begin
    if (reset = '1') then
      done_flag <= '0';
      result <= (others => '0');
      num_in <= (others => '0');

      temp_result <= (others => '0');

    elsif (rising_edge(clk)) then
      case state is
        when idle =>
          if (start = '1') then
            num_in <= input;
            temp_result <= to_unsigned(1, temp_result'length);

            state <= comp;
          end if;

        when comp =>
            if (num_in = shift_right(num_in+(input/num_in), 1)) then
              state <= final;
              done_flag <= '1';
            else
              num_in <= shift_right(num_in+(input/num_in), 1);
            end if;

        when final =>
          if (start = '0') then
            state <= idle;
            done_flag <= '0';
          end if;
      end case;
    end if;
    result <= resize(num_in, temp_result'length);
  end process;
end architecture;
