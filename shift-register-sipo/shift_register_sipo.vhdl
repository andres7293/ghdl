library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Clocked Shift register LSB first with:
-- * low active reset, rising edge
-- * low active enable, rising edge

entity shift_register_sipo is
        generic (n : integer := 8);
        port (
                    reset        : in  std_logic;
                    enable       : in  std_logic;
                    clock        : in  std_logic;
                    serial_in    : in  std_logic;
                    parallel_out : out std_logic_vector(n-1 downto 0)
             );
end entity;


architecture Behavioural of shift_register_sipo is

    signal D : std_logic_vector(n-1 downto 0);
    signal Q : std_logic_vector(n-1 downto 0);

begin

    process (clock)
    begin
        if (clock'event and (clock = '1')) then
            Q <= D;
        end if;
    end process;

    D <= Q(n-2 downto 0) & serial_in when (enable = '0') else
         std_logic_vector(to_signed(0, n)) when (reset = '0') else
         Q;

    parallel_out <= Q;

end architecture;
