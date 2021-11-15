-- a5 - based on second algorithm

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std.unsigned;

entity sqrt_a5 is
  generic (n : integer := 2);
  port(
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    input : in unsigned(2*n-1 downto 0);
    done_flag : out std_logic;
    result : out unsigned(n-1 downto 0)
  );
end sqrt_a5;

architecture a5 of sqrt_a5 is

begin

end architecture;
