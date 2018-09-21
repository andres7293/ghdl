library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
            A      : in std_logic;
            B      : in std_logic;
            Cin    : in std_logic;
            Result : out std_logic;
            Cout   : out std_logic
         );
end full_adder;

architecture rtl of full_adder is
begin
    --Result logic function
    Result <= (A xor B) xor Cin;
    --Carry out logic function
    Cout   <= (B and Cin) or (A and Cin) or (A and B);
end rtl;               
