library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

package ethernet_types is

    subtype T_ETH_MII_DATA is std_logic_vector(3 downto 0);
    subtype T_ETH_RMII_DATA is std_logic_vector(1 downto 0);

    type T_ETH_MII_PHY_MAC is record
        COL                         : std_logic;
        CRS                         : std_logic;
        RX_DV                       : std_logic;
        RX_CLK                      : std_logic;
        RXD                         : T_ETH_MII_DATA;
        RX_ER                       : std_logic;
        TX_CLK                      : std_logic;
    end record T_ETH_MII_PHY_MAC;

    type T_ETH_MII_MAC_PHY is record
        TXD                         : T_ETH_MII_DATA;
        TX_EN                       : std_logic;
    end record T_ETH_MII_MAC_PHY;

    type T_ETH_RMII_PHY_MAC is record
        CRS_DV                      : std_logic;
        RXD                         : T_ETH_RMII_DATA;
        RX_ER                       : std_logic;
    end record T_ETH_RMII_PHY_MAC;

    type T_ETH_RMII_MAC_PHY is record
        TXD                         : T_ETH_RMII_DATA;
        TX_EN                       : std_logic;
    end record T_ETH_RMII_MAC_PHY;

end ethernet_types;

package body ethernet_types is
end ethernet_types;