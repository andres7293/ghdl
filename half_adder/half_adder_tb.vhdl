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
        assert(r = '0') report "R : Error 1" severity error;
        assert(c = '0') report "C : Error 1" severity error;

        a <= '1';
        b <= '0';
        wait for 15 ns;
        assert(r = '1') report "R : Error 2" severity error;
        assert(c = '0') report "C : Error 2" severity error;

        a <= '0';
        b <= '1';
        wait for 15 ns;
        assert(r = '1') report "R : Error 3" severity error;
        assert(c = '0') report "C : Error 3" severity error;

        a <= '1';
        b <= '1';
        wait for 15 ns;
        assert(r = '0') report "R : Error 4" severity error;
        assert(c = '1') report "C : Error 4" severity error;

        wait;
    end process;
end tb;
