library AXI, COMMON, IEEE, xil_defaultlib;
use AXI.axi_types.all;
use COMMON.functions.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use xil_defaultlib.components.all;
--------------------------------------------------------------------------------
architecture struct of axi_crossbar is

        constant C_M                : natural := M_AXI_IN'length;
        constant C_S                : natural := S_AXI_IN'length;

        -- AXI Master In
        signal M_AXI_AWREADY        : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_WREADY         : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_BID            : std_logic_vector(C_M * C_AXI4_ID_W     - 1 downto 0);
        signal M_AXI_BRESP          : std_logic_vector(C_M * C_AXI4_RESP_W   - 1 downto 0);
        signal M_AXI_BVALID         : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_ARREADY        : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_RID            : std_logic_vector(C_M * C_AXI4_ID_W     - 1 downto 0);
        signal M_AXI_RDATA          : std_logic_vector(C_M * 32              - 1 downto 0);
        signal M_AXI_RRESP          : std_logic_vector(C_M * C_AXI4_RESP_W   - 1 downto 0);
        signal M_AXI_RLAST          : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_RVALID         : std_logic_vector(C_M                   - 1 downto 0);
        -- AXI Master Out
        signal M_AXI_AWID           : std_logic_vector(C_M * C_AXI4_ID_W     - 1 downto 0);
        signal M_AXI_AWADDR         : std_logic_vector(C_M * 32              - 1 downto 0);
        signal M_AXI_AWLEN          : std_logic_vector(C_M * C_AXI4_LEN_W    - 1 downto 0);
        signal M_AXI_AWSIZE         : std_logic_vector(C_M * C_AXI4_SIZE_W   - 1 downto 0);
        signal M_AXI_AWBURST        : std_logic_vector(C_M * C_AXI4_BURST_W  - 1 downto 0);
        signal M_AXI_AWLOCK         : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_AWCACHE        : std_logic_vector(C_M * C_AXI4_CACHE_W  - 1 downto 0);
        signal M_AXI_AWPROT         : std_logic_vector(C_M * C_AXI4_PROT_W   - 1 downto 0);
        signal M_AXI_AWREGION       : std_logic_vector(C_M * C_AXI4_REGION_W - 1 downto 0);
        signal M_AXI_AWQOS          : std_logic_vector(C_M * C_AXI4_QOS_W    - 1 downto 0);
        signal M_AXI_AWVALID        : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_WDATA          : std_logic_vector(C_M * 32              - 1 downto 0);
        signal M_AXI_WSTRB          : std_logic_vector(C_M * 4               - 1 downto 0);
        signal M_AXI_WLAST          : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_WVALID         : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_BREADY         : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_ARID           : std_logic_vector(C_M * C_AXI4_ID_W     - 1 downto 0);
        signal M_AXI_ARADDR         : std_logic_vector(C_M * 32              - 1 downto 0);
        signal M_AXI_ARLEN          : std_logic_vector(C_M * C_AXI4_LEN_W    - 1 downto 0);
        signal M_AXI_ARSIZE         : std_logic_vector(C_M * C_AXI4_SIZE_W   - 1 downto 0);
        signal M_AXI_ARBURST        : std_logic_vector(C_M * C_AXI4_BURST_W  - 1 downto 0);
        signal M_AXI_ARLOCK         : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_ARCACHE        : std_logic_vector(C_M * C_AXI4_CACHE_W  - 1 downto 0);
        signal M_AXI_ARPROT         : std_logic_vector(C_M * C_AXI4_PROT_W   - 1 downto 0);
        signal M_AXI_ARREGION       : std_logic_vector(C_M * C_AXI4_REGION_W - 1 downto 0);
        signal M_AXI_ARQOS          : std_logic_vector(C_M * C_AXI4_QOS_W    - 1 downto 0);
        signal M_AXI_ARVALID        : std_logic_vector(C_M                   - 1 downto 0);
        signal M_AXI_RREADY         : std_logic_vector(C_M                   - 1 downto 0);


        -- AXI Slave In
        signal S_AXI_AWID           : std_logic_vector(C_S * C_AXI4_ID_W     - 1 downto 0);
        signal S_AXI_AWADDR         : std_logic_vector(C_S * 32              - 1 downto 0);
        signal S_AXI_AWLEN          : std_logic_vector(C_S * C_AXI4_LEN_W    - 1 downto 0);
        signal S_AXI_AWSIZE         : std_logic_vector(C_S * C_AXI4_SIZE_W   - 1 downto 0);
        signal S_AXI_AWBURST        : std_logic_vector(C_S * C_AXI4_BURST_W  - 1 downto 0);
        signal S_AXI_AWLOCK         : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_AWCACHE        : std_logic_vector(C_S * C_AXI4_CACHE_W  - 1 downto 0);
        signal S_AXI_AWPROT         : std_logic_vector(C_S * C_AXI4_PROT_W   - 1 downto 0);
        signal S_AXI_AWQOS          : std_logic_vector(C_S * C_AXI4_QOS_W    - 1 downto 0);
        signal S_AXI_AWVALID        : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_WDATA          : std_logic_vector(C_S * 32              - 1 downto 0);
        signal S_AXI_WSTRB          : std_logic_vector(C_S * 4               - 1 downto 0);
        signal S_AXI_WLAST          : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_WVALID         : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_BREADY         : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_ARID           : std_logic_vector(C_S * C_AXI4_ID_W     - 1 downto 0);
        signal S_AXI_ARADDR         : std_logic_vector(C_S * 32              - 1 downto 0);
        signal S_AXI_ARLEN          : std_logic_vector(C_S * C_AXI4_LEN_W    - 1 downto 0);
        signal S_AXI_ARSIZE         : std_logic_vector(C_S * C_AXI4_SIZE_W   - 1 downto 0);
        signal S_AXI_ARBURST        : std_logic_vector(C_S * C_AXI4_BURST_W  - 1 downto 0);
        signal S_AXI_ARLOCK         : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_ARCACHE        : std_logic_vector(C_S * C_AXI4_CACHE_W  - 1 downto 0);
        signal S_AXI_ARPROT         : std_logic_vector(C_S * C_AXI4_PROT_W   - 1 downto 0);
        signal S_AXI_ARQOS          : std_logic_vector(C_S * C_AXI4_QOS_W    - 1 downto 0);
        signal S_AXI_ARVALID        : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_RREADY         : std_logic_vector(C_S                   - 1 downto 0);
        -- AXI Slave Out
        signal S_AXI_AWREADY        : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_WREADY         : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_BID            : std_logic_vector(C_S * C_AXI4_ID_W     - 1 downto 0);
        signal S_AXI_BRESP          : std_logic_vector(C_S * C_AXI4_RESP_W   - 1 downto 0);
        signal S_AXI_BVALID         : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_ARREADY        : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_RID            : std_logic_vector(C_S * C_AXI4_ID_W     - 1 downto 0);
        signal S_AXI_RDATA          : std_logic_vector(C_S * 32              - 1 downto 0);
        signal S_AXI_RRESP          : std_logic_vector(C_S * C_AXI4_RESP_W   - 1 downto 0);
        signal S_AXI_RLAST          : std_logic_vector(C_S                   - 1 downto 0);
        signal S_AXI_RVALID         : std_logic_vector(C_S                   - 1 downto 0);
begin

    G_M: for I in 0 to (C_M - 1) generate
        mux(M_AXI_AWREADY, M_AXI_IN(I).AWREADY, I);
        mux(M_AXI_WREADY, M_AXI_IN(I).WREADY, I);
        mux(M_AXI_BID, M_AXI_IN(I).BID, I);
        mux(M_AXI_BRESP, M_AXI_IN(I).BRESP, I);
        mux(M_AXI_BVALID, M_AXI_IN(I).BVALID, I);
        mux(M_AXI_ARREADY, M_AXI_IN(I).ARREADY, I);
        mux(M_AXI_RID, M_AXI_IN(I).RID, I);
        mux(M_AXI_RDATA, M_AXI_IN(I).RDATA, I);
        mux(M_AXI_RRESP, M_AXI_IN(I).RRESP, I);
        mux(M_AXI_RLAST, M_AXI_IN(I).RLAST, I);
        mux(M_AXI_RVALID, M_AXI_IN(I).RVALID, I);

        M_AXI_OUT(I).AWID          <= demux(M_AXI_AWID, I, C_M);
        M_AXI_OUT(I).AWADDR        <= demux(M_AXI_AWADDR, I, C_M);
        M_AXI_OUT(I).AWLEN         <= demux(M_AXI_AWLEN, I, C_M);
        M_AXI_OUT(I).AWSIZE        <= demux(M_AXI_AWSIZE, I, C_M);
        M_AXI_OUT(I).AWBURST       <= demux(M_AXI_AWBURST, I, C_M);
        M_AXI_OUT(I).AWLOCK        <= demux(M_AXI_AWLOCK, I, C_M);
        M_AXI_OUT(I).AWCACHE       <= demux(M_AXI_AWCACHE, I, C_M);
        M_AXI_OUT(I).AWPROT        <= demux(M_AXI_AWPROT, I, C_M);
        M_AXI_OUT(I).AWREGION      <= demux(M_AXI_AWREGION, I, C_M);
        M_AXI_OUT(I).AWQOS         <= demux(M_AXI_AWQOS, I, C_M);
        M_AXI_OUT(I).AWVALID       <= demux(M_AXI_AWVALID, I, C_M);
        M_AXI_OUT(I).WDATA         <= demux(M_AXI_WDATA, I, C_M);
        M_AXI_OUT(I).WSTRB         <= demux(M_AXI_WSTRB, I, C_M);
        M_AXI_OUT(I).WLAST         <= demux(M_AXI_WLAST, I, C_M);
        M_AXI_OUT(I).WVALID        <= demux(M_AXI_WVALID, I, C_M);
        M_AXI_OUT(I).BREADY        <= demux(M_AXI_BREADY, I, C_M);
        M_AXI_OUT(I).ARID          <= demux(M_AXI_ARID, I, C_M);
        M_AXI_OUT(I).ARADDR        <= demux(M_AXI_ARADDR, I, C_M);
        M_AXI_OUT(I).ARLEN         <= demux(M_AXI_ARLEN, I, C_M);
        M_AXI_OUT(I).ARSIZE        <= demux(M_AXI_ARSIZE, I, C_M);
        M_AXI_OUT(I).ARBURST       <= demux(M_AXI_ARBURST, I, C_M);
        M_AXI_OUT(I).ARLOCK        <= demux(M_AXI_ARLOCK, I, C_M);
        M_AXI_OUT(I).ARCACHE       <= demux(M_AXI_ARCACHE, I, C_M);
        M_AXI_OUT(I).ARPROT        <= demux(M_AXI_ARPROT, I, C_M);
        M_AXI_OUT(I).ARREGION      <= demux(M_AXI_ARREGION, I, C_M);
        M_AXI_OUT(I).ARQOS         <= demux(M_AXI_ARQOS, I, C_M);
        M_AXI_OUT(I).ARVALID       <= demux(M_AXI_ARVALID, I, C_M);
        M_AXI_OUT(I).RREADY        <= demux(M_AXI_RREADY, I, C_M);
    end generate G_M;

    G_S: for I in 0 to (C_S - 1) generate
        mux(S_AXI_AWID, S_AXI_IN(I).AWID, I);
        mux(S_AXI_AWADDR, S_AXI_IN(I).AWADDR, I);
        mux(S_AXI_AWLEN, S_AXI_IN(I).AWLEN, I);
        mux(S_AXI_AWSIZE, S_AXI_IN(I).AWSIZE, I);
        mux(S_AXI_AWBURST, S_AXI_IN(I).AWBURST, I);
        mux(S_AXI_AWLOCK, S_AXI_IN(I).AWLOCK, I);
        mux(S_AXI_AWCACHE, S_AXI_IN(I).AWCACHE, I);
        mux(S_AXI_AWPROT, S_AXI_IN(I).AWPROT, I);
        mux(S_AXI_AWQOS, S_AXI_IN(I).AWQOS, I);
        mux(S_AXI_AWVALID, S_AXI_IN(I).AWVALID, I);
        mux(S_AXI_WDATA, S_AXI_IN(I).WDATA, I);
        mux(S_AXI_WSTRB, S_AXI_IN(I).WSTRB, I);
        mux(S_AXI_WLAST, S_AXI_IN(I).WLAST, I);
        mux(S_AXI_WVALID, S_AXI_IN(I).WVALID, I);
        mux(S_AXI_BREADY, S_AXI_IN(I).BREADY, I);
        mux(S_AXI_ARID, S_AXI_IN(I).ARID, I);
        mux(S_AXI_ARADDR, S_AXI_IN(I).ARADDR, I);
        mux(S_AXI_ARLEN, S_AXI_IN(I).ARLEN, I);
        mux(S_AXI_ARSIZE, S_AXI_IN(I).ARSIZE, I);
        mux(S_AXI_ARBURST, S_AXI_IN(I).ARBURST, I);
        mux(S_AXI_ARLOCK, S_AXI_IN(I).ARLOCK, I);
        mux(S_AXI_ARCACHE, S_AXI_IN(I).ARCACHE, I);
        mux(S_AXI_ARPROT, S_AXI_IN(I).ARPROT, I);
        mux(S_AXI_ARQOS, S_AXI_IN(I).ARQOS, I);
        mux(S_AXI_ARVALID, S_AXI_IN(I).ARVALID, I);
        mux(S_AXI_RREADY, S_AXI_IN(I).RREADY, I);

        S_AXI_OUT(I).AWREADY        <= demux(S_AXI_AWREADY, I, C_S);
        S_AXI_OUT(I).WREADY         <= demux(S_AXI_WREADY, I, C_S);
        S_AXI_OUT(I).BID            <= demux(S_AXI_BID, I, C_S);
        S_AXI_OUT(I).BRESP          <= demux(S_AXI_BRESP, I, C_S);
        S_AXI_OUT(I).BVALID         <= demux(S_AXI_BVALID, I, C_S);
        S_AXI_OUT(I).ARREADY        <= demux(S_AXI_ARREADY, I, C_S);
        S_AXI_OUT(I).RID            <= demux(S_AXI_RID, I, C_S);
        S_AXI_OUT(I).RDATA          <= demux(S_AXI_RDATA, I, C_S);
        S_AXI_OUT(I).RRESP          <= demux(S_AXI_RRESP, I, C_S);
        S_AXI_OUT(I).RLAST          <= demux(S_AXI_RLAST, I, C_S);
        S_AXI_OUT(I).RVALID         <= demux(S_AXI_RVALID, I, C_S);
    end generate G_S;

    U_XBAR : axi_crossbar_2x3_32x32
    port map (
        aclk => CLK,
        aresetn => nRESET,
        s_axi_awid => S_AXI_AWID,
        s_axi_awaddr => S_AXI_AWADDR,
        s_axi_awlen => S_AXI_AWLEN,
        s_axi_awsize => S_AXI_AWSIZE,
        s_axi_awburst => S_AXI_AWBURST,
        s_axi_awlock => S_AXI_AWLOCK,
        s_axi_awcache => S_AXI_AWCACHE,
        s_axi_awprot => S_AXI_AWPROT,
        s_axi_awqos => S_AXI_AWQOS,
        s_axi_awvalid => S_AXI_AWVALID,
        s_axi_awready => S_AXI_AWREADY,
        s_axi_wdata => S_AXI_WDATA,
        s_axi_wstrb => S_AXI_WSTRB,
        s_axi_wlast => S_AXI_WLAST,
        s_axi_wvalid => S_AXI_WVALID,
        s_axi_wready => S_AXI_WREADY,
        s_axi_bid => S_AXI_BID,
        s_axi_bresp => S_AXI_BRESP,
        s_axi_bvalid => S_AXI_BVALID,
        s_axi_bready => S_AXI_BREADY,
        s_axi_arid => S_AXI_ARID,
        s_axi_araddr => S_AXI_ARADDR,
        s_axi_arlen => S_AXI_ARLEN,
        s_axi_arsize => S_AXI_ARSIZE,
        s_axi_arburst => S_AXI_ARBURST,
        s_axi_arlock => S_AXI_ARLOCK,
        s_axi_arcache => S_AXI_ARCACHE,
        s_axi_arprot => S_AXI_ARPROT,
        s_axi_arqos => S_AXI_ARQOS,
        s_axi_arvalid => S_AXI_ARVALID,
        s_axi_arready => S_AXI_ARREADY,
        s_axi_rid => S_AXI_RID,
        s_axi_rdata => S_AXI_RDATA,
        s_axi_rresp => S_AXI_RRESP,
        s_axi_rlast => S_AXI_RLAST,
        s_axi_rvalid => S_AXI_RVALID,
        s_axi_rready => S_AXI_RREADY,
        m_axi_awid => M_AXI_AWID,
        m_axi_awaddr => M_AXI_AWADDR,
        m_axi_awlen => M_AXI_AWLEN,
        m_axi_awsize => M_AXI_AWSIZE,
        m_axi_awburst => M_AXI_AWBURST,
        m_axi_awlock => M_AXI_AWLOCK,
        m_axi_awcache => M_AXI_AWCACHE,
        m_axi_awprot => M_AXI_AWPROT,
        m_axi_awregion => M_AXI_AWREGION,
        m_axi_awqos => M_AXI_AWQOS,
        m_axi_awvalid => M_AXI_AWVALID,
        m_axi_awready => M_AXI_AWREADY,
        m_axi_wdata => M_AXI_WDATA,
        m_axi_wstrb => M_AXI_WSTRB,
        m_axi_wlast => M_AXI_WLAST,
        m_axi_wvalid => M_AXI_WVALID,
        m_axi_wready => M_AXI_WREADY,
        m_axi_bid => M_AXI_BID,
        m_axi_bresp => M_AXI_BRESP,
        m_axi_bvalid => M_AXI_BVALID,
        m_axi_bready => M_AXI_BREADY,
        m_axi_arid => M_AXI_ARID,
        m_axi_araddr => M_AXI_ARADDR,
        m_axi_arlen => M_AXI_ARLEN,
        m_axi_arsize => M_AXI_ARSIZE,
        m_axi_arburst => M_AXI_ARBURST,
        m_axi_arlock => M_AXI_ARLOCK,
        m_axi_arcache => M_AXI_ARCACHE,
        m_axi_arprot => M_AXI_ARPROT,
        m_axi_arregion => M_AXI_ARREGION,
        m_axi_arqos => M_AXI_ARQOS,
        m_axi_arvalid => M_AXI_ARVALID,
        m_axi_arready => M_AXI_ARREADY,
        m_axi_rid => M_AXI_RID,
        m_axi_rdata => M_AXI_RDATA,
        m_axi_rresp => M_AXI_RRESP,
        m_axi_rlast => M_AXI_RLAST,
        m_axi_rvalid => M_AXI_RVALID,
        m_axi_rready => M_AXI_RREADY
    );

end architecture struct;