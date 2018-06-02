--------------------------------------------------------------------------------
-- xil_defaultlib/top_level(struct) - Architecture
--------------------------------------------------------------------------------
library AXI, IEEE, UNISIM, xil_defaultlib;
use AXI.axi_types.all;
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

    -- PHY MDIO Signals
    signal ETH_PHY_MDIO_I       : std_logic;
    signal ETH_PHY_MDIO_O       : std_logic;
    signal ETH_PHY_MDIO_T       : std_logic;

    -- MAC/RMII Converter Interface Signals
    signal RMII_MAC_COL         : std_logic;
    signal RMII_MAC_CRS         : std_logic;
    signal RMII_MAC_RX_DV       : std_logic;
    signal RMII_MAC_RX_CLK      : std_logic;
    signal RMII_MAC_RXD         : std_logic_vector(3 downto 0);
    signal RMII_MAC_RX_ER       : std_logic;
    signal RMII_MAC_TX_CLK      : std_logic;
    signal MAC_RMII_TXD         : std_logic_vector(3 downto 0);
    signal MAC_RMII_TX_EN       : std_logic;

    -- JTAG to AXI Converter
    signal JTAG_CONV            : T_AXI4_MASTER_SLAVE_32x32;
    signal CONV_JTAG            : T_AXI4_SLAVE_MASTER_32x32;

    -- AXI Converter to Ethernet MAC
    signal CONV_MAC             : T_AXI4LITE_MASTER_SLAVE_32x32;
    signal MAC_CONV             : T_AXI4LITE_SLAVE_MASTER_32x32;

begin

    JTAG_CONV.AWREGION          <= (others => '0');
    JTAG_CONV.ARREGION          <= (others => '0');

    U_MDIO : IOBUF
    port map (
        IO                      => ETH_PHY_MDIO,
        I                       => ETH_PHY_MDIO_I,
        O                       => ETH_PHY_MDIO_O,
        T                       => ETH_PHY_MDIO_T
    );

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
        m_axi_awready           => CONV_JTAG.AWREADY,
        m_axi_wready            => CONV_JTAG.WREADY,
        m_axi_bid               => "0",
        m_axi_bresp             => CONV_JTAG.BRESP,
        m_axi_bvalid            => CONV_JTAG.BVALID,
        m_axi_arready           => CONV_JTAG.ARREADY,
        m_axi_rid               => "0",
        m_axi_rdata             => CONV_JTAG.RDATA,
        m_axi_rresp             => CONV_JTAG.RRESP,
        m_axi_rlast             => CONV_JTAG.RLAST,
        m_axi_rvalid            => CONV_JTAG.RVALID,
        -- AXI Master Out
        m_axi_awid              => open,
        m_axi_awaddr            => JTAG_CONV.AWADDR,
        m_axi_awlen             => JTAG_CONV.AWLEN,
        m_axi_awsize            => JTAG_CONV.AWSIZE,
        m_axi_awburst           => JTAG_CONV.AWBURST,
        m_axi_awlock            => JTAG_CONV.AWLOCK,
        m_axi_awcache           => JTAG_CONV.AWCACHE,
        m_axi_awprot            => JTAG_CONV.AWPROT,
        m_axi_awqos             => JTAG_CONV.AWQOS,
        m_axi_awvalid           => JTAG_CONV.AWVALID,
        m_axi_wdata             => JTAG_CONV.WDATA,
        m_axi_wstrb             => JTAG_CONV.WSTRB,
        m_axi_wlast             => JTAG_CONV.WLAST,
        m_axi_wvalid            => JTAG_CONV.WVALID,
        m_axi_bready            => JTAG_CONV.BREADY,
        m_axi_arid              => open,
        m_axi_araddr            => JTAG_CONV.ARADDR,
        m_axi_arlen             => JTAG_CONV.ARLEN,
        m_axi_arsize            => JTAG_CONV.ARSIZE,
        m_axi_arburst           => JTAG_CONV.ARBURST,
        m_axi_arlock            => JTAG_CONV.ARLOCK,
        m_axi_arcache           => JTAG_CONV.ARCACHE,
        m_axi_arprot            => JTAG_CONV.ARPROT,
        m_axi_arqos             => JTAG_CONV.ARQOS,
        m_axi_arvalid           => JTAG_CONV.ARVALID,
        m_axi_rready            => JTAG_CONV.RREADY
    );

    U_CONV : axi_s_to_axilite_m_32x32_conv
    port map (
        aclk                    => CLK,
        aresetn                 => nRESET,

        -- Slave AXI In
        s_axi_awaddr            => JTAG_CONV.AWADDR,
        s_axi_awlen             => JTAG_CONV.AWLEN,
        s_axi_awsize            => JTAG_CONV.AWSIZE,
        s_axi_awburst           => JTAG_CONV.AWBURST,
        s_axi_awlock(0)         => JTAG_CONV.AWLOCK,
        s_axi_awcache           => JTAG_CONV.AWCACHE,
        s_axi_awprot            => JTAG_CONV.AWPROT,
        s_axi_awregion          => JTAG_CONV.AWREGION,
        s_axi_awqos             => JTAG_CONV.AWQOS,
        s_axi_awvalid           => JTAG_CONV.AWVALID,
        s_axi_wdata             => JTAG_CONV.WDATA,
        s_axi_wstrb             => JTAG_CONV.WSTRB,
        s_axi_wlast             => JTAG_CONV.WLAST,
        s_axi_wvalid            => JTAG_CONV.WVALID,
        s_axi_bready            => JTAG_CONV.BREADY,
        s_axi_araddr            => JTAG_CONV.ARADDR,
        s_axi_arlen             => JTAG_CONV.ARLEN,
        s_axi_arsize            => JTAG_CONV.ARSIZE,
        s_axi_arburst           => JTAG_CONV.ARBURST,
        s_axi_arlock(0)         => JTAG_CONV.ARLOCK,
        s_axi_arcache           => JTAG_CONV.ARCACHE,
        s_axi_arprot            => JTAG_CONV.ARPROT,
        s_axi_arregion          => JTAG_CONV.ARREGION,
        s_axi_arqos             => JTAG_CONV.ARQOS,
        s_axi_arvalid           => JTAG_CONV.ARVALID,
        s_axi_rready            => JTAG_CONV.RREADY,
        -- Slave AXI Out
        s_axi_awready           => CONV_JTAG.AWREADY,
        s_axi_wready            => CONV_JTAG.WREADY,
        s_axi_bresp             => CONV_JTAG.BRESP,
        s_axi_bvalid            => CONV_JTAG.BVALID,
        s_axi_arready           => CONV_JTAG.ARREADY,
        s_axi_rdata             => CONV_JTAG.RDATA,
        s_axi_rresp             => CONV_JTAG.RRESP,
        s_axi_rlast             => CONV_JTAG.RLAST,
        s_axi_rvalid            => CONV_JTAG.RVALID,

        -- Master AXILITE In
        m_axi_awready           => MAC_CONV.AWREADY,
        m_axi_wready            => MAC_CONV.WREADY,
        m_axi_bresp             => MAC_CONV.BRESP,
        m_axi_bvalid            => MAC_CONV.BVALID,
        m_axi_arready           => MAC_CONV.ARREADY,
        m_axi_rdata             => MAC_CONV.RDATA,
        m_axi_rresp             => MAC_CONV.RRESP,
        m_axi_rvalid            => MAC_CONV.RVALID,
        -- Master AXILITE Out
        m_axi_awaddr            => CONV_MAC.AWADDR,
        m_axi_awprot            => CONV_MAC.AWPROT,
        m_axi_awvalid           => CONV_MAC.AWVALID,
        m_axi_wdata             => CONV_MAC.WDATA,
        m_axi_wstrb             => CONV_MAC.WSTRB,
        m_axi_wvalid            => CONV_MAC.WVALID,
        m_axi_bready            => CONV_MAC.BREADY,
        m_axi_araddr            => CONV_MAC.ARADDR,
        m_axi_arprot            => CONV_MAC.ARPROT,
        m_axi_arvalid           => CONV_MAC.ARVALID,
        m_axi_rready            => CONV_MAC.RREADY
    );

    U_MAC : axi_ethernetlite_100_unbuff_mgmt
    PORT MAP (
        s_axi_aclk              => CLK,
        s_axi_aresetn           => nRESET,
        ip2intc_irpt            => open,

        -- AXILITE Slave In
        s_axi_araddr            => CONV_MAC.ARADDR(12 downto 0),
        s_axi_arvalid           => CONV_MAC.ARVALID,
        s_axi_awaddr            => CONV_MAC.AWADDR(12 downto 0),
        s_axi_awvalid           => CONV_MAC.AWVALID,
        s_axi_bready            => CONV_MAC.BREADY,
        s_axi_rready            => CONV_MAC.RREADY,
        s_axi_wdata             => CONV_MAC.WDATA,
        s_axi_wstrb             => CONV_MAC.WSTRB,
        s_axi_wvalid            => CONV_MAC.WVALID,
        -- AXILITE Slave Out
        s_axi_awready           => MAC_CONV.AWREADY,
        s_axi_wready            => MAC_CONV.WREADY,
        s_axi_bresp             => MAC_CONV.BRESP,
        s_axi_bvalid            => MAC_CONV.BVALID,
        s_axi_arready           => MAC_CONV.ARREADY,
        s_axi_rdata             => MAC_CONV.RDATA,
        s_axi_rresp             => MAC_CONV.RRESP,
        s_axi_rvalid            => MAC_CONV.RVALID,

        -- PHY In
        phy_col                 => RMII_MAC_COL,
        phy_crs                 => RMII_MAC_CRS,
        phy_dv                  => RMII_MAC_RX_DV,
        phy_mdio_i              => ETH_PHY_MDIO_O,
        phy_rx_clk              => RMII_MAC_RX_CLK,
        phy_rx_data             => RMII_MAC_RXD,
        phy_rx_er               => RMII_MAC_RX_ER,
        phy_tx_clk              => RMII_MAC_TX_CLK,
        -- PHY Out
        phy_mdc                 => ETH_PHY_MDC,
        phy_mdio_o              => ETH_PHY_MDIO_I,
        phy_mdio_t              => ETH_PHY_MDIO_T,
        phy_rst_n               => ETH_PHY_nRESET,
        phy_tx_data             => MAC_RMII_TXD,
        phy_tx_en               => MAC_RMII_TX_EN

    );


    U_RMII : mii_to_rmii_fixed_100
    port map (
        ref_clk                 => CLK_ETH,
        rst_n                   => nRESET,
        
        mac2rmii_tx_en          => MAC_RMII_TX_EN,
        mac2rmii_txd            => MAC_RMII_TXD,
        mac2rmii_tx_er          => '0',

        rmii2mac_tx_clk         => RMII_MAC_TX_CLK,
        rmii2mac_rx_clk         => RMII_MAC_RX_CLK,
        rmii2mac_col            => RMII_MAC_COL,
        rmii2mac_crs            => RMII_MAC_CRS,
        rmii2mac_rx_dv          => RMII_MAC_RX_DV,
        rmii2mac_rx_er          => RMII_MAC_RX_ER,
        rmii2mac_rxd            => RMII_MAC_RXD,

        phy2rmii_crs_dv         => ETH_PHY_CRSDV,
        phy2rmii_rx_er          => ETH_PHY_RXERR,
        phy2rmii_rxd            => ETH_PHY_RXD,
        rmii2phy_txd            => ETH_PHY_TXD,
        rmii2phy_tx_en          => ETH_PHY_TXEN
    );
end struct;
--------------------------------------------------------------------------------
