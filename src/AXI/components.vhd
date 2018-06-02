library AXI, ETHERNET, IEEE, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package components is

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

end components;

package body components is
end components;