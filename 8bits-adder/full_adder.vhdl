library ieee;
use ieee.std_logic_1164.all;

--Declare input, output ports
entity full_adder is 
    port (
            A    : in std_logic;
            B    : in std_logic;
            Cin  : in std_logic;
            Res  : out std_logic;
            Cout : out std_logic
         );
end full_adder;

--Describe logic
architecture rtl of full_adder is
begin
    Res <= (A xor B) xor Cin;
    Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B) ;
end rtl;
