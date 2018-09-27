library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bits_adder_tb is
end eight_bits_adder_tb;

architecture tb of eight_bits_adder_tb is
    component eight_bits_adder is
        port (
                A    : in std_logic_vector(7 downto 0);
                B    : in std_logic_vector(7 downto 0);
                Res  : out std_logic_vector(7 downto 0);
                Cin  : in std_logic;
                Cout : out std_logic
             );
   end component;

   signal A    : std_logic_vector(7 downto 0);
   signal B    : std_logic_vector(7 downto 0);
   signal Res  : std_logic_vector(7 downto 0);
   signal Cin  : std_logic;
   signal Cout : std_logic;

   begin
       --instantiate the unit under test 
       uut : eight_bits_adder port map (
            A => A,
            B => B,
            Res => Res,
            Cin => Cin,
            Cout => Cout
        );

       process 
           begin
				for i in 0 to 255 loop
                    for j in 0 to 255 loop
                        A <= std_logic_vector(to_unsigned(i, 8));
                        B <= std_logic_vector(to_unsigned(j, 8));
                        wait for 1 ns;
                    end loop;
                end loop;

				for i in 0 to 255 loop
                    for j in 0 to 255 loop
                        A <= std_logic_vector(to_unsigned(i, 8));
                        B <= std_logic_vector(to_unsigned(j, 8));
                        Cin <= '1';
                        wait for 1 ns;
                    end loop;
                end loop;

                wait;
       end process;
end tb;
