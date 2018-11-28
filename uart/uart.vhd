library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart is 
    port (
             newData : in std_logic;
             reset   : in std_logic;
             clock   : in std_logic;
             baud    : in std_logic_vector(32-1 downto 0);
             data    : in std_logic_vector(8-1 downto 0);
             isBusy  : out std_logic;
             Tx      : out std_logic
         );
end entity;

architecture rtl of uart is
    --Transmission control logic states
    signal Q_ControlStates : std_logic_vector(3-1 downto 0);
    signal D_ControlStates : std_logic_vector(3-1 downto 0);

    signal D_baudBus    : std_logic_vector(32-1 downto 0);
    signal Q_baudBus    : std_logic_vector(32-1 downto 0);
    signal D_Tx         : std_logic;
    signal Q_Tx         : std_logic;
    signal D_data       : std_logic_vector(10-1 downto 0);
    signal Q_data       : std_logic_vector(10-1 downto 0);
    signal bit_time     : std_logic;
    signal bit_counter  : std_logic;
    signal Q_bitCounter : std_logic_vector(4-1 downto 0);
    signal D_bitCounter : std_logic_vector(4-1 downto 0);

    --mux signals
    signal baudmux       : std_logic_vector(2-1  downto 0);
    signal datamux       : std_logic_vector(2-1  downto 0);
    signal bitCountermux : std_logic_vector(2-1  downto 0);
    signal outputmux     : std_logic;
begin

    process(clock)
    begin
        if (clock'event and (clock = '1')) then
            Q_ControlStates <= D_ControlStates;
        end if;
    end process;

    process(clock)
    begin
        if (clock'event and (clock = '1')) then
            Q_baudBus <= D_baudBus;
        end if;
    end process;

    process(clock)
    begin
        if (clock'event and (clock = '1')) then
            Q_data <= D_data;
        end if;
    end process;

    process(clock)
    begin
        if (clock'event and (clock = '1')) then
            Q_Tx <= D_Tx;
        end if;
    end process;

    process(clock)
    begin
        if (clock'event and (clock = '1')) then
            Q_bitCounter <= D_bitCounter;
        end if;
    end process;

    --next state logic
    D_ControlStates <= "000" when (reset = '0') else
                       "001" when (newData = '1') else
                       "010" when (Q_ControlStates = "001") else
                       "011" when (Q_ControlStates = "010") else
                       "111" when ((Q_ControlStates = "011") and (bit_time = '1')) else
                       "010" when (Q_ControlStates = "111") else
                       "000" when (bit_counter = '0') else
                       Q_ControlStates;


    --output logic
    baudmux <= "00" when (Q_ControlStates = "000" or Q_ControlStates = "010") else
               "10" when (Q_ControlStates = "001" or Q_ControlStates = "111") else
               "11" when (Q_ControlStates = "011") else
               "00";

    bitCountermux <= "00" when (Q_ControlStates = "000" or Q_ControlStates = "001") else
                     "01" when (Q_ControlStates = "010" or Q_ControlStates = "011") else
                     "10" when (Q_ControlStates = "111") else 
                     "00";

    datamux <= "00" when (Q_ControlStates = "000" or Q_ControlStates = "011" or Q_ControlStates = "111") else
               "10" when (Q_ControlStates = "010") else
               "11" when (Q_ControlStates = "001") else
               "00";

    outputmux <= '0' when (Q_ControlStates = "011" or Q_ControlStates = "010" or Q_ControlStates = "111") else
              '1';

    --baud rate 
    D_baudBus <= Q_baudBus when (baudmux = "00") else
                 baud when (baudmux = "10") else
                 std_logic_vector(unsigned(Q_baudBus) - 1);
    bit_time <= '1' when (Q_baudBus = "00000000000000000000000000000000") else
                '0';

    --bitcounter
    D_bitCounter <= std_logic_vector(to_unsigned(9, 4)) when (bitCountermux = "00") else
                    Q_bitCounter when (bitCountermux = "01") else
                    std_logic_vector(unsigned(Q_bitCounter) - 1) when (bitCountermux = "10") else
                    Q_bitCounter;

    bit_counter <= '0' when (Q_bitCounter = "0000") else 
                   '1';

   --data register
    D_data <= Q_data when (datamux = "00") else
              Q_data(8 downto 0) & '0' when (datamux = "10") else
              '1' & data & '0' when (datamux = "11") else
              std_logic_vector(to_unsigned(0, 10));

    --output biestable
    D_Tx <= '1' when (outputmux = '1') else
            Q_data(10-1) when (outputmux = '0') else
            Q_data(10-1);

    --output bit
    Tx <= Q_Tx;

    isBusy <= '0' when (Q_ControlStates = "000") else
              '1';

end architecture;
