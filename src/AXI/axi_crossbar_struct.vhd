library AXI, COMMON, IEEE, xil_defaultlib;
use AXI.axi_types.all;
use COMMON.functions.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use xil_defaultlib.components.all;
--------------------------------------------------------------------------------
architecture struct of axi_crossbar is

        -- AXI Master In
        signal M_AXI_AWREADY        : std_logic_vector(1 downto 0);
        signal M_AXI_WREADY         : std_logic_vector(1 downto 0);
        signal M_AXI_BRESP          : std_logic_vector(3 downto 0);
        signal M_AXI_BVALID         : std_logic_vector(1 downto 0);
        signal M_AXI_ARREADY        : std_logic_vector(1 downto 0);
        signal M_AXI_RDATA          : std_logic_vector(63 downto 0);
        signal M_AXI_RRESP          : std_logic_vector(3 downto 0);
        signal M_AXI_RLAST          : std_logic_vector(1 downto 0);
        signal M_AXI_RVALID         : std_logic_vector(1 downto 0);
        -- AXI Master Out
        signal M_AXI_AWADDR         : std_logic_vector(63 downto 0);
        signal M_AXI_AWLEN          : std_logic_vector(15 downto 0);
        signal M_AXI_AWSIZE         : std_logic_vector(5 downto 0);
        signal M_AXI_AWBURST        : std_logic_vector(3 downto 0);
        signal M_AXI_AWLOCK         : std_logic_vector(1 downto 0);
        signal M_AXI_AWCACHE        : std_logic_vector(7 downto 0);
        signal M_AXI_AWPROT         : std_logic_vector(5 downto 0);
        signal M_AXI_AWREGION       : std_logic_vector(7 downto 0);
        signal M_AXI_AWQOS          : std_logic_vector(7 downto 0);
        signal M_AXI_AWVALID        : std_logic_vector(1 downto 0);
        signal M_AXI_WDATA          : std_logic_vector(63 downto 0);
        signal M_AXI_WSTRB          : std_logic_vector(7 downto 0);
        signal M_AXI_WLAST          : std_logic_vector(1 downto 0);
        signal M_AXI_WVALID         : std_logic_vector(1 downto 0);
        signal M_AXI_BREADY         : std_logic_vector(1 downto 0);
        signal M_AXI_ARADDR         : std_logic_vector(63 downto 0);
        signal M_AXI_ARLEN          : std_logic_vector(15 downto 0);
        signal M_AXI_ARSIZE         : std_logic_vector(5 downto 0);
        signal M_AXI_ARBURST        : std_logic_vector(3 downto 0);
        signal M_AXI_ARLOCK         : std_logic_vector(1 downto 0);
        signal M_AXI_ARCACHE        : std_logic_vector(7 downto 0);
        signal M_AXI_ARPROT         : std_logic_vector(5 downto 0);
        signal M_AXI_ARREGION       : std_logic_vector(7 downto 0);
        signal M_AXI_ARQOS          : std_logic_vector(7 downto 0);
        signal M_AXI_ARVALID        : std_logic_vector(1 downto 0);
        signal M_AXI_RREADY         : std_logic_vector(1 downto 0);

begin

    -- Multiplex input signals
    M_AXI_AWREADY                   <= M_AXI_IN(1).AWREADY  & M_AXI_IN(0).AWREADY;
    M_AXI_WREADY                    <= M_AXI_IN(1).WREADY   & M_AXI_IN(0).WREADY;
    M_AXI_BRESP                     <= M_AXI_IN(1).BRESP    & M_AXI_IN(0).BRESP;
    M_AXI_BVALID                    <= M_AXI_IN(1).BVALID   & M_AXI_IN(0).BVALID;
    M_AXI_ARREADY                   <= M_AXI_IN(1).ARREADY  & M_AXI_IN(0).ARREADY;
    M_AXI_RDATA                     <= M_AXI_IN(1).RDATA    & M_AXI_IN(0).RDATA;
    M_AXI_RRESP                     <= M_AXI_IN(1).RRESP    & M_AXI_IN(0).RRESP;
    M_AXI_RLAST                     <= M_AXI_IN(1).RLAST    & M_AXI_IN(0).RLAST;
    M_AXI_RVALID                    <= M_AXI_IN(1).RVALID   & M_AXI_IN(0).RVALID;

    -- Demultiplex signals for output
    G_DEMUX: for I in 0 to (M_AXI_OUT'length - 1) generate
        M_AXI_OUT(I).AWADDR         <= demux(M_AXI_AWADDR, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWLEN          <= demux(M_AXI_AWLEN, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWSIZE         <= demux(M_AXI_AWSIZE, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWBURST        <= demux(M_AXI_AWBURST, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWLOCK         <= demux(M_AXI_AWLOCK, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWCACHE        <= demux(M_AXI_AWCACHE, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWPROT         <= demux(M_AXI_AWPROT, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWREGION       <= demux(M_AXI_AWREGION, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWQOS          <= demux(M_AXI_AWQOS, I, M_AXI_OUT'length);
        M_AXI_OUT(I).AWVALID        <= demux(M_AXI_AWVALID, I, M_AXI_OUT'length);
        M_AXI_OUT(I).WDATA          <= demux(M_AXI_WDATA, I, M_AXI_OUT'length);
        M_AXI_OUT(I).WSTRB          <= demux(M_AXI_WSTRB, I, M_AXI_OUT'length);
        M_AXI_OUT(I).WLAST          <= demux(M_AXI_WLAST, I, M_AXI_OUT'length);
        M_AXI_OUT(I).WVALID         <= demux(M_AXI_WVALID, I, M_AXI_OUT'length);
        M_AXI_OUT(I).BREADY         <= demux(M_AXI_BREADY, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARADDR         <= demux(M_AXI_ARADDR, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARLEN          <= demux(M_AXI_ARLEN, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARSIZE         <= demux(M_AXI_ARSIZE, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARBURST        <= demux(M_AXI_ARBURST, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARLOCK         <= demux(M_AXI_ARLOCK, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARCACHE        <= demux(M_AXI_ARCACHE, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARPROT         <= demux(M_AXI_ARPROT, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARREGION       <= demux(M_AXI_ARREGION, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARQOS          <= demux(M_AXI_ARQOS, I, M_AXI_OUT'length);
        M_AXI_OUT(I).ARVALID        <= demux(M_AXI_ARVALID, I, M_AXI_OUT'length);
        M_AXI_OUT(I).RREADY         <= demux(M_AXI_RREADY, I, M_AXI_OUT'length);
    end generate G_DEMUX;

    U_CROSSBAR : axi_crossbar_1x2_32x32
    PORT MAP (
        aclk                => CLK,
        aresetn             => nRESET,

        -- AXI Slave In
        s_axi_awaddr        => S_AXI_IN.AWADDR,
        s_axi_awlen         => S_AXI_IN.AWLEN,
        s_axi_awsize        => S_AXI_IN.AWSIZE,
        s_axi_awburst       => S_AXI_IN.AWBURST,
        s_axi_awlock(0)     => S_AXI_IN.AWLOCK,
        s_axi_awcache       => S_AXI_IN.AWCACHE,
        s_axi_awprot        => S_AXI_IN.AWPROT,
        s_axi_awqos         => S_AXI_IN.AWQOS,
        s_axi_awvalid(0)    => S_AXI_IN.AWVALID,
        s_axi_wdata         => S_AXI_IN.WDATA,
        s_axi_wstrb         => S_AXI_IN.WSTRB,
        s_axi_wlast(0)      => S_AXI_IN.WLAST,
        s_axi_wvalid(0)     => S_AXI_IN.WVALID,
        s_axi_bready(0)     => S_AXI_IN.BREADY,
        s_axi_araddr        => S_AXI_IN.ARADDR,
        s_axi_arlen         => S_AXI_IN.ARLEN,
        s_axi_arsize        => S_AXI_IN.ARSIZE,
        s_axi_arburst       => S_AXI_IN.ARBURST,
        s_axi_arlock(0)     => S_AXI_IN.ARLOCK,
        s_axi_arcache       => S_AXI_IN.ARCACHE,
        s_axi_arprot        => S_AXI_IN.ARPROT,
        s_axi_arqos         => S_AXI_IN.ARQOS,
        s_axi_arvalid(0)    => S_AXI_IN.ARVALID,
        s_axi_rready(0)     => S_AXI_IN.RREADY,
        -- AXI Slave Out
        s_axi_awready(0)    => S_AXI_OUT.AWREADY,
        s_axi_wready(0)     => S_AXI_OUT.WREADY,
        s_axi_bresp         => S_AXI_OUT.BRESP,
        s_axi_bvalid(0)     => S_AXI_OUT.BVALID,
        s_axi_arready(0)    => S_AXI_OUT.ARREADY,
        s_axi_rdata         => S_AXI_OUT.RDATA,
        s_axi_rresp         => S_AXI_OUT.RRESP,
        s_axi_rlast(0)      => S_AXI_OUT.RLAST,
        s_axi_rvalid(0)     => S_AXI_OUT.RVALID,

        -- AXI Master In
        m_axi_awready       => M_AXI_AWREADY,
        m_axi_wready        => M_AXI_WREADY,
        m_axi_bresp         => M_AXI_BRESP,
        m_axi_bvalid        => M_AXI_BVALID,
        m_axi_arready       => M_AXI_ARREADY,
        m_axi_rdata         => M_AXI_RDATA,
        m_axi_rresp         => M_AXI_RRESP,
        m_axi_rlast         => M_AXI_RLAST,
        m_axi_rvalid        => M_AXI_RVALID,
        -- AXI Master Out
        m_axi_awaddr        => M_AXI_AWADDR,
        m_axi_awlen         => M_AXI_AWLEN,
        m_axi_awsize        => M_AXI_AWSIZE,
        m_axi_awburst       => M_AXI_AWBURST,
        m_axi_awlock        => M_AXI_AWLOCK,
        m_axi_awcache       => M_AXI_AWCACHE,
        m_axi_awprot        => M_AXI_AWPROT,
        m_axi_awregion      => M_AXI_AWREGION,
        m_axi_awqos         => M_AXI_AWQOS,
        m_axi_awvalid       => M_AXI_AWVALID,
        m_axi_wdata         => M_AXI_WDATA,
        m_axi_wstrb         => M_AXI_WSTRB,
        m_axi_wlast         => M_AXI_WLAST,
        m_axi_wvalid        => M_AXI_WVALID,
        m_axi_bready        => M_AXI_BREADY,
        m_axi_araddr        => M_AXI_ARADDR,
        m_axi_arlen         => M_AXI_ARLEN,
        m_axi_arsize        => M_AXI_ARSIZE,
        m_axi_arburst       => M_AXI_ARBURST,
        m_axi_arlock        => M_AXI_ARLOCK,
        m_axi_arcache       => M_AXI_ARCACHE,
        m_axi_arprot        => M_AXI_ARPROT,
        m_axi_arregion      => M_AXI_ARREGION,
        m_axi_arqos         => M_AXI_ARQOS,
        m_axi_arvalid       => M_AXI_ARVALID,
        m_axi_rready        => M_AXI_RREADY
    );

end architecture struct;