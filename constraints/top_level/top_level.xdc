## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports CLK100MHZ]
    set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]

##Buttons
##Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
set_property PACKAGE_PIN C12 [get_ports CPU_RESET]
    set_property IOSTANDARD LVCMOS33 [get_ports CPU_RESET]

## LEDs
##Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {LED[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
##Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {LED[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
##Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {LED[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
##Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {LED[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
##Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {LED[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
##Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
set_property PACKAGE_PIN T4 [get_ports {LED[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
##Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {LED[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
##Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {LED[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
##Bank = 34, Pin name = IO_L10N_T1_34,						Sch name = LED8
set_property PACKAGE_PIN V4 [get_ports {LED[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
##Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
set_property PACKAGE_PIN U3 [get_ports {LED[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
##Bank = 34, Pin name = IO_L7N_T1_34,						Sch name = LED10
set_property PACKAGE_PIN V1 [get_ports {LED[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[10]}]
##Bank = 34, Pin name = IO_L17P_T2_34,						Sch name = LED11
set_property PACKAGE_PIN R1 [get_ports {LED[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[11]}]
##Bank = 34, Pin name = IO_L13N_T2_MRCC_34,					Sch name = LED12
set_property PACKAGE_PIN P5 [get_ports {LED[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
##Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
set_property PACKAGE_PIN U1 [get_ports {LED[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
##Bank = 34, Pin name = IO_L15N_T2_DQS_34,					Sch name = LED14
set_property PACKAGE_PIN R2 [get_ports {LED[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[14]}]
##Bank = 34, Pin name = IO_L15P_T2_DQS_34,					Sch name = LED15
set_property PACKAGE_PIN P2 [get_ports {LED[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LED[15]}]

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

##USB-RS232 Interface
##Bank = 35, Pin name = IO_L7P_T1_AD6P_35,					Sch name = UART_TXD_IN
set_property PACKAGE_PIN C4 [get_ports UART_RX]						
	set_property IOSTANDARD LVCMOS33 [get_ports UART_RX]
##Bank = 35, Pin name = IO_L11N_T1_SRCC_35,					Sch name = UART_RXD_OUT
set_property PACKAGE_PIN D4 [get_ports UART_TX]						
	set_property IOSTANDARD LVCMOS33 [get_ports UART_TX]
##Bank = 35, Pin name = IO_L12N_T1_MRCC_35,					Sch name = UART_CTS
#set_property PACKAGE_PIN D3 [get_ports RsCts]						
	#set_property IOSTANDARD LVCMOS33 [get_ports RsCts]
##Bank = 35, Pin name = IO_L5N_T0_AD13N_35,					Sch name = UART_RTS
#set_property PACKAGE_PIN E5 [get_ports RsRts]						
	#set_property IOSTANDARD LVCMOS33 [get_ports RsRts]