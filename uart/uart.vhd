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
    --type TxLogicStates is (idle, load_registers, send_bit, reload_baudrate);
    --signal D_TxState, Q_TxState : TxLogicStates;

    signal D_counterBus : std_logic_vector(32-1 downto 0);
    signal Q_counterBus : std_logic_vector(32-1 downto 0);
    signal D_Tx         : std_logic;
    signal Q_Tx         : std_logic;
    signal D_shiftReg   : std_logic_vector(8-1 downto 0);
    signal Q_shiftReg   : std_logic_vector(8-1 downto 0);
    signal bit_time     : std_logic;
    signal Q_bitCounter : std_logic_vector(4-1 downto 0);
    signal D_bitCounter : std_logic_vector(4-1 downto 0);

    --mux signals
    signal baud_gen_mux     : std_logic;
    signal uart_data_mux    : std_logic_vector(2-1  downto 0);
    signal uart_output_mux  : std_logic_vector(2-1  downto 0);
    signal bit_counter_mux  : std_logic;
begin

    process (clock, reset)
    begin
        if (reset'event and (reset = '1')) then
            Q_counterBus    <= std_logic_vector(to_unsigned(0, 32));
            Q_shiftReg      <= std_logic_vector(to_unsigned(0, 8));
            Q_Tx            <= '1';
            Q_ControlStates <= std_logic_vector(to_unsigned(0, 3));
            Q_bitCounter    <= std_logic_vector(to_unsigned(10, 4));
        end if;
        if (clock'event and (clock = '1')) then
            Q_counterBus <= D_counterBus;
            Q_shiftReg   <= D_shiftReg;
            Q_Tx         <= D_Tx;
            Q_ControlStates <= D_ControlStates;
            Q_bitCounter    <= D_bitCounter;
        end if;
    end process;

    --Next state logic
    process (Q_ControlStates, bit_time, newData, Q_bitCounter, clock)
    begin
        if (clock'event and (clock = '1')) then
            if (Q_ControlStates = "000" and newData = '1') then
                D_ControlStates <= "001";
            end if;

            if (Q_ControlStates = "001") then
                D_ControlStates <= "011";
            end if;

            if (Q_ControlStates = "011") then
                D_ControlStates <= "100";
            end if;

            if (Q_ControlStates = "100") then
                D_ControlStates <= "111";
            end if;

            if (Q_ControlStates = "111" and Q_bitCounter = "00") then
                D_ControlStates <= "000";
            end if;
        end if;
    end process;

    --Output logic
    process (Q_ControlStates, clock)
    begin
        if (clock'event and (clock = '1')) then
            if (Q_ControlStates = "000") then
                baud_gen_mux    <= '1';
                uart_data_mux   <= "00";
                uart_output_mux <= "10";
            end if;
            if (Q_ControlStates = "001") then
                baud_gen_mux <= '0';
                uart_data_mux <= "10";
                uart_output_mux <= "10";
            end if;
            if (Q_ControlStates = "011") then
                --load next bit into output biestable
                baud_gen_mux <= '0';
            end if;
            if (Q_ControlStates = "100") then
                --send bit
            end if;
        end if;
    end process;

    --control baud rate generator
    D_counterBus <= baud when (baud_gen_mux = '1') else
             std_logic_vector(unsigned(Q_counterBus) - 1);
    bit_time <= '1' when (Q_counterBus = "00000000000000000000000000000")
                else '0';

    --control load data into shiftRegister
    D_shiftReg <= data when (uart_data_mux = "10") else
                  Q_shiftReg when (uart_data_mux = "00");

    --control output biestable bit
    D_Tx <= '1' when (uart_output_mux = "10");
            --get next bit ??

    --Decrement bit
    D_bitCounter <= Q_bitCounter when (bit_counter_mux = '0') else
                    std_logic_vector(unsigned(Q_bitCounter) - 1);

    --output bit
    Tx <= Q_Tx;

end architecture;
