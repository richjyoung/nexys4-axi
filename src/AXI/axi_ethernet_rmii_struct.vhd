library AXI, ETHERNET, IEEE, UNISIM, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use UNISIM.VCOMPONENTS.all;
use xil_defaultlib.components.all;
--------------------------------------------------------------------------------
architecture struct of axi_ethernet_rmii is

    -- AXI Converter to Ethernet MAC
    signal CONV_MAC             : T_AXI4LITE_MASTER_SLAVE_32x32;
    signal MAC_CONV             : T_AXI4LITE_SLAVE_MASTER_32x32;

    -- MAC/RMII Converter Interface Signals
    signal RMII_MAC             : T_ETH_MII_PHY_MAC;
    signal MAC_RMII             : T_ETH_MII_MAC_PHY;

    -- PHY MDIO Signals
    signal ETH_PHY_MDIO_I       : std_logic;
    signal ETH_PHY_MDIO_O       : std_logic;
    signal ETH_PHY_MDIO_T       : std_logic;

begin

    S_AXI_OUT.BID               <= (others => '0');
    S_AXI_OUT.RID               <= (others => '0');

    U_CONV : axi_s_to_axilite_m_32x32_conv
    port map (
        aclk                    => CLK,
        aresetn                 => nRESET,

        -- Slave AXI In
        s_axi_awaddr            => S_AXI_IN.AWADDR,
        s_axi_awlen             => S_AXI_IN.AWLEN,
        s_axi_awsize            => S_AXI_IN.AWSIZE,
        s_axi_awburst           => S_AXI_IN.AWBURST,
        s_axi_awlock(0)         => S_AXI_IN.AWLOCK,
        s_axi_awcache           => S_AXI_IN.AWCACHE,
        s_axi_awprot            => S_AXI_IN.AWPROT,
        s_axi_awregion          => S_AXI_IN.AWREGION,
        s_axi_awqos             => S_AXI_IN.AWQOS,
        s_axi_awvalid           => S_AXI_IN.AWVALID,
        s_axi_wdata             => S_AXI_IN.WDATA,
        s_axi_wstrb             => S_AXI_IN.WSTRB,
        s_axi_wlast             => S_AXI_IN.WLAST,
        s_axi_wvalid            => S_AXI_IN.WVALID,
        s_axi_bready            => S_AXI_IN.BREADY,
        s_axi_araddr            => S_AXI_IN.ARADDR,
        s_axi_arlen             => S_AXI_IN.ARLEN,
        s_axi_arsize            => S_AXI_IN.ARSIZE,
        s_axi_arburst           => S_AXI_IN.ARBURST,
        s_axi_arlock(0)         => S_AXI_IN.ARLOCK,
        s_axi_arcache           => S_AXI_IN.ARCACHE,
        s_axi_arprot            => S_AXI_IN.ARPROT,
        s_axi_arregion          => S_AXI_IN.ARREGION,
        s_axi_arqos             => S_AXI_IN.ARQOS,
        s_axi_arvalid           => S_AXI_IN.ARVALID,
        s_axi_rready            => S_AXI_IN.RREADY,
        -- Slave AXI Out
        s_axi_awready           => S_AXI_OUT.AWREADY,
        s_axi_wready            => S_AXI_OUT.WREADY,
        s_axi_bresp             => S_AXI_OUT.BRESP,
        s_axi_bvalid            => S_AXI_OUT.BVALID,
        s_axi_arready           => S_AXI_OUT.ARREADY,
        s_axi_rdata             => S_AXI_OUT.RDATA,
        s_axi_rresp             => S_AXI_OUT.RRESP,
        s_axi_rlast             => S_AXI_OUT.RLAST,
        s_axi_rvalid            => S_AXI_OUT.RVALID,

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
        ip2intc_irpt            => ETH_MAC_IRQ,

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
        phy_col                 => RMII_MAC.COL,
        phy_crs                 => RMII_MAC.CRS,
        phy_dv                  => RMII_MAC.RX_DV,
        phy_mdio_i              => ETH_PHY_MDIO_O,
        phy_rx_clk              => RMII_MAC.RX_CLK,
        phy_rx_data             => RMII_MAC.RXD,
        phy_rx_er               => RMII_MAC.RX_ER,
        phy_tx_clk              => RMII_MAC.TX_CLK,
        -- PHY Out
        phy_mdc                 => MDC,
        phy_mdio_o              => ETH_PHY_MDIO_I,
        phy_mdio_t              => ETH_PHY_MDIO_T,
        phy_rst_n               => ETH_PHY_nRESET,
        phy_tx_data             => MAC_RMII.TXD,
        phy_tx_en               => MAC_RMII.TX_EN

    );


    U_RMII : mii_to_rmii_fixed_100
    port map (
        ref_clk                 => CLK_ETH,
        rst_n                   => nRESET,
        
        mac2rmii_tx_en          => MAC_RMII.TX_EN,
        mac2rmii_txd            => MAC_RMII.TXD,
        mac2rmii_tx_er          => '0',

        rmii2mac_tx_clk         => RMII_MAC.TX_CLK,
        rmii2mac_rx_clk         => RMII_MAC.RX_CLK,
        rmii2mac_col            => RMII_MAC.COL,
        rmii2mac_crs            => RMII_MAC.CRS,
        rmii2mac_rx_dv          => RMII_MAC.RX_DV,
        rmii2mac_rx_er          => RMII_MAC.RX_ER,
        rmii2mac_rxd            => RMII_MAC.RXD,

        phy2rmii_crs_dv         => RMII_IN.CRS_DV,
        phy2rmii_rx_er          => RMII_IN.RX_ER,
        phy2rmii_rxd            => RMII_IN.RXD,
        rmii2phy_txd            => RMII_OUT.TXD,
        rmii2phy_tx_en          => RMII_OUT.TX_EN
    );

    U_MDIO : IOBUF
    port map (
        IO                      => MDIO,
        I                       => ETH_PHY_MDIO_I,
        O                       => ETH_PHY_MDIO_O,
        T                       => ETH_PHY_MDIO_T
    );

end architecture struct;