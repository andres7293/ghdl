library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tb is
end entity;

architecture tb of uart_tb is
--declarate component to use
    component uart 
    port (
             newData : in std_logic;
             reset   : in std_logic;
             clock   : in std_logic;
             baud    : in std_logic_vector(32-1 downto 0);
             data    : in std_logic_vector(8-1 downto 0);
             isBusy  : out std_logic;
             Tx      : out std_logic
         );
    end component;

    --signal
    signal newData : std_logic;
    signal reset   : std_logic;
    signal clock   : std_logic;
    signal baud    : std_logic_vector(32-1 downto 0);
    signal data    : std_logic_vector(8-1 downto 0);
    signal isBusy  : std_logic;
    signal Tx      : std_logic;

begin
    --instantiate unit under test
    uut : uart port map(
                newData => newData,
                reset   => reset,
                clock   => clock,
                baud    => baud,
                data    => data,
                isBusy  => isBusy,
                Tx      => Tx
                       );
    process
        begin

            --clock cycles
            for i in 0 to 10 loop
                wait for 1 ns;
                clock <= '0';
                wait for 1 ns;
                clock <= '1';
            end loop;

            --reset 
            reset <= '1';
            --clock cycles
            for i in 0 to 3 loop
                wait for 1 ns;
                clock <= '0';
                wait for 1 ns;
                clock <= '1';
            end loop;
            reset <= '0';
            for i in 0 to 3 loop
                wait for 1 ns;
                clock <= '0';
                wait for 1 ns;
                clock <= '1';
            end loop;

            --load baud and data
            baud <= std_logic_vector(to_unsigned(56160, 32));
            data <= "11111111";
            newData <= '1';

            --clock cycles
            for i in 0 to 60 loop
                wait for 1 ns;
                clock <= '0';
                wait for 1 ns;
                clock <= '1';
            end loop;

            newData <= '0';

            wait;
    end process;
end architecture;
