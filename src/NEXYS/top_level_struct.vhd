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

    -- Crossbar Mapping
    -- M00          12      0x00000000      CDMA (Ctrl)
    -- M01          13      0x00100000      Ethernet
    -- M02          12      0x00200000      UART
    -- S00                                  CDMA (DMA)
    -- S01                                  JTAG

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

    -- CDMA DMA to Crossbar
    signal CDMA_DMA_XBAR        : T_AXI4_MASTER_SLAVE_32x32;
    signal XBAR_CDMA_DMA        : T_AXI4_SLAVE_MASTER_32x32;

    -- Crossbar Busses
    signal XBAR_S_AXI_IN        : T_AXI4_MASTER_SLAVE_32x32_ARRAY(1 downto 0);
    signal XBAR_S_AXI_OUT       : T_AXI4_SLAVE_MASTER_32x32_ARRAY(1 downto 0);
    signal XBAR_M_AXI_IN        : T_AXI4_SLAVE_MASTER_32x32_ARRAY(2 downto 0);
    signal XBAR_M_AXI_OUT       : T_AXI4_MASTER_SLAVE_32x32_ARRAY(2 downto 0);

    -- Crossbar to CDMA (Ctrl)
    signal XBAR_CDMA_CTRL       : T_AXI4_MASTER_SLAVE_32x32;
    signal CDMA_CTRL_XBAR       : T_AXI4_SLAVE_MASTER_32x32;

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
    XBAR_M_AXI_IN(2)            <= CDMA_CTRL_XBAR;
    XBAR_ETH                    <= XBAR_M_AXI_OUT(0);
    XBAR_UART                   <= XBAR_M_AXI_OUT(1);
    XBAR_CDMA_CTRL              <= XBAR_M_AXI_OUT(2);

    XBAR_S_AXI_IN(1)            <= JTAG_XBAR;
    XBAR_S_AXI_IN(0)            <= CDMA_DMA_XBAR;
    XBAR_JTAG                   <= XBAR_S_AXI_OUT(1);
    XBAR_CDMA_DMA               <= XBAR_S_AXI_OUT(0);
    
    LED(0)                      <= ETH_PHY_nRESET_INT;
    LED(1)                      <= ETH_MAC_IRQ;
    LED(2)                      <= UART_IRQ;
    LED(15 downto 3)            <= (others => '0');

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

    U_CDMA : axi_cdma
    port map (
        CLK                     => CLK,
        nRESET                  => nRESET,
        CDMA_IRQ                => open,
        CDMA_TVECT              => open,
        M_AXI_IN                => XBAR_CDMA_DMA,
        M_AXI_OUT               => CDMA_DMA_XBAR,
        S_AXI_IN                => XBAR_CDMA_CTRL,
        S_AXI_OUT               => CDMA_CTRL_XBAR
    );

    U_JTAG : axi_jtag
    port map (
        CLK                     => CLK,
        nRESET                  => nRESET,
        -- AXI Master
        M_AXI_IN                => XBAR_JTAG,
        M_AXI_OUT               => JTAG_XBAR
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
        ETH_PHY_nRESET          => ETH_PHY_nRESET_INT,
        ETH_MAC_IRQ             => ETH_MAC_IRQ,
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
