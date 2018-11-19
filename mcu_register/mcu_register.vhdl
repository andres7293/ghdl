library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mcu_register is
    port (
                reset        : in std_logic;
                write_enable : in std_logic;
                clock        : in std_logic;
                input        : in std_logic_vector(7 downto 0);
                output       : out std_logic_vector(7 downto 0)
         );
end entity;

architecture rtl of mcu_register is
    signal D : std_logic_vector(7 downto 0);
    signal Q : std_logic_vector(7 downto 0);

begin
    process(clock, reset)
    begin
        if (reset'event and (reset = '1')) then
            Q <= "00000000";
        end if;
        if (clock'event and (clock = '1')) then
            Q <= D;
        end if;
    end process;

    D <= input when (write_enable = '1') else
          Q;
    output <= Q;
end architecture;
