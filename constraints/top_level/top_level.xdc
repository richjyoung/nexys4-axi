## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports CLK100MHZ]
    set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]

##Buttons
##Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
set_property PACKAGE_PIN C12 [get_ports CPU_RESET]
    set_property IOSTANDARD LVCMOS33 [get_ports CPU_RESET]

##SMSC Ethernet PHY
##Bank = 16, Pin name = IO_L11P_T1_SRCC_16,					Sch name = ETH_MDC
set_property PACKAGE_PIN C9 [get_ports ETH_PHY_MDC]						
	set_property IOSTANDARD LVCMOS33 [get_ports ETH_PHY_MDC]
##Bank = 16, Pin name = IO_L14N_T2_SRCC_16,					Sch name = ETH_MDIO
set_property PACKAGE_PIN A9 [get_ports ETH_PHY_MDIO]					
	set_property IOSTANDARD LVCMOS33 [get_ports ETH_PHY_MDIO]
##Bank = 35, Pin name = IO_L10P_T1_AD15P_35,					Sch name = ETH_RSTN
set_property PACKAGE_PIN B3 [get_ports ETH_PHY_nRESET]					
	set_property IOSTANDARD LVCMOS33 [get_ports ETH_PHY_nRESET]
##Bank = 16, Pin name = IO_L6N_T0_VREF_16,					Sch name = ETH_CRSDV
set_property PACKAGE_PIN D9 [get_ports ETH_PHY_CRSDV]						
	set_property IOSTANDARD LVCMOS33 [get_ports ETH_PHY_CRSDV]
##Bank = 16, Pin name = IO_L13N_T2_MRCC_16,					Sch name = ETH_RXERR
set_property PACKAGE_PIN C10 [get_ports ETH_PHY_RXERR]					
	set_property IOSTANDARD LVCMOS33 [get_ports ETH_PHY_RXERR]
##Bank = 16, Pin name = IO_L19N_T3_VREF_16,					Sch name = ETH_RXD0
set_property PACKAGE_PIN D10 [get_ports {ETH_PHY_RXD[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {ETH_PHY_RXD[0]}]
##Bank = 16, Pin name = IO_L13P_T2_MRCC_16,					Sch name = ETH_RXD1
set_property PACKAGE_PIN C11 [get_ports {ETH_PHY_RXD[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {ETH_PHY_RXD[1]}]
##Bank = 16, Pin name = IO_L11N_T1_SRCC_16,					Sch name = ETH_TXEN
set_property PACKAGE_PIN B9 [get_ports ETH_PHY_TXEN]					
	set_property IOSTANDARD LVCMOS33 [get_ports ETH_PHY_TXEN]
##Bank = 16, Pin name = IO_L14P_T2_SRCC_16,					Sch name = ETH_TXD0
set_property PACKAGE_PIN A10 [get_ports {ETH_PHY_TXD[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {ETH_PHY_TXD[0]}]
##Bank = 16, Pin name = IO_L12N_T1_MRCC_16,					Sch name = ETH_TXD1
set_property PACKAGE_PIN A8 [get_ports {ETH_PHY_TXD[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {ETH_PHY_TXD[1]}]
##Bank = 35, Pin name = IO_L11P_T1_SRCC_35,					Sch name = ETH_REFCLK
set_property PACKAGE_PIN D5 [get_ports ETH_PHY_CLK]				
	set_property IOSTANDARD LVCMOS33 [get_ports ETH_PHY_CLK]
##Bank = 16, Pin name = IO_L12P_T1_MRCC_16,					Sch name = ETH_INTN
# set_property PACKAGE_PIN B8 [get_ports ETH_INTN]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports ETH_INTN]