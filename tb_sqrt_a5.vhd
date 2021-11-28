--testbench of mini_project_1_a2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- testbench entity: empty
entity tb_sqrt_a5 is
end tb_sqrt_a5;

architecture a5_sim of tb_sqrt_a5 is

-- tested components
component sqrt_a5 is
    generic (
    n : integer := 4;
    n_min1 : integer := 2
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
		    start : in std_logic;
        input : in unsigned(2*n-1 downto 0);
        done : out std_logic;
        result : out unsigned(2*n-1 downto 0)
    );
end component;

constant clk_period : time := 50 ns;
constant n : integer := 4;
constant n_min1 : integer := 2;

signal clk, reset, start, done : std_logic := '0'; -- with start

signal input : unsigned(2*n-1 downto 0) := (others => '0');
signal result : unsigned(2*n-1 downto 0) := (others => '0');

begin

  DUT : entity work.sqrt_a5 generic map(n => 4)
          port map (clk, reset, start, input, done, result);

  P_init : process
  variable i : integer := 0;
  begin

    input <= to_unsigned(9, input'length);
    reset <= '1';
    start <= '0';
  	wait for clk_period;

    reset <= '0';
    wait for clk_period;
  	start <= '1';

    wait for 300 ns;
    start <= '0';
    wait for clk_period;
    start <= '1';
    wait;
  end process;

   P_clk : process
	 begin
     wait for clk_period/2;
	 clk <= not clk;
   end process;

end architecture;
