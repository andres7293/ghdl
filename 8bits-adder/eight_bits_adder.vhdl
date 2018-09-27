library ieee;
use ieee.std_logic_1164.all;

entity eight_bits_adder is
    port (
            A    : in std_logic_vector(7 downto 0);
            B    : in std_logic_vector(7 downto 0);
            Res  : out std_logic_vector(7 downto 0);
            Cin  : in std_logic;
            Cout : out std_logic
         );
end eight_bits_adder;

architecture rtl of eight_bits_adder is
    --Full adder component
    component full_adder
        port (
                A    : in std_logic;
                B    : in std_logic;
                Cin  : in std_logic;
                Res  : out std_logic;
                Cout : out std_logic
             );
    end component;
    signal carry : std_logic_vector(8 downto 0);
begin
    --Get external carry input 
    carry(0) <= Cin;
    --Instantiate array of full adder
    full_adder_array : for i in 0 to 7 generate
        --Map signals
        inst_full_adder : full_adder port map (
            A    => A(i),
            B    => B(i),
            Res  => Res(i),
            Cin  => carry(i),
            Cout => carry(i+1)
        );
    end generate full_adder_array;
    --Map last carry bit, with Cout entity signal
    Cout <= carry(6);
end rtl;
