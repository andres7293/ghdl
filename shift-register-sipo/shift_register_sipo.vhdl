library ieee;
use ieee.std_logic_1164.all;

entity shift_register_sipo is
        port (
                    clock        : in  std_logic;
                    serial_in    : in  std_logic;
                    parallel_out : out std_logic_vector(7 downto 0)
             );
end shift_register_sipo;


architecture Behavioural of shift_register_sipo is

    signal Q : std_logic_vector(7 downto 0) := "00000000";

begin

    process (clock)
    begin
        if rising_edge(clock) then
            Q(7) <= serial_in;
            Q(6 downto 0) <= Q(7 downto 1);
        end if;
    end process;

    parallel_out(7 downto 0) <= Q(7 downto 0);

end Behavioural;
