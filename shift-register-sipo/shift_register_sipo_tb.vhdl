library ieee;
use ieee.std_logic_1164.all;

entity shift_register_sipo_tb is
end shift_register_sipo_tb;


architecture tb of shift_register_sipo_tb is

    component shift_register_sipo
        generic (n : integer := 8);
        port (
                    reset        : in  std_logic;
                    enable       : in  std_logic;
                    clock        : in  std_logic;
                    serial_in    : in  std_logic;
                    parallel_out : out std_logic_vector(8-1 downto 0)
             );
    end component;

    signal reset        : std_logic;
    signal enable       : std_logic;
    signal clock        : std_logic;
    signal serial_in    : std_logic;
    signal parallel_out : std_logic_vector(8-1 downto 0);

    begin
        --Instantiate the unit under test
        uut : shift_register_sipo port map(
                        reset        => reset,
                        enable       => enable,
                        clock        => clock,
                        serial_in    => serial_in,
                        parallel_out => parallel_out
                                 );

      process
      begin

          --Reset biestable
          clock  <= '0';
          reset  <= '0';
          enable <= '1';
          wait for 1 ns;
          clock <= '1';
          reset  <= '1';
          wait for 1 ns;

          --shift bits to logic 1
          for i in 0 to 8-1 loop
              clock <= '0';
              enable <= '0';
              serial_in <= '1';
              wait for 1 ns;
              clock <= '1';
              wait for 1 ns;
          end loop;

          --shift bits to logic 0
          for i in 0 to 8-1 loop
              clock <= '0';
              enable <= '0';
              serial_in <= '0';
              wait for 1 ns;
              clock <= '1';
              wait for 1 ns;
          end loop;

          --shift bits to logic 1 with enable = 1
          for i in 0 to 8-1 loop
              clock <= '0';
              enable <= '1';
              serial_in <= '1';
              wait for 1 ns;
              clock <= '1';
              wait for 1 ns;
          end loop;

          wait;
      end process;

end tb;
