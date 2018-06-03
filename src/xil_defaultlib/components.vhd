library IEEE, xil_defaultlib;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

package components is

    COMPONENT axi_ethernetlite_100_unbuff_mgmt
    PORT (
        s_axi_aclk : IN STD_LOGIC;
        s_axi_aresetn : IN STD_LOGIC;
        ip2intc_irpt : OUT STD_LOGIC;
        s_axi_awaddr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
        s_axi_awvalid : IN STD_LOGIC;
        s_axi_awready : OUT STD_LOGIC;
        s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_wvalid : IN STD_LOGIC;
        s_axi_wready : OUT STD_LOGIC;
        s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC;
        s_axi_bready : IN STD_LOGIC;
        s_axi_araddr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC;
        s_axi_arready : OUT STD_LOGIC;
        s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rvalid : OUT STD_LOGIC;
        s_axi_rready : IN STD_LOGIC;
        phy_tx_clk : IN STD_LOGIC;
        phy_rx_clk : IN STD_LOGIC;
        phy_crs : IN STD_LOGIC;
        phy_dv : IN STD_LOGIC;
        phy_rx_data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        phy_col : IN STD_LOGIC;
        phy_rx_er : IN STD_LOGIC;
        phy_rst_n : OUT STD_LOGIC;
        phy_tx_en : OUT STD_LOGIC;
        phy_tx_data : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        phy_mdio_i : IN STD_LOGIC;
        phy_mdio_o : OUT STD_LOGIC;
        phy_mdio_t : OUT STD_LOGIC;
        phy_mdc : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT axi_s_to_axilite_m_32x32_conv
    PORT (
        aclk : IN STD_LOGIC;
        aresetn : IN STD_LOGIC;
        s_axi_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_awlock : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_awregion : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awvalid : IN STD_LOGIC;
        s_axi_awready : OUT STD_LOGIC;
        s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_wlast : IN STD_LOGIC;
        s_axi_wvalid : IN STD_LOGIC;
        s_axi_wready : OUT STD_LOGIC;
        s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC;
        s_axi_bready : IN STD_LOGIC;
        s_axi_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arlock : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arregion : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC;
        s_axi_arready : OUT STD_LOGIC;
        s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rlast : OUT STD_LOGIC;
        s_axi_rvalid : OUT STD_LOGIC;
        s_axi_rready : IN STD_LOGIC;
        m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awvalid : OUT STD_LOGIC;
        m_axi_awready : IN STD_LOGIC;
        m_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_wvalid : OUT STD_LOGIC;
        m_axi_wready : IN STD_LOGIC;
        m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_bvalid : IN STD_LOGIC;
        m_axi_bready : OUT STD_LOGIC;
        m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arvalid : OUT STD_LOGIC;
        m_axi_arready : IN STD_LOGIC;
        m_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_rvalid : IN STD_LOGIC;
        m_axi_rready : OUT STD_LOGIC
    );
    END COMPONENT;

    component clk_100_50_50p45
    port (-- Clock in ports
        -- Clock out ports
        clk_sys          : out    std_logic;
        clk_eth          : out    std_logic;
        clk_eth_ext          : out    std_logic;
        -- Status and control signals
        resetn             : in     std_logic;
        locked            : out    std_logic;
        clk_in1           : in     std_logic
    );
    end component;

    COMPONENT jtag_axi_m
    PORT (
        aclk : IN STD_LOGIC;
        aresetn : IN STD_LOGIC;
        m_axi_awid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_awlock : OUT STD_LOGIC;
        m_axi_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_awvalid : OUT STD_LOGIC;
        m_axi_awready : IN STD_LOGIC;
        m_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_wlast : OUT STD_LOGIC;
        m_axi_wvalid : OUT STD_LOGIC;
        m_axi_wready : IN STD_LOGIC;
        m_axi_bid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_bvalid : IN STD_LOGIC;
        m_axi_bready : OUT STD_LOGIC;
        m_axi_arid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arlock : OUT STD_LOGIC;
        m_axi_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_arvalid : OUT STD_LOGIC;
        m_axi_arready : IN STD_LOGIC;
        m_axi_rid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        m_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_rlast : IN STD_LOGIC;
        m_axi_rvalid : IN STD_LOGIC;
        m_axi_rready : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT mii_to_rmii_fixed_100
    PORT (
        rst_n : IN STD_LOGIC;
        ref_clk : IN STD_LOGIC;
        mac2rmii_tx_en : IN STD_LOGIC;
        mac2rmii_txd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        mac2rmii_tx_er : IN STD_LOGIC;
        rmii2mac_tx_clk : OUT STD_LOGIC;
        rmii2mac_rx_clk : OUT STD_LOGIC;
        rmii2mac_col : OUT STD_LOGIC;
        rmii2mac_crs : OUT STD_LOGIC;
        rmii2mac_rx_dv : OUT STD_LOGIC;
        rmii2mac_rx_er : OUT STD_LOGIC;
        rmii2mac_rxd : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        phy2rmii_crs_dv : IN STD_LOGIC;
        phy2rmii_rx_er : IN STD_LOGIC;
        phy2rmii_rxd : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        rmii2phy_txd : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        rmii2phy_tx_en : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT axi_uartlite_115200_8_n_1
    PORT (
        s_axi_aclk : IN STD_LOGIC;
        s_axi_aresetn : IN STD_LOGIC;
        interrupt : OUT STD_LOGIC;
        s_axi_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awvalid : IN STD_LOGIC;
        s_axi_awready : OUT STD_LOGIC;
        s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_wvalid : IN STD_LOGIC;
        s_axi_wready : OUT STD_LOGIC;
        s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC;
        s_axi_bready : IN STD_LOGIC;
        s_axi_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC;
        s_axi_arready : OUT STD_LOGIC;
        s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rvalid : OUT STD_LOGIC;
        s_axi_rready : IN STD_LOGIC;
        rx : IN STD_LOGIC;
        tx : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT axi_crossbar_1x2_32x32
    PORT (
        aclk : IN STD_LOGIC;
        aresetn : IN STD_LOGIC;
        s_axi_awid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_awlock : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_awready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_wlast : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_wvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_wready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_bid : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_bready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_arid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arlock : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_arready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_rid : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rlast : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_rvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_rready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        m_axi_awid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        m_axi_awaddr : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
        m_axi_awlen : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        m_axi_awsize : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_awburst : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_awlock : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_awcache : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_awprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_awregion : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_awqos : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_awvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_awready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_wdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
        m_axi_wstrb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_wlast : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_wvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_wready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_bid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        m_axi_bresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_bvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_bready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        m_axi_araddr : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
        m_axi_arlen : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        m_axi_arsize : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_arburst : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_arlock : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arcache : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_arprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_arregion : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_arqos : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_arvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_rid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        m_axi_rdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        m_axi_rresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_rlast : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_rvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_rready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT axi_cdma_simple_32x32_16
    PORT (
        m_axi_aclk : IN STD_LOGIC;
        s_axi_lite_aclk : IN STD_LOGIC;
        s_axi_lite_aresetn : IN STD_LOGIC;
        cdma_introut : OUT STD_LOGIC;
        s_axi_lite_awready : OUT STD_LOGIC;
        s_axi_lite_awvalid : IN STD_LOGIC;
        s_axi_lite_awaddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_lite_wready : OUT STD_LOGIC;
        s_axi_lite_wvalid : IN STD_LOGIC;
        s_axi_lite_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_lite_bready : IN STD_LOGIC;
        s_axi_lite_bvalid : OUT STD_LOGIC;
        s_axi_lite_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_lite_arready : OUT STD_LOGIC;
        s_axi_lite_arvalid : IN STD_LOGIC;
        s_axi_lite_araddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_lite_rready : IN STD_LOGIC;
        s_axi_lite_rvalid : OUT STD_LOGIC;
        s_axi_lite_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_lite_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arready : IN STD_LOGIC;
        m_axi_arvalid : OUT STD_LOGIC;
        m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_rready : OUT STD_LOGIC;
        m_axi_rvalid : IN STD_LOGIC;
        m_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_rlast : IN STD_LOGIC;
        m_axi_awready : IN STD_LOGIC;
        m_axi_awvalid : OUT STD_LOGIC;
        m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_wready : IN STD_LOGIC;
        m_axi_wvalid : OUT STD_LOGIC;
        m_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_wlast : OUT STD_LOGIC;
        m_axi_bready : OUT STD_LOGIC;
        m_axi_bvalid : IN STD_LOGIC;
        m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        cdma_tvect_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT axi_crossbar_2x3_32x32
    PORT (
        aclk : IN STD_LOGIC;
        aresetn : IN STD_LOGIC;
        s_axi_awid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_awaddr : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        s_axi_awlen : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_awsize : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_awburst : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awlock : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_awcache : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_awprot : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_awqos : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_awvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_awready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_wdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        s_axi_wstrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_wlast : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_wvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_wready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_bresp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_araddr : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        s_axi_arlen : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_arsize : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_arburst : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arlock : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arcache : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_arprot : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_arqos : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_rdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
        s_axi_rresp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_rlast : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_awid : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
        m_axi_awaddr : OUT STD_LOGIC_VECTOR(95 DOWNTO 0);
        m_axi_awlen : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
        m_axi_awsize : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        m_axi_awburst : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_awlock : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awcache : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        m_axi_awprot : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        m_axi_awregion : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        m_axi_awqos : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        m_axi_awvalid : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awready : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_wdata : OUT STD_LOGIC_VECTOR(95 DOWNTO 0);
        m_axi_wstrb : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        m_axi_wlast : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_wvalid : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_wready : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_bid : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        m_axi_bresp : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_bvalid : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_bready : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arid : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
        m_axi_araddr : OUT STD_LOGIC_VECTOR(95 DOWNTO 0);
        m_axi_arlen : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
        m_axi_arsize : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        m_axi_arburst : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_arlock : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arcache : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        m_axi_arprot : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        m_axi_arregion : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        m_axi_arqos : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        m_axi_arvalid : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arready : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_rid : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        m_axi_rdata : IN STD_LOGIC_VECTOR(95 DOWNTO 0);
        m_axi_rresp : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        m_axi_rlast : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_rvalid : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_rready : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
    END COMPONENT;

end components;

package body components is
end components;