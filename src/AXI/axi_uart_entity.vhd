library AXI, ETHERNET, IEEE, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--------------------------------------------------------------------------------
entity axi_uart is
    port (
        -- Clock & Reset
        CLK                 : in  std_logic;
        nRESET              : in  std_logic;
        -- UART Interrupt
        UART_IRQ            : out std_logic;
        -- Management Interface
        UART_RX             : in  std_logic;
        UART_TX             : out std_logic;
        -- AXI Slave Interface
        S_AXI_IN            : in  T_AXI4_MASTER_SLAVE_32x32;
        S_AXI_OUT           : out T_AXI4_SLAVE_MASTER_32x32
    );
end axi_uart;