library AXI, ETHERNET, IEEE, xil_defaultlib;
use AXI.axi_types.all;
use ETHERNET.ethernet_types.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--------------------------------------------------------------------------------
entity axi_cdma is
    port (
        -- Clock & Reset
        CLK                 : in  std_logic;
        nRESET              : in  std_logic;
        -- Interrupt
        CDMA_IRQ            : out std_logic;
        -- AXI Master Interface
        M_AXI_IN            : in  T_AXI4_SLAVE_MASTER_32x32;
        M_AXI_OUT           : out T_AXI4_MASTER_SLAVE_32x32;
        -- AXI Slave Interface
        S_AXI_IN            : in  T_AXI4_MASTER_SLAVE_32x32;
        S_AXI_OUT           : out T_AXI4_SLAVE_MASTER_32x32;
        -- CDMA
        CDMA_TVECT          : out std_logic_vector(31 downto 0)
    );
end axi_cdma;