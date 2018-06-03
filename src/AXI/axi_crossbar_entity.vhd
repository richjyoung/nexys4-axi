library AXI, IEEE, xil_defaultlib;
use AXI.axi_types.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--------------------------------------------------------------------------------
entity axi_crossbar is
    port (
        -- Clock & Reset
        CLK                 : in  std_logic;
        nRESET              : in  std_logic;
        -- AXI Slave Interface
        S_AXI_IN            : in  T_AXI4_MASTER_SLAVE_32x32_ARRAY(0 downto 0);
        S_AXI_OUT           : out T_AXI4_SLAVE_MASTER_32x32_ARRAY(0 downto 0);
        -- AXI Master Interfaces
        M_AXI_IN            : in  T_AXI4_SLAVE_MASTER_32x32_ARRAY(1 downto 0);
        M_AXI_OUT           : out T_AXI4_MASTER_SLAVE_32x32_ARRAY(1 downto 0)
    );
end axi_crossbar;