library ieee;
use ieee.std_logic_1164.all;

entity or_gate is					
   port( 
            A, B : in std_logic;
            F : out std_logic);
end or_gate;

architecture func of or_gate is 
begin
  F <= A or B;		
end func;
