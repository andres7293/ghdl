library ieee;
use ieee.std_logic_1164.all;

entity or_gate_tb is
end or_gate_tb;

architecture tb of or_gate_tb is
   component or_gate is 
   port( 
            A, B : in std_logic;
            F : out std_logic
       );
   end component;
    
   signal  a_input, b_input, f_output : std_logic;
begin 
   --instantiate or_gate
   u1 : or_gate port map(a_input, b_input, f_output);

   process
   begin
      --TEST 1
      a_input <= '0';
      b_input <= '0';
      wait for 15 ns;
      assert(f_output = '0')  report "Error 1"  severity error;

      --TEST 2
      a_input <= '0';
      b_input <= '1';
      wait for 15 ns;
      assert(f_output = '0')  report "Error 2"  severity error;

      --TEST 3
      a_input <= '1';
      b_input <= '0';
      wait for 15 ns;
      assert(f_output = '0')  report "Error 3"  severity error;
      wait for 15 ns;

      --TEST 4
      a_input <= '1';
      b_input <= '1';
      wait for 15 ns;
      assert(f_output = '1')  report "Error 4"  severity error;
      wait;

   end process;
end tb;
