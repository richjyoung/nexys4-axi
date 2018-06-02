--------------------------------------------------------------------------------
-- xil_defaultlib/top_level(struct) - Architecture
--------------------------------------------------------------------------------
library AXI, ETHERNET, IEEE, UNISIM, xil_defaultlib;
use AXI.axi_types.all;
use AXI.components.all;
use ETHERNET.ethernet_types.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use UNISIM.VCOMPONENTS.all;
use xil_defaultlib.components.all;
--------------------------------------------------------------------------------
architecture struct of top_level is

    signal CLK                  : std_logic;
    signal CLK_ETH              : std_logic;
    signal CLK_ETH_EXT          : std_logic;
    signal nRESET               : std_logic;

    -- RMII Converter/PHY Interface Signals
    signal RMII_PHY             : T_ETH_RMII_MAC_PHY;
    signal PHY_RMII             : T_ETH_RMII_PHY_MAC;

    -- JTAG to Ethernet
    signal JTAG_ETH            : T_AXI4_MASTER_SLAVE_32x32;
    signal ETH_JTAG            : T_AXI4_SLAVE_MASTER_32x32;

begin

    JTAG_ETH.AWREGION          <= (others => '0');
    JTAG_ETH.ARREGION          <= (others => '0');

    ETH_PHY_TXD                 <= RMII_PHY.TXD;
    ETH_PHY_TXEN                <= RMII_PHY.TX_EN;
    PHY_RMII.CRS_DV             <= ETH_PHY_CRSDV;
    PHY_RMII.RXD                <= ETH_PHY_RXD;
    PHY_RMII.RX_ER              <= ETH_PHY_RXERR;

    U_CLK : clk_100_50_50p45
    port map ( 
        -- Clock out ports  
        clk_sys                 => CLK,
        clk_eth                 => CLK_ETH,
        clk_eth_ext             => ETH_PHY_CLK,
        -- Status and control signals                
        resetn                  => CPU_RESET,
        locked                  => nRESET,
        -- Clock in ports
        clk_in1                 => CLK100MHZ
    );

    U_JTAG : jtag_axi_m
    port map (
        aclk                    => CLK,
        aresetn                 => nRESET,
        
        -- AXI Master In
        m_axi_awready           => ETH_JTAG.AWREADY,
        m_axi_wready            => ETH_JTAG.WREADY,
        m_axi_bid               => "0",
        m_axi_bresp             => ETH_JTAG.BRESP,
        m_axi_bvalid            => ETH_JTAG.BVALID,
        m_axi_arready           => ETH_JTAG.ARREADY,
        m_axi_rid               => "0",
        m_axi_rdata             => ETH_JTAG.RDATA,
        m_axi_rresp             => ETH_JTAG.RRESP,
        m_axi_rlast             => ETH_JTAG.RLAST,
        m_axi_rvalid            => ETH_JTAG.RVALID,
        -- AXI Master Out
        m_axi_awid              => open,
        m_axi_awaddr            => JTAG_ETH.AWADDR,
        m_axi_awlen             => JTAG_ETH.AWLEN,
        m_axi_awsize            => JTAG_ETH.AWSIZE,
        m_axi_awburst           => JTAG_ETH.AWBURST,
        m_axi_awlock            => JTAG_ETH.AWLOCK,
        m_axi_awcache           => JTAG_ETH.AWCACHE,
        m_axi_awprot            => JTAG_ETH.AWPROT,
        m_axi_awqos             => JTAG_ETH.AWQOS,
        m_axi_awvalid           => JTAG_ETH.AWVALID,
        m_axi_wdata             => JTAG_ETH.WDATA,
        m_axi_wstrb             => JTAG_ETH.WSTRB,
        m_axi_wlast             => JTAG_ETH.WLAST,
        m_axi_wvalid            => JTAG_ETH.WVALID,
        m_axi_bready            => JTAG_ETH.BREADY,
        m_axi_arid              => open,
        m_axi_araddr            => JTAG_ETH.ARADDR,
        m_axi_arlen             => JTAG_ETH.ARLEN,
        m_axi_arsize            => JTAG_ETH.ARSIZE,
        m_axi_arburst           => JTAG_ETH.ARBURST,
        m_axi_arlock            => JTAG_ETH.ARLOCK,
        m_axi_arcache           => JTAG_ETH.ARCACHE,
        m_axi_arprot            => JTAG_ETH.ARPROT,
        m_axi_arqos             => JTAG_ETH.ARQOS,
        m_axi_arvalid           => JTAG_ETH.ARVALID,
        m_axi_rready            => JTAG_ETH.RREADY
    );

    U_ETH: axi_ethernet_rmii
    port map (
        CLK                     => CLK,
        nRESET                  => nRESET,
        CLK_ETH                 => CLK_ETH,
        ETH_PHY_nRESET          => ETH_PHY_nRESET,
        ETH_MAC_IRQ             => open,
        RMII_IN                 => PHY_RMII,
        RMII_OUT                => RMII_PHY,
        MDIO                    => ETH_PHY_MDIO,
        MDC                     => ETH_PHY_MDC,
        S_AXI_IN                => JTAG_ETH,
        S_AXI_OUT               => ETH_JTAG
    );
end struct;
--------------------------------------------------------------------------------
