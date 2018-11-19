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

    signal D_cnt      : std_logic_vector(32-1 downto 0);
    signal Q_cnt      : std_logic_vector(32-1 downto 0);
    signal D_Tx       : std_logic;
    signal Q_Tx       : std_logic;
    signal D_shiftReg : std_logic_vector(8-1 downto 0);
    signal Q_shiftReg : std_logic_vector(8-1 downto 0);
    signal bit_time   : std_logic;
begin

    process (clock)
    begin
        if (clock'event and (clock = '1')) then
            Q_cnt      <= D_cnt;
            Q_shiftReg <= D_shiftReg;
            Q_Tx       <= D_Tx;
            Q_TxState  <= D_TxState;
        end if;
    end process;

end architecture;
