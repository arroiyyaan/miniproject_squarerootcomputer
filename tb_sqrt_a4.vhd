--testbench of mini_project_1_a2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- testbench entity: empty
entity tb_sqrt_a4 is
end tb_sqrt_a4;

architecture a4_sim of tb_sqrt_a4 is

-- tested components
component sqrt_a4 is
    generic (n : integer := 8);
    port(
        clk : in std_logic;
        reset : in std_logic;
		    start : in std_logic;
        input : in unsigned(2*n-1 downto 0);
        done_flag : out std_logic;
        result : out unsigned(n-1 downto 0)
    );
end component;

constant clk_period : time := 50 ns;
constant n : integer := 8;

signal clk, reset, start, done_flag : std_logic := '0'; -- with start

signal input : unsigned(2*n-1 downto 0) := (others => '0');
signal result : unsigned(n-1 downto 0) := (others => '0');

begin

  DUT : entity work.sqrt_a4 generic map(n => 8)
          port map (clk, reset, start, input, done_flag, result);

  P_init : process
  variable i : integer := 0;
  begin

    input <= to_unsigned(16 , input'length);
    reset <= '1';
    start <= '0';
  	wait for clk_period;

    reset <= '0';
    -- wait for clk_period;
  	start <= '1';

    -- wait for 500 ns;
    -- start <= '0';
    -- wait for clk_period;
    -- start <= '1';
    wait;
  end process;

   P_clk : process
	 begin
     wait for clk_period/2;
	 clk <= not clk;
   end process;

end architecture;
