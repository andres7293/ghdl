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
    type TxLogicStates is (idle, load_registers, send_bit, reload_baudrate);
    signal D_TxState, Q_TxState : TxLogicStates;

    signal D_counterBus : std_logic_vector(32-1 downto 0);
    signal Q_counterBus : std_logic_vector(32-1 downto 0);
    signal D_Tx         : std_logic;
    signal Q_Tx         : std_logic;
    signal D_shiftReg   : std_logic_vector(8-1 downto 0);
    signal Q_shiftReg   : std_logic_vector(8-1 downto 0);
    signal bit_time     : std_logic;

    --mux signals
    signal baud_gen_mux     : std_logic;
    signal uart_data_mux    : std_logic_vector(2 downto 0);
    signal uart_output_mux  : std_logic_vector(2 downto 0);
begin

    process (clock)
    begin
        if (clock'event and (clock = '1')) then
            Q_counterBus <= D_counterBus;
            Q_shiftReg   <= D_shiftReg;
            Q_Tx         <= D_Tx;
            Q_TxState    <= D_TxState;
        end if;
    end process;

    --control baud rate generator
    D_counterBus <= baud when (baud_gen_mux = '1') else
             std_logic_vector(unsigned(Q_counterBus) - 1);

    --control load data into shiftRegister
    D_shiftReg <= data when (uart_data_mux = "10") else
                  Q_shiftReg when (uart_data_mux = "00");

    --control output biestable bit
    D_Tx <= '1' when (uart_data_mux = "11") else
            Q_Tx when (uart_data_mux = "10");

    --output bit
    Tx <= Q_Tx;

end architecture;
