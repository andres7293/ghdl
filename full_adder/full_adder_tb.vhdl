library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb;

architecture tb of full_adder_tb is
    component full_adder is
        port (
                A      : in std_logic;
                B      : in std_logic;
                Cin    : in std_logic;
                Result : out std_logic;
                Cout   : out std_logic
             );
    end component;

    signal a, b, cin, result, cout : std_logic;
begin
    --instantiate full_adder
    h1 : full_adder port map(a, b, cin, result, cout);
    process
    begin
        --test 1
        a   <= '0';
        b   <= '0';
        cin <= '0';
        wait for 1 ns;
        assert (result = '0') report "Error 1 result" severity error;
        assert (cout   = '0') report "Error 1 carry out" severity error;

        --test 2
        a   <= '1';
        b   <= '0';
        cin <= '0';
        wait for 1 ns;
        assert (result = '1') report "Error 2 result" severity error;
        assert (cout   = '0') report "Error 2 carry out" severity error;

        --test 3
        a   <= '0';
        b   <= '1';
        cin <= '0';
        wait for 1 ns;
        assert (result = '1') report "Error 3 result" severity error;
        assert (cout   = '0') report "Error 3 carry out" severity error;

        --test 4
        a   <= '1';
        b   <= '1';
        cin <= '0';
        wait for 1 ns;
        assert (result = '0') report "Error 4 result" severity error;
        assert (cout   = '1') report "Error 4 carry out" severity error;

        --test 5
        a   <= '0';
        b   <= '0';
        cin <= '1';
        wait for 1 ns;
        assert (result = '1') report "Error 5 result" severity error;
        assert (cout   = '0') report "Error 5 carry out" severity error;

        --test 6
        a   <= '1';
        b   <= '0';
        cin <= '1';
        wait for 1 ns;
        assert (result = '1') report "Error 6 result" severity error;
        assert (cout   = '0') report "Error 6 carry out" severity error;

        --test 7
        a   <= '0';
        b   <= '1';
        cin <= '1';
        wait for 1 ns;
        assert (result = '1') report "Error 7 result" severity error;
        assert (cout   = '0') report "Error 7 carry out" severity error;

        --test 8
        a   <= '1';
        b   <= '1';
        cin <= '1';
        wait for 1 ns;
        assert (result = '0') report "Error 8 result" severity error;
        assert (cout   = '1') report "Error 8 carry out" severity error;
        wait;
    end process;
end tb;
