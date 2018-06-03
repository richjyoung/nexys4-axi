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
    signal ETH_PHY_nRESET_INT   : std_logic;

    -- RMII Converter/PHY Interface Signals
    signal RMII_PHY             : T_ETH_RMII_MAC_PHY;
    signal PHY_RMII             : T_ETH_RMII_PHY_MAC;

    -- JTAG to Crossbar
    signal JTAG_XBAR            : T_AXI4_MASTER_SLAVE_32x32;
    signal XBAR_JTAG            : T_AXI4_SLAVE_MASTER_32x32;

    -- Crossbar Busses
    signal XBAR_M_AXI_IN        : T_AXI4_SLAVE_MASTER_32x32_ARRAY(1 downto 0);
    signal XBAR_M_AXI_OUT       : T_AXI4_MASTER_SLAVE_32x32_ARRAY(1 downto 0);
    signal XBAR_S_AXI_IN        : T_AXI4_MASTER_SLAVE_32x32_ARRAY(0 downto 0);
    signal XBAR_S_AXI_OUT       : T_AXI4_SLAVE_MASTER_32x32_ARRAY(0 downto 0);

    -- Crossbar to Ethernet
    signal XBAR_ETH             : T_AXI4_MASTER_SLAVE_32x32;
    signal ETH_XBAR             : T_AXI4_SLAVE_MASTER_32x32;

    -- Crossbar to UART
    signal XBAR_UART            : T_AXI4_MASTER_SLAVE_32x32;
    signal UART_XBAR            : T_AXI4_SLAVE_MASTER_32x32;

    -- Interrupts
    signal UART_IRQ             : std_logic;
    signal ETH_MAC_IRQ          : std_logic;

begin

    XBAR_M_AXI_IN(0)            <= ETH_XBAR;
    XBAR_M_AXI_IN(1)            <= UART_XBAR;
    XBAR_S_AXI_IN(0)            <= JTAG_XBAR;
    XBAR_ETH                    <= XBAR_M_AXI_OUT(0);
    XBAR_UART                   <= XBAR_M_AXI_OUT(1);
    XBAR_JTAG                   <= XBAR_S_AXI_OUT(0);

    LED(0)                      <= ETH_PHY_nRESET_INT;
    LED(1)                      <= ETH_MAC_IRQ;
    LED(2)                      <= UART_IRQ;
    LED(15 downto 3)            <= (others => '0');

    JTAG_XBAR.AWREGION          <= (others => '0');
    JTAG_XBAR.ARREGION          <= (others => '0');

    ETH_PHY_TXD                 <= RMII_PHY.TXD;
    ETH_PHY_TXEN                <= RMII_PHY.TX_EN;
    PHY_RMII.CRS_DV             <= ETH_PHY_CRSDV;
    PHY_RMII.RXD                <= ETH_PHY_RXD;
    PHY_RMII.RX_ER              <= ETH_PHY_RXERR;
    ETH_PHY_nRESET              <= ETH_PHY_nRESET_INT;

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
        m_axi_awready           => XBAR_JTAG.AWREADY,
        m_axi_wready            => XBAR_JTAG.WREADY,
        m_axi_bid               => "0",
        m_axi_bresp             => XBAR_JTAG.BRESP,
        m_axi_bvalid            => XBAR_JTAG.BVALID,
        m_axi_arready           => XBAR_JTAG.ARREADY,
        m_axi_rid               => "0",
        m_axi_rdata             => XBAR_JTAG.RDATA,
        m_axi_rresp             => XBAR_JTAG.RRESP,
        m_axi_rlast             => XBAR_JTAG.RLAST,
        m_axi_rvalid            => XBAR_JTAG.RVALID,
        -- AXI Master Out
        m_axi_awid              => JTAG_XBAR.AWID(0 downto 0),
        m_axi_awaddr            => JTAG_XBAR.AWADDR,
        m_axi_awlen             => JTAG_XBAR.AWLEN,
        m_axi_awsize            => JTAG_XBAR.AWSIZE,
        m_axi_awburst           => JTAG_XBAR.AWBURST,
        m_axi_awlock            => JTAG_XBAR.AWLOCK,
        m_axi_awcache           => JTAG_XBAR.AWCACHE,
        m_axi_awprot            => JTAG_XBAR.AWPROT,
        m_axi_awqos             => JTAG_XBAR.AWQOS,
        m_axi_awvalid           => JTAG_XBAR.AWVALID,
        m_axi_wdata             => JTAG_XBAR.WDATA,
        m_axi_wstrb             => JTAG_XBAR.WSTRB,
        m_axi_wlast             => JTAG_XBAR.WLAST,
        m_axi_wvalid            => JTAG_XBAR.WVALID,
        m_axi_bready            => JTAG_XBAR.BREADY,
        m_axi_arid              => JTAG_XBAR.ARID(0 downto 0),
        m_axi_araddr            => JTAG_XBAR.ARADDR,
        m_axi_arlen             => JTAG_XBAR.ARLEN,
        m_axi_arsize            => JTAG_XBAR.ARSIZE,
        m_axi_arburst           => JTAG_XBAR.ARBURST,
        m_axi_arlock            => JTAG_XBAR.ARLOCK,
        m_axi_arcache           => JTAG_XBAR.ARCACHE,
        m_axi_arprot            => JTAG_XBAR.ARPROT,
        m_axi_arqos             => JTAG_XBAR.ARQOS,
        m_axi_arvalid           => JTAG_XBAR.ARVALID,
        m_axi_rready            => JTAG_XBAR.RREADY
    );

    U_XBAR: axi_crossbar
    port map (
        CLK                     => CLK,
        nRESET                  => nRESET,
        S_AXI_IN                => XBAR_S_AXI_IN,
        S_AXI_OUT               => XBAR_S_AXI_OUT,
        M_AXI_IN                => XBAR_M_AXI_IN,
        M_AXI_OUT               => XBAR_M_AXI_OUT
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
        S_AXI_IN                => XBAR_ETH,
        S_AXI_OUT               => ETH_XBAR
    );

    U_UART: axi_uart
    port map (
        CLK                     => CLK,
        nRESET                  => nRESET,
        UART_IRQ                => UART_IRQ,
        UART_RX                 => UART_RX,
        UART_TX                 => UART_TX,
        S_AXI_IN                => XBAR_UART,
        S_AXI_OUT               => UART_XBAR
    );
end struct;
--------------------------------------------------------------------------------
