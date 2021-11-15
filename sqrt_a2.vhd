-- using finite state machines
-- works for specified iterations

-- > how to change value of input during the transition of iteration
-- > fix result <= temp_result

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std.unsigned;

entity sqrt_a2 is
    generic (n : integer := 2);
    port(
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      input : in unsigned(2*n-1 downto 0);
      done_flag : out std_logic;
      result : out unsigned(n-1 downto 0)
    );
end sqrt_a2;


architecture a2 of sqrt_a2 is

  type statetype is (idle, comp, final);
  signal state : statetype;
  signal i : integer := 0;
  signal num_in : unsigned(2*n-1 downto 0);
  signal V : unsigned(2*n-1 downto 0);
  signal temp_result : unsigned(n-1 downto 0);

begin

  p_sqrt : process(reset, clk)
  variable Z : unsigned(2*n-1 downto 0) := (others => '0');
  begin
    if (reset = '1') then
      done_flag <= '0';
      result <= (others => '0');
      num_in <= (others => '0');
      V <= (others => '0');
      Z := (others => '0');

      temp_result <= (others => '0');

    elsif (rising_edge(clk)) then
      case state is
        when idle =>
          if (start = '1') then
            num_in <= input;
            V <= (2*n-2 => '1', others => '0');
            Z := (others => '0');
            i <= n-1;

            state <= comp;
          end if;

        when comp =>
          Z := Z+V;
          if (signed(num_in-Z) >= 0) then
              num_in <= num_in-Z;
              Z := Z+V;
          else
              Z := Z-V;
          end if;
          Z := Z/2;
          V <= V/4;

          if (i = 0) then
            state <= final;
            done_flag <= '1';
          else
            i <= i-1;
          end if;

        when final =>
          if (start = '0') then
            state <= idle;
            done_flag <= '0';
          end if;
      end case;
    end if;
    temp_result <= resize(Z, result'length);
  end process;
  result <= temp_result; -- result is not yet readeable to the processor

end architecture;
