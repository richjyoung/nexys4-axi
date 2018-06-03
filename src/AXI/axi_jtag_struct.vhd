library AXI, ETHERNET, IEEE, UNISIM, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use UNISIM.VCOMPONENTS.all;
use xil_defaultlib.components.all;
--------------------------------------------------------------------------------
architecture struct of axi_jtag is

begin

    M_AXI_OUT.AWID(M_AXI_OUT.AWID'high downto 1)        <= (others => '0');
    M_AXI_OUT.ARID(M_AXI_OUT.ARID'high downto 1)        <= (others => '0');
    M_AXI_OUT.AWREGION          <= (others => '0');
    M_AXI_OUT.ARREGION          <= (others => '0');

    U_JTAG : jtag_axi_m
    port map (
        aclk                    => CLK,
        aresetn                 => nRESET,
        
        -- AXI Master In
        m_axi_awready           => M_AXI_IN.AWREADY,
        m_axi_wready            => M_AXI_IN.WREADY,
        m_axi_bid               => M_AXI_IN.BID(0 downto 0),
        m_axi_bresp             => M_AXI_IN.BRESP,
        m_axi_bvalid            => M_AXI_IN.BVALID,
        m_axi_arready           => M_AXI_IN.ARREADY,
        m_axi_rid               => M_AXI_IN.RID(0 downto 0),
        m_axi_rdata             => M_AXI_IN.RDATA,
        m_axi_rresp             => M_AXI_IN.RRESP,
        m_axi_rlast             => M_AXI_IN.RLAST,
        m_axi_rvalid            => M_AXI_IN.RVALID,
        -- AXI Master Out
        m_axi_awid              => M_AXI_OUT.AWID(0 downto 0),
        m_axi_awaddr            => M_AXI_OUT.AWADDR,
        m_axi_awlen             => M_AXI_OUT.AWLEN,
        m_axi_awsize            => M_AXI_OUT.AWSIZE,
        m_axi_awburst           => M_AXI_OUT.AWBURST,
        m_axi_awlock            => M_AXI_OUT.AWLOCK,
        m_axi_awcache           => M_AXI_OUT.AWCACHE,
        m_axi_awprot            => M_AXI_OUT.AWPROT,
        m_axi_awqos             => M_AXI_OUT.AWQOS,
        m_axi_awvalid           => M_AXI_OUT.AWVALID,
        m_axi_wdata             => M_AXI_OUT.WDATA,
        m_axi_wstrb             => M_AXI_OUT.WSTRB,
        m_axi_wlast             => M_AXI_OUT.WLAST,
        m_axi_wvalid            => M_AXI_OUT.WVALID,
        m_axi_bready            => M_AXI_OUT.BREADY,
        m_axi_arid              => M_AXI_OUT.ARID(0 downto 0),
        m_axi_araddr            => M_AXI_OUT.ARADDR,
        m_axi_arlen             => M_AXI_OUT.ARLEN,
        m_axi_arsize            => M_AXI_OUT.ARSIZE,
        m_axi_arburst           => M_AXI_OUT.ARBURST,
        m_axi_arlock            => M_AXI_OUT.ARLOCK,
        m_axi_arcache           => M_AXI_OUT.ARCACHE,
        m_axi_arprot            => M_AXI_OUT.ARPROT,
        m_axi_arqos             => M_AXI_OUT.ARQOS,
        m_axi_arvalid           => M_AXI_OUT.ARVALID,
        m_axi_rready            => M_AXI_OUT.RREADY
    );

end architecture struct;