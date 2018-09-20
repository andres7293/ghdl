library ieee;
use ieee.std_logic_1164.all;

entity and_gate is					
   port( 
            A, B : in std_logic;
            F : out std_logic);
end and_gate;

architecture func of and_gate is 
begin
  F <= A and B;		
end func;
