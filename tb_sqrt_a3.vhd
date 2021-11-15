--testbench of mini_project_1_a3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- testbench entity: empty
entity tb_sqrt_a3 is
end tb_sqrt_a3;

architecture a3_sim of tb_sqrt_a3 is

-- tested components
component sqrt_a3 is
    generic (n : integer := 3);
    port(
        input : in unsigned(2*n-1 downto 0);
        result : out unsigned(n-1 downto 0)
    );
end component;

constant n : integer := 3;
signal input : unsigned(2*n-1 downto 0) := (others => '0');
signal result : unsigned(n-1 downto 0) := (others => '0');

begin

  DUT : entity work.sqrt_a3 generic map(n => 3)
          port map (input, result);

  P_init : process
  begin
    -- input <= to_unsigned(0, input'length);
    -- wait for 100 ns;
    input <= to_unsigned(4, input'length);
    wait for 1 us;
    input <= to_unsigned(9, input'length);
    wait for 1 us;
    input <= to_unsigned(16, input'length);
    wait for 1 us;
    input <= to_unsigned(9, input'length);
    wait for 1 us;
    input <= to_unsigned(4, input'length);
    wait for 1 us;
    input <= to_unsigned(16, input'length);
    wait;
  end process;
end architecture;
