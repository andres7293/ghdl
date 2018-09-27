library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NBit_adder_tb is
end NBit_adder_tb;

architecture tb of NBit_adder_tb is
    --Full Adder
    component NBit_adder
    port (
            A    : in std_logic_vector(16-1 downto 0);
            B    : in std_logic_vector(16-1 downto 0);
            Res  : out std_logic_vector(16-1 downto 0);
            Cin  : in std_logic;
            Cout : out std_logic
         );
    end component;

   signal A    : std_logic_vector(16-1 downto 0);
   signal B    : std_logic_vector(16-1 downto 0);
   signal Res  : std_logic_vector(16-1 downto 0);
   signal Cin  : std_logic;
   signal Cout : std_logic;

    begin
        --Instantiate the unit under test
        uut : NBit_adder port map(
                        A => A,
                        B => B,
                        Res => Res,
                        Cin => Cin,
                        Cout => Cout
                                 );
        process
		begin

		  for i in 0 to 65535 loop
			  for j in 0 to 65535 loop
				   A <= std_logic_vector(to_unsigned(i, 16));
				   B <= std_logic_vector(to_unsigned(j, 16));
                   Cin <= '0';
				   wait for 100 ns;    
			   end loop;
		 end loop;

		  for i in 0 to 65535 loop
			  for j in 0 to 65535 loop
				   A <= std_logic_vector(to_unsigned(i, 16));
				   B <= std_logic_vector(to_unsigned(j, 16));
                   Cin <= '1';
				   wait for 100 ns;    
			   end loop;
		 end loop;
			  wait;
        end process;
end tb;
