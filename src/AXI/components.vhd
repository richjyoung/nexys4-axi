library AXI, ETHERNET, IEEE, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package components is

    component axi_crossbar is
        port (
            -- Clock & Reset
            CLK                 : in  std_logic;
            nRESET              : in  std_logic;
            -- AXI Slave Interface
            S_AXI_IN            : in  T_AXI4_MASTER_SLAVE_32x32_ARRAY(0 downto 0);
            S_AXI_OUT           : out T_AXI4_SLAVE_MASTER_32x32_ARRAY(0 downto 0);
            -- AXI Master Interfaces
            M_AXI_IN            : in  T_AXI4_SLAVE_MASTER_32x32_ARRAY(1 downto 0);
            M_AXI_OUT           : out T_AXI4_MASTER_SLAVE_32x32_ARRAY(1 downto 0)
        );
    end component axi_crossbar;


    component axi_ethernet_rmii is
        port (
            -- Clock & Reset
            CLK                 : in    std_logic;
            nRESET              : in    std_logic;
            -- PHY Clock & Reset
            CLK_ETH             : in    std_logic;
            ETH_PHY_nRESET      : out   std_logic;
            -- MAC Interrupt
            ETH_MAC_IRQ         : out   std_logic;
            -- RMII Interface
            RMII_IN             : in    T_ETH_RMII_PHY_MAC;
            RMII_OUT            : out   T_ETH_RMII_MAC_PHY;
            -- Management Interface
            MDIO                : inout std_logic;
            MDC                 : out   std_logic;
            -- AXI Slave Interface
            S_AXI_IN            : in    T_AXI4_MASTER_SLAVE_32x32;
            S_AXI_OUT           : out   T_AXI4_SLAVE_MASTER_32x32
        );
    end component axi_ethernet_rmii;

    component axi_uart is
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
    end component axi_uart;

    component axi_cdma is
        port (
            -- Clock & Reset
            CLK                 : in  std_logic;
            nRESET              : in  std_logic;
            -- Interrupt
            CDMA_IRQ            : out std_logic;
            -- AXI Master Interface
            M_AXI_IN            : in  T_AXI4_SLAVE_MASTER_32x32;
            M_AXI_OUT           : out T_AXI4_MASTER_SLAVE_32x32;
            -- AXI Slave Interface
            S_AXI_IN            : in  T_AXI4_MASTER_SLAVE_32x32;
            S_AXI_OUT           : out T_AXI4_SLAVE_MASTER_32x32;
            -- CDMA
            CDMA_TVECT          : out std_logic_vector(31 downto 0)
        );
    end component axi_cdma;

    component axi_jtag is
        port (
            -- Clock & Reset
            CLK                 : in  std_logic;
            nRESET              : in  std_logic;
            -- AXI Master Interface
            M_AXI_IN            : in  T_AXI4_SLAVE_MASTER_32x32;
            M_AXI_OUT           : out T_AXI4_MASTER_SLAVE_32x32
        );
    end component axi_jtag;

end components;

package body components is
end components;