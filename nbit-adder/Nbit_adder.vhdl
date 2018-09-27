library ieee;
use ieee.std_logic_1164.all;

entity NBit_adder is
    generic(n : integer:= 16);
    port (
            A    : in std_logic_vector(n-1 downto 0);
            B    : in std_logic_vector(n-1 downto 0);
            Res  : out std_logic_vector(n-1 downto 0);
            Cin  : in std_logic;
            Cout : out std_logic
         );
end NBit_adder;

architecture rtl of NBit_adder is
    --Full Adder
    component full_adder
        port (
                A    : in std_logic;
                B    : in std_logic;
                Cin  : in std_logic;
                Cout : out std_logic;
                Res  : out std_logic
             );
    end component;

    signal carry : std_logic_vector(n downto 0);
    begin
    --External carry input
    carry(0) <= Cin;
    --Generate cascade full adders
    FA_Cascade : for i in 0 to n-1 generate 
        --Map IO
        Inst_FA_Cascade : full_adder port map(
                            A    => A(i),
                            B    => B(i),
                            Res  => Res(i),
                            Cin  => carry(i),
                            Cout => carry(i+1) --connect cout to cin of next full adder
                                     );

    end generate FA_Cascade;
    Cout <= carry(n);
end rtl;
