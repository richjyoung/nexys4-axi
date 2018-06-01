--------------------------------------------------------------------------------
-- xil_defaultlib/top_level(struct) - Architecture
--------------------------------------------------------------------------------
library IEEE, UNISIM, xil_defaultlib;
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
    signal JTAG_CONV_AWADDR     : std_logic_vector(31 downto 0);
    signal JTAG_CONV_AWLEN      : std_logic_vector(7 downto 0);
    signal JTAG_CONV_AWSIZE     : std_logic_vector(2 downto 0);
    signal JTAG_CONV_AWBURST    : std_logic_vector(1 downto 0);
    signal JTAG_CONV_AWLOCK     : std_logic_vector(0 downto 0);
    signal JTAG_CONV_AWCACHE    : std_logic_vector(3 downto 0);
    signal JTAG_CONV_AWPROT     : std_logic_vector(2 downto 0);
    signal JTAG_CONV_AWREGION   : std_logic_vector(3 downto 0);
    signal JTAG_CONV_AWQOS      : std_logic_vector(3 downto 0);
    signal JTAG_CONV_AWVALID    : std_logic;
    signal JTAG_CONV_WDATA      : std_logic_vector(31 downto 0);
    signal JTAG_CONV_WSTRB      : std_logic_vector(3 downto 0);
    signal JTAG_CONV_WLAST      : std_logic;
    signal JTAG_CONV_WVALID     : std_logic;
    signal JTAG_CONV_BREADY     : std_logic;
    signal JTAG_CONV_ARADDR     : std_logic_vector(31 downto 0);
    signal JTAG_CONV_ARLEN      : std_logic_vector(7 downto 0);
    signal JTAG_CONV_ARSIZE     : std_logic_vector(2 downto 0);
    signal JTAG_CONV_ARBURST    : std_logic_vector(1 downto 0);
    signal JTAG_CONV_ARLOCK     : std_logic_vector(0 downto 0);
    signal JTAG_CONV_ARCACHE    : std_logic_vector(3 downto 0);
    signal JTAG_CONV_ARPROT     : std_logic_vector(2 downto 0);
    signal JTAG_CONV_ARREGION   : std_logic_vector(3 downto 0);
    signal JTAG_CONV_ARQOS      : std_logic_vector(3 downto 0);
    signal JTAG_CONV_ARVALID    : std_logic;
    signal JTAG_CONV_RREADY     : std_logic;
    signal CONV_JTAG_AWREADY    : std_logic;
    signal CONV_JTAG_WREADY     : std_logic;
    signal CONV_JTAG_BRESP      : std_logic_vector(1 downto 0);
    signal CONV_JTAG_BVALID     : std_logic;
    signal CONV_JTAG_ARREADY    : std_logic;
    signal CONV_JTAG_RDATA      : std_logic_vector(31 downto 0);
    signal CONV_JTAG_RRESP      : std_logic_vector(1 downto 0);
    signal CONV_JTAG_RLAST      : std_logic;
    signal CONV_JTAG_RVALID     : std_logic;

    -- AXI Converter to Ethernet MAC
    signal MAC_CONV_AWREADY     : std_logic;
    signal MAC_CONV_WREADY      : std_logic;
    signal MAC_CONV_BRESP       : std_logic_vector(1 downto 0);
    signal MAC_CONV_BVALID      : std_logic;
    signal MAC_CONV_ARREADY     : std_logic;
    signal MAC_CONV_RDATA       : std_logic_vector(31 downto 0);
    signal MAC_CONV_RRESP       : std_logic_vector(1 downto 0);
    signal MAC_CONV_RVALID      : std_logic;
    signal CONV_MAC_AWADDR      : std_logic_vector(31 downto 0);
    signal CONV_MAC_AWPROT      : std_logic_vector(2 downto 0);
    signal CONV_MAC_AWVALID     : std_logic;
    signal CONV_MAC_WDATA       : std_logic_vector(31 downto 0);
    signal CONV_MAC_WSTRB       : std_logic_vector(3 downto 0);
    signal CONV_MAC_WVALID      : std_logic;
    signal CONV_MAC_BREADY      : std_logic;
    signal CONV_MAC_ARADDR      : std_logic_vector(31 downto 0);
    signal CONV_MAC_ARPROT      : std_logic_vector(2 downto 0);
    signal CONV_MAC_ARVALID     : std_logic;
    signal CONV_MAC_RREADY      : std_logic;

begin

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
        m_axi_awready           => CONV_JTAG_AWREADY,
        m_axi_wready            => CONV_JTAG_WREADY,
        m_axi_bid               => "0",
        m_axi_bresp             => CONV_JTAG_BRESP,
        m_axi_bvalid            => CONV_JTAG_BVALID,
        m_axi_arready           => CONV_JTAG_ARREADY,
        m_axi_rid               => "0",
        m_axi_rdata             => CONV_JTAG_RDATA,
        m_axi_rresp             => CONV_JTAG_RRESP,
        m_axi_rlast             => CONV_JTAG_RLAST,
        m_axi_rvalid            => CONV_JTAG_RVALID,
        -- AXI Master Out
        m_axi_awid              => open,
        m_axi_awaddr            => JTAG_CONV_AWADDR,
        m_axi_awlen             => JTAG_CONV_AWLEN,
        m_axi_awsize            => JTAG_CONV_AWSIZE,
        m_axi_awburst           => JTAG_CONV_AWBURST,
        m_axi_awlock            => JTAG_CONV_AWLOCK(0),
        m_axi_awcache           => JTAG_CONV_AWCACHE,
        m_axi_awprot            => JTAG_CONV_AWPROT,
        m_axi_awqos             => JTAG_CONV_AWQOS,
        m_axi_awvalid           => JTAG_CONV_AWVALID,
        m_axi_wdata             => JTAG_CONV_WDATA,
        m_axi_wstrb             => JTAG_CONV_WSTRB,
        m_axi_wlast             => JTAG_CONV_WLAST,
        m_axi_wvalid            => JTAG_CONV_WVALID,
        m_axi_bready            => JTAG_CONV_BREADY,
        m_axi_arid              => open,
        m_axi_araddr            => JTAG_CONV_ARADDR,
        m_axi_arlen             => JTAG_CONV_ARLEN,
        m_axi_arsize            => JTAG_CONV_ARSIZE,
        m_axi_arburst           => JTAG_CONV_ARBURST,
        m_axi_arlock            => JTAG_CONV_ARLOCK(0),
        m_axi_arcache           => JTAG_CONV_ARCACHE,
        m_axi_arprot            => JTAG_CONV_ARPROT,
        m_axi_arqos             => JTAG_CONV_ARQOS,
        m_axi_arvalid           => JTAG_CONV_ARVALID,
        m_axi_rready            => JTAG_CONV_RREADY
    );

    U_CONV : axi_s_to_axilite_m_32x32_conv
    port map (
        aclk                    => CLK,
        aresetn                 => nRESET,

        -- Slave AXI In
        s_axi_awaddr            => JTAG_CONV_AWADDR,
        s_axi_awlen             => JTAG_CONV_AWLEN,
        s_axi_awsize            => JTAG_CONV_AWSIZE,
        s_axi_awburst           => JTAG_CONV_AWBURST,
        s_axi_awlock            => JTAG_CONV_AWLOCK,
        s_axi_awcache           => JTAG_CONV_AWCACHE,
        s_axi_awprot            => JTAG_CONV_AWPROT,
        s_axi_awregion          => JTAG_CONV_AWREGION,
        s_axi_awqos             => JTAG_CONV_AWQOS,
        s_axi_awvalid           => JTAG_CONV_AWVALID,
        s_axi_wdata             => JTAG_CONV_WDATA,
        s_axi_wstrb             => JTAG_CONV_WSTRB,
        s_axi_wlast             => JTAG_CONV_WLAST,
        s_axi_wvalid            => JTAG_CONV_WVALID,
        s_axi_bready            => JTAG_CONV_BREADY,
        s_axi_araddr            => JTAG_CONV_ARADDR,
        s_axi_arlen             => JTAG_CONV_ARLEN,
        s_axi_arsize            => JTAG_CONV_ARSIZE,
        s_axi_arburst           => JTAG_CONV_ARBURST,
        s_axi_arlock            => JTAG_CONV_ARLOCK,
        s_axi_arcache           => JTAG_CONV_ARCACHE,
        s_axi_arprot            => JTAG_CONV_ARPROT,
        s_axi_arregion          => JTAG_CONV_ARREGION,
        s_axi_arqos             => JTAG_CONV_ARQOS,
        s_axi_arvalid           => JTAG_CONV_ARVALID,
        s_axi_rready            => JTAG_CONV_RREADY,
        -- Slave AXI Out
        s_axi_awready           => CONV_JTAG_AWREADY,
        s_axi_wready            => CONV_JTAG_WREADY,
        s_axi_bresp             => CONV_JTAG_BRESP,
        s_axi_bvalid            => CONV_JTAG_BVALID,
        s_axi_arready           => CONV_JTAG_ARREADY,
        s_axi_rdata             => CONV_JTAG_RDATA,
        s_axi_rresp             => CONV_JTAG_RRESP,
        s_axi_rlast             => CONV_JTAG_RLAST,
        s_axi_rvalid            => CONV_JTAG_RVALID,

        -- Master AXILITE In
        m_axi_awready           => MAC_CONV_AWREADY,
        m_axi_wready            => MAC_CONV_WREADY,
        m_axi_bresp             => MAC_CONV_BRESP,
        m_axi_bvalid            => MAC_CONV_BVALID,
        m_axi_arready           => MAC_CONV_ARREADY,
        m_axi_rdata             => MAC_CONV_RDATA,
        m_axi_rresp             => MAC_CONV_RRESP,
        m_axi_rvalid            => MAC_CONV_RVALID,
        -- Master AXILITE Out
        m_axi_awaddr            => CONV_MAC_AWADDR,
        m_axi_awprot            => CONV_MAC_AWPROT,
        m_axi_awvalid           => CONV_MAC_AWVALID,
        m_axi_wdata             => CONV_MAC_WDATA,
        m_axi_wstrb             => CONV_MAC_WSTRB,
        m_axi_wvalid            => CONV_MAC_WVALID,
        m_axi_bready            => CONV_MAC_BREADY,
        m_axi_araddr            => CONV_MAC_ARADDR,
        m_axi_arprot            => CONV_MAC_ARPROT,
        m_axi_arvalid           => CONV_MAC_ARVALID,
        m_axi_rready            => CONV_MAC_RREADY
    );

    U_MAC : axi_ethernetlite_100_unbuff_mgmt
    PORT MAP (
        s_axi_aclk              => CLK,
        s_axi_aresetn           => nRESET,
        ip2intc_irpt            => open,

        -- AXILITE Slave In
        s_axi_araddr            => CONV_MAC_ARADDR(12 downto 0),
        s_axi_arvalid           => CONV_MAC_ARVALID,
        s_axi_awaddr            => CONV_MAC_AWADDR(12 downto 0),
        s_axi_awvalid           => CONV_MAC_AWVALID,
        s_axi_bready            => CONV_MAC_BREADY,
        s_axi_rready            => CONV_MAC_RREADY,
        s_axi_wdata             => CONV_MAC_WDATA,
        s_axi_wstrb             => CONV_MAC_WSTRB,
        s_axi_wvalid            => CONV_MAC_WVALID,
        -- AXILITE Slave Out
        s_axi_awready           => MAC_CONV_AWREADY,
        s_axi_wready            => MAC_CONV_WREADY,
        s_axi_bresp             => MAC_CONV_BRESP,
        s_axi_bvalid            => MAC_CONV_BVALID,
        s_axi_arready           => MAC_CONV_ARREADY,
        s_axi_rdata             => MAC_CONV_RDATA,
        s_axi_rresp             => MAC_CONV_RRESP,
        s_axi_rvalid            => MAC_CONV_RVALID,

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
