library ieee;
use ieee.std_logic_1164.all;

entity half_adder_tb is
end half_adder_tb;

architecture tb of half_adder_tb is
    component half_adder is
        port (
                A : in std_logic;
                B : in std_logic;
                R : out std_logic;
                C : out std_logic
             );
    end component;

    signal a, b, r, c : std_logic;
begin
    --instantiate half_adder
    h1 : half_adder port map(a, b, r, c);
    process
    begin
        a <= '0';
        b <= '0';
        wait for 15 ns;
        wait;
    end process;
end tb;
