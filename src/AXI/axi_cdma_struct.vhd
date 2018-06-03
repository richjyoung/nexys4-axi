library AXI, ETHERNET, IEEE, UNISIM, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use UNISIM.VCOMPONENTS.all;
use xil_defaultlib.components.all;
--------------------------------------------------------------------------------
architecture struct of axi_cdma is

    -- AXI Converter to CDMA
    signal CONV_CDMA            : T_AXI4LITE_MASTER_SLAVE_32x32;
    signal CDMA_CONV            : T_AXI4LITE_SLAVE_MASTER_32x32;

begin

    M_AXI_OUT.AWID              <= (others => '0');
    M_AXI_OUT.AWLOCK            <= '0';
    M_AXI_OUT.AWQOS             <= (others => '0');
    M_AXI_OUT.AWREGION          <= (others => '0');
    M_AXI_OUT.ARID              <= (others => '0');
    M_AXI_OUT.ARLOCK            <= '0';
    M_AXI_OUT.ARQOS             <= (others => '0');
    M_AXI_OUT.ARREGION          <= (others => '0');

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
        m_axi_awready           => CDMA_CONV.AWREADY,
        m_axi_wready            => CDMA_CONV.WREADY,
        m_axi_bresp             => CDMA_CONV.BRESP,
        m_axi_bvalid            => CDMA_CONV.BVALID,
        m_axi_arready           => CDMA_CONV.ARREADY,
        m_axi_rdata             => CDMA_CONV.RDATA,
        m_axi_rresp             => CDMA_CONV.RRESP,
        m_axi_rvalid            => CDMA_CONV.RVALID,
        -- Master AXILITE Out
        m_axi_awaddr            => CONV_CDMA.AWADDR,
        m_axi_awprot            => CONV_CDMA.AWPROT,
        m_axi_awvalid           => CONV_CDMA.AWVALID,
        m_axi_wdata             => CONV_CDMA.WDATA,
        m_axi_wstrb             => CONV_CDMA.WSTRB,
        m_axi_wvalid            => CONV_CDMA.WVALID,
        m_axi_bready            => CONV_CDMA.BREADY,
        m_axi_araddr            => CONV_CDMA.ARADDR,
        m_axi_arprot            => CONV_CDMA.ARPROT,
        m_axi_arvalid           => CONV_CDMA.ARVALID,
        m_axi_rready            => CONV_CDMA.RREADY
    );

    U_CDMA : axi_cdma_simple_32x32_16
    PORT MAP (
        m_axi_aclk              => CLK,
        s_axi_lite_aclk         => CLK,
        s_axi_lite_aresetn      => nRESET,
        cdma_introut            => CDMA_IRQ,
        cdma_tvect_out          => CDMA_TVECT,

        -- Slave AXI Lite In
        s_axi_lite_awvalid      => CONV_CDMA.AWVALID,
        s_axi_lite_awaddr       => CONV_CDMA.AWADDR(5 downto 0),
        s_axi_lite_wdata        => CONV_CDMA.WDATA,
        s_axi_lite_wvalid       => CONV_CDMA.WVALID,
        s_axi_lite_bready       => CONV_CDMA.BREADY,
        s_axi_lite_arvalid      => CONV_CDMA.ARVALID,
        s_axi_lite_araddr       => CONV_CDMA.ARADDR(5 downto 0),
        s_axi_lite_rready       => CONV_CDMA.RREADY,

        -- Slave AXI Lite Out
        s_axi_lite_awready      => CDMA_CONV.AWREADY,
        s_axi_lite_wready       => CDMA_CONV.WREADY,
        s_axi_lite_bvalid       => CDMA_CONV.BVALID,
        s_axi_lite_bresp        => CDMA_CONV.BRESP,
        s_axi_lite_arready      => CDMA_CONV.ARREADY,
        s_axi_lite_rvalid       => CDMA_CONV.RVALID,
        s_axi_lite_rdata        => CDMA_CONV.RDATA,
        s_axi_lite_rresp        => CDMA_CONV.RRESP,

        -- Master AXI In
        m_axi_awready           => M_AXI_IN.AWREADY,
        m_axi_wready            => M_AXI_IN.WREADY,
        m_axi_bvalid            => M_AXI_IN.BVALID,
        m_axi_bresp             => M_AXI_IN.BRESP,
        m_axi_arready           => M_AXI_IN.ARREADY,
        m_axi_rvalid            => M_AXI_IN.RVALID,
        m_axi_rdata             => M_AXI_IN.RDATA,
        m_axi_rresp             => M_AXI_IN.RRESP,
        m_axi_rlast             => M_AXI_IN.RLAST,
        -- Master AXI Out
        m_axi_arvalid           => M_AXI_OUT.ARVALID,
        m_axi_araddr            => M_AXI_OUT.ARADDR,
        m_axi_arlen             => M_AXI_OUT.ARLEN,
        m_axi_arsize            => M_AXI_OUT.ARSIZE,
        m_axi_arburst           => M_AXI_OUT.ARBURST,
        m_axi_arprot            => M_AXI_OUT.ARPROT,
        m_axi_arcache           => M_AXI_OUT.ARCACHE,
        m_axi_rready            => M_AXI_OUT.RREADY,
        m_axi_awvalid           => M_AXI_OUT.AWVALID,
        m_axi_awaddr            => M_AXI_OUT.AWADDR,
        m_axi_awlen             => M_AXI_OUT.AWLEN,
        m_axi_awsize            => M_AXI_OUT.AWSIZE,
        m_axi_awburst           => M_AXI_OUT.AWBURST,
        m_axi_awprot            => M_AXI_OUT.AWPROT,
        m_axi_awcache           => M_AXI_OUT.AWCACHE,
        m_axi_wvalid            => M_AXI_OUT.WVALID,
        m_axi_wdata             => M_AXI_OUT.WDATA,
        m_axi_wstrb             => M_AXI_OUT.WSTRB,
        m_axi_wlast             => M_AXI_OUT.WLAST,
        m_axi_bready            => M_AXI_OUT.BREADY
    );

end architecture struct;