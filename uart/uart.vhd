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

    signal D_counterBaud : std_logic_vector(32-1 downto 0);
    signal Q_counterBaud : std_logic_vector(32-1 downto 0);
    signal D_Tx          : std_logic;
    signal Q_Tx          : std_logic;
    signal D_dataReg     : std_logic_vector(10-1 downto 0);
    signal Q_dataReg     : std_logic_vector(10-1 downto 0);
    signal bit_time      : std_logic;
    signal Q_bitCounter  : std_logic_vector(4-1 downto 0);
    signal D_bitCounter  : std_logic_vector(4-1 downto 0);

    --mux signals
    signal baud_gen_mux    : std_logic;
    signal data_mux        : std_logic_vector(2-1  downto 0);
    signal output_bit_mux  : std_logic;
    signal bit_counter_mux : std_logic;
begin

    process (clock, reset)
    begin
        if (reset = '1') then
            Q_counterBaud   <= std_logic_vector(to_unsigned(0, 32));
            Q_dataReg       <= std_logic_vector(to_unsigned(0, 10));
            Q_Tx            <= '1';
            Q_ControlStates <= std_logic_vector(to_unsigned(0, 3));
            Q_bitCounter    <= std_logic_vector(to_unsigned(10, 4));
        end if;
        if (clock'event and (clock = '1') and (reset = '0')) then
            Q_counterBaud   <= D_counterBaud;
            Q_dataReg       <= D_dataReg;
            Q_Tx            <= D_Tx;
            Q_ControlStates <= D_ControlStates;
            Q_bitCounter    <= D_bitCounter;
        end if;
    end process;

    --Output logic
    process (Q_ControlStates)
    begin
        if (Q_ControlStates = "000") then
            --idle
           baud_gen_mux <= '0';
           data_mux <= "11";
           output_bit_mux <= '0';
           bit_counter_mux <= '0';
        end if;
        if (Q_ControlStates = "001") then
            --load registers
            baud_gen_mux <= '1';
            data_mux <= "10";
            output_bit_mux <= '0';
        end if;
        if (Q_ControlStates <= "011") then
            --load next bit
            baud_gen_mux <= '1';
        end if;
        if (Q_ControlStates <= "100") then
            --send bit
            output_bit_mux <= '1';
        end if;
        if (Q_ControlStates <= "111") then
            --Reload baud register
            bit_counter_mux <= '0';
            baud_gen_mux <= '0';
        end if;
    end process;

    --Next state logic
    D_ControlStates <= "001" when ((Q_ControlStates = "000") and (newData = '1')) else 
                       "011" when (Q_ControlStates = "001") else
                       "100" when (Q_ControlStates = "011") else
                       "111" when ((Q_ControlStates = "100") and (bit_time = '1')) else
                       "011" when (Q_ControlStates = "111") else
                       "000" when ((Q_ControlStates = "111") and (bit_time = '0'));

    --baud counter
    D_counterBaud <= baud when (baud_gen_mux = '0') else
                     std_logic_vector(unsigned(Q_counterBaud) - 1);
    bit_time <=  not (Q_counterBaud(32-1) and '1');

    --data register
    D_dataReg <= '1' & data & '0' when (data_mux = "10") else
                 Q_dataReg(8 downto 0) & '0' when (data_mux = "00") else
                 Q_dataReg;

    --bit counter
    D_bitCounter <= Q_bitCounter when (bit_counter_mux = '0') else
                   std_logic_vector(unsigned(Q_bitCounter) - 1);

    --output biestable
    D_Tx <= Q_dataReg(0) when (output_bit_mux = '1') else
          '1';
    --output bit
    Tx <= Q_Tx;

end architecture;
