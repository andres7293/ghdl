library ieee;
use ieee.std_logic_1164.all;

entity shift_register_sipo_tb is
end shift_register_sipo_tb;


architecture tb of shift_register_sipo_tb is

    component shift_register_sipo
        port (
                    clock        : in  std_logic;
                    serial_in    : in  std_logic;
                    parallel_out : out std_logic_vector(7 downto 0)
             );
    end component;

    signal clock        : std_logic;
    signal serial_in    : std_logic;
    signal parallel_out : std_logic_vector(7 downto 0);

    begin
        --Instantiate the unit under test
        uut : shift_register_sipo port map(
                        clock        => clock,
                        serial_in    => serial_in,
                        parallel_out => parallel_out
                                 );

      process
      begin
          --falling edge
          clock <= '0';
          serial_in <= '0';
          wait for 1 ns;
          --rising edge
          clock <= '1';
          serial_in <= '1';
          wait for 1 ns;

          --falling edge
          clock <= '0';
          serial_in <= '0';
          wait for 1 ns;
          --rising edge
          clock <= '1';
          serial_in <= '1';
          wait for 1 ns;

          wait;
      end process;

end tb;
