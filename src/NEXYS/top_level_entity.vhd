library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--------------------------------------------------------------------------------
entity top_level is
    port (
        -- Clock & Reset
        CLK100MHZ           : in    std_logic;
        CPU_RESET           : in    std_logic;

        -- Ethernet MDIO
        ETH_PHY_MDC         : out   std_logic;
        ETH_PHY_MDIO        : inout std_logic;

        -- Ethernet RMII
        ETH_PHY_CRSDV       : in    std_logic;
        ETH_PHY_RXERR       : in    std_logic;
        ETH_PHY_RXD         : in    std_logic_vector(1 downto 0);
        ETH_PHY_CLK         : out   std_logic;
        ETH_PHY_nRESET      : out   std_logic;
        ETH_PHY_TXD         : out   std_logic_vector(1 downto 0);
        ETH_PHY_TXEN        : out   std_logic
    );
end top_level;