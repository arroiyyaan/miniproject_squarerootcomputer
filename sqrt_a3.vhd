-- sqrt a3
-- error after 2 -3 iterations

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std.unsigned;

entity sqrt_a3 is
    generic (n : integer := 3);
    port(
      input : in unsigned(2*n-1 downto 0);
      result : out unsigned(n-1 downto 0)
    );
end sqrt_a3;

architecture a3 of sqrt_a3 is

  signal temp_result : unsigned(n-1 downto 0);

begin
  p_sqrt : process(input)
  variable num_in : unsigned(2*n-1 downto 0);
  variable V : unsigned(2*n-1 downto 0);
  variable Z : unsigned(2*n-1 downto 0);


  begin
    num_in := input;
    V := (2*n-2 => '1', others => '0');
    Z := (others => '0');

    for i in n-1 downto 0 loop
      Z := Z + V;

      if (signed(num_in-Z) >= 0) then
          num_in := num_in-Z; -- this was the problem of signal instead of variable
          Z := Z+V;
      else
          Z := Z-V;
      end if;

      Z := Z/2;
      V := V/4;
    end loop;
    temp_result <= resize(Z, result'length);
  end process;
  result <= resize(temp_result, result'length);
end architecture;
