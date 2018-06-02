library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

package axi_types is

    subtype T_AXI4_ID is std_logic_vector(7 downto 0);
    subtype T_AXI4_LEN is std_logic_vector(7 downto 0);
    subtype T_AXI4_SIZE is std_logic_vector(2 downto 0);
    subtype T_AXI4_BURST is std_logic_vector(1 downto 0);
    subtype T_AXI4_CACHE is std_logic_vector(3 downto 0);
    subtype T_AXI4_PROT is std_logic_vector(2 downto 0);
    subtype T_AXI4_QOS is std_logic_vector(3 downto 0);
    subtype T_AXI4_REGION is std_logic_vector(3 downto 0);
    subtype T_AXI4_RESP is std_logic_vector(1 downto 0);

    type T_AXI4_MASTER_SLAVE is record
        -- Write Address Channel
        AWID                        : T_AXI4_ID;
        AWADDR                      : std_logic_vector;
        AWLEN                       : T_AXI4_LEN;
        AWSIZE                      : T_AXI4_SIZE;
        AWBURST                     : T_AXI4_BURST;
        AWLOCK                      : std_logic;
        AWCACHE                     : T_AXI4_CACHE;
        AWPROT                      : T_AXI4_PROT;
        AWQOS                       : T_AXI4_QOS;
        AWREGION                    : T_AXI4_REGION;
        AWVALID                     : std_logic;
        -- Write Data Channel
        WDATA                       : std_logic_vector;
        WSTRB                       : std_logic_vector;
        WLAST                       : std_logic;
        WVALID                      : std_logic;
        -- Write Response Channel
        BREADY                      : std_logic;
        -- Read Address Channel
        ARID                        : T_AXI4_ID;
        ARADDR                      : std_logic_vector;
        ARLEN                       : T_AXI4_LEN;
        ARSIZE                      : T_AXI4_SIZE;
        ARBURST                     : T_AXI4_BURST;
        ARLOCK                      : std_logic;
        ARCACHE                     : T_AXI4_CACHE;
        ARPROT                      : T_AXI4_PROT;
        ARQOS                       : T_AXI4_QOS;
        ARREGION                    : T_AXI4_REGION;
        ARVALID                     : std_logic;
        -- Read Data Channel
        RREADY                      : std_logic;
    end record T_AXI4_MASTER_SLAVE;

    subtype T_AXI4_MASTER_SLAVE_32x32 is T_AXI4_MASTER_SLAVE(
        AWADDR(31 downto 0),
        WDATA(31 downto 0),
        WSTRB(3 downto 0),
        ARADDR(31 downto 0)
    );

    type T_AXI4_SLAVE_MASTER is record
        -- Write Address Channel
        AWREADY                     : std_logic;
        -- Write Data Channel
        WREADY                      : std_logic;
        -- Write Response Channel
        BID                         : T_AXI4_ID;
        BRESP                       : T_AXI4_RESP;
        BVALID                      : std_logic;
        -- Read Address Channel
        ARREADY                     : std_logic;
        -- Read Data Channel
        RID                         : T_AXI4_ID;
        RDATA                       : std_logic_vector;
        RRESP                       : T_AXI4_RESP;
        RLAST                       : std_logic;
        RVALID                      : std_logic;
    end record T_AXI4_SLAVE_MASTER;

    subtype T_AXI4_SLAVE_MASTER_32x32 is T_AXI4_SLAVE_MASTER(
        RDATA(31 downto 0)
    );


    type T_AXI4LITE_MASTER_SLAVE is record
        -- Write Address Channel
        AWVALID                     : std_logic;
        AWADDR                      : std_logic_vector;
        AWPROT                      : T_AXI4_PROT;
        -- Write Data Channel
        WDATA                       : std_logic_vector;
        WSTRB                       : std_logic_vector;
        WVALID                      : std_logic;
        -- Write Response Channel
        BREADY                      : std_logic;
        -- Read Address Channel
        ARVALID                     : std_logic;
        ARADDR                      : std_logic_vector;
        ARPROT                      : T_AXI4_PROT;
        -- Read Data Channel
        RREADY                      : std_logic;
    end record T_AXI4LITE_MASTER_SLAVE;

    subtype T_AXI4LITE_MASTER_SLAVE_32x32 is T_AXI4LITE_MASTER_SLAVE(
        AWADDR(31 downto 0),
        WDATA(31 downto 0),
        WSTRB(3 downto 0),
        ARADDR(31 downto 0)
    );

    type T_AXI4LITE_SLAVE_MASTER is record
        -- Write Address Channel
        AWREADY                     : std_logic;
        -- Write Data Channel
        WREADY                      : std_logic;
        -- Write Response Channel
        BRESP                       : T_AXI4_RESP;
        BVALID                      : std_logic;
        -- Read Address Channel
        ARREADY                     : std_logic;
        -- Read Data Channel
        RDATA                       : std_logic_vector;
        RRESP                       : T_AXI4_RESP;
        RVALID                      : std_logic;
    end record T_AXI4LITE_SLAVE_MASTER;

    subtype T_AXI4LITE_SLAVE_MASTER_32x32 is T_AXI4LITE_SLAVE_MASTER(
        RDATA(31 downto 0)
    );
end axi_types;

package body axi_types is
end axi_types;