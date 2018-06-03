library AXI, ETHERNET, IEEE, UNISIM, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use UNISIM.VCOMPONENTS.all;
use xil_defaultlib.components.all;
--------------------------------------------------------------------------------
architecture struct of axi_uart is

    -- AXI Converter to UART
    signal CONV_UART            : T_AXI4LITE_MASTER_SLAVE_32x32;
    signal UART_CONV            : T_AXI4LITE_SLAVE_MASTER_32x32;

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
        m_axi_awready           => UART_CONV.AWREADY,
        m_axi_wready            => UART_CONV.WREADY,
        m_axi_bresp             => UART_CONV.BRESP,
        m_axi_bvalid            => UART_CONV.BVALID,
        m_axi_arready           => UART_CONV.ARREADY,
        m_axi_rdata             => UART_CONV.RDATA,
        m_axi_rresp             => UART_CONV.RRESP,
        m_axi_rvalid            => UART_CONV.RVALID,
        -- Master AXILITE Out
        m_axi_awaddr            => CONV_UART.AWADDR,
        m_axi_awprot            => CONV_UART.AWPROT,
        m_axi_awvalid           => CONV_UART.AWVALID,
        m_axi_wdata             => CONV_UART.WDATA,
        m_axi_wstrb             => CONV_UART.WSTRB,
        m_axi_wvalid            => CONV_UART.WVALID,
        m_axi_bready            => CONV_UART.BREADY,
        m_axi_araddr            => CONV_UART.ARADDR,
        m_axi_arprot            => CONV_UART.ARPROT,
        m_axi_arvalid           => CONV_UART.ARVALID,
        m_axi_rready            => CONV_UART.RREADY
    );

    U_UART : axi_uartlite_115200_8_n_1
    PORT MAP (
        s_axi_aclk              => CLK,
        s_axi_aresetn           => nRESET,

        -- Slave AXILITE In
        s_axi_awaddr            => CONV_UART.AWADDR(3 downto 0),
        s_axi_awvalid           => CONV_UART.AWVALID,
        s_axi_wdata             => CONV_UART.WDATA,
        s_axi_wstrb             => CONV_UART.WSTRB,
        s_axi_wvalid            => CONV_UART.WVALID,
        s_axi_bready            => CONV_UART.BREADY,
        s_axi_arvalid           => CONV_UART.ARVALID,
        s_axi_araddr            => CONV_UART.ARADDR(3 downto 0),
        s_axi_rready            => CONV_UART.RREADY,
        -- Slave AXILITE Out
        s_axi_awready           => UART_CONV.AWREADY,
        s_axi_wready            => UART_CONV.WREADY,
        s_axi_bresp             => UART_CONV.BRESP,
        s_axi_bvalid            => UART_CONV.BVALID,
        s_axi_arready           => UART_CONV.ARREADY,
        s_axi_rdata             => UART_CONV.RDATA,
        s_axi_rresp             => UART_CONV.RRESP,
        s_axi_rvalid            => UART_CONV.RVALID,

        -- UART
        interrupt               => UART_IRQ,
        rx                      => UART_RX,
        tx                      => UART_TX
    );

end architecture struct;