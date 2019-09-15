library IEEE;
use IEEE.std_logic_1164.all;

entity leds_shifter_tb is
end leds_shifter_tb;

architecture testbench of leds_shifter_tb is
    component leds_shifter
        port (
                 Clk: in std_logic;
                 Reset: in std_logic;
                 Leds: out std_logic_vector(2 downto 0)
             ); 
    end component;

    signal clk: std_logic;
    signal reset: std_logic;
    signal leds: std_logic_vector(2 downto 0);

begin
    --instantiate unit under test
    uut:    leds_shifter port map(
            Clk => clk,
            Reset => reset,
            Leds => leds);
    process
    begin
        --Reset signal
        for i in 0 to 20 loop
            reset <= '1';
            clk <= '0';
            wait for 1 ns;
            clk <= '1';
            wait for 1 ns;
        end loop;

        reset <= '0';

        for i in 0 to 50000 loop
            clk <= '0';
            wait for 1 ns;
            clk <= '1';
            wait for 1 ns;
        end loop;

        wait;
    end process;
end testbench;
