library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mcu_register_tb is
end entity;

architecture tb of mcu_register_tb is
    component mcu_register
        port (
                    reset        : in std_logic;
                    write_enable : in std_logic;
                    clock        : in std_logic;
                    input        : in std_logic_vector(7 downto 0);
                    output       : out std_logic_vector(7 downto 0)
             );
    end component;
    
    signal reset        : std_logic;
    signal write_enable : std_logic;
    signal clock        : std_logic;
    signal input        : std_logic_vector(7 downto 0);
    signal output       : std_logic_vector(7 downto 0);
begin
        uut : mcu_register port map(
                            reset        => reset,
                            write_enable => write_enable,
                            clock        => clock,
                            input        => input,
                            output       => output
                                 );
    process
        begin
            
            --clock cycles
            clock <= '0';
            wait for 1 ns;
            clock <= '1';
            wait for 1 ns;

            --reset
            reset <= '1';
            clock <= '0';
            wait for 1 ns;
            clock <= '1';
            wait for 1 ns;

            --store data
            write_enable <= '1';
            clock <= '0';
            input <= "11111111";
            wait for 1 ns;
            clock <= '1';
            wait for 1 ns;
            write_enable <= '0';
            clock <= '0';
            wait for 1 ns;
            clock <= '1';
            wait for 1 ns;

            --clock cycles and try to store data without enable write
            for i in 0 to 7 loop
                clock <= '0';
                input <= "11001010";
                wait for 1 ns;
                clock <= '1';
                wait for 1 ns;
            end loop;

            wait;
    end process;
end architecture;

