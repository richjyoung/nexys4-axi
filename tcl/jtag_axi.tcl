proc rd_rx_ping_ctrl {} {
    create_hw_axi_txn rd_txn [get_hw_axis hw_axi_1] -address 000017fc -len 1 -type read -verbose -force
    run_hw_axi rd_txn -verbose
    return [get_property DATA [get_hw_axi_txns rd_txn]]
}

proc rd_rx_ping_eth_hdr {} {
    create_hw_axi_txn rd_txn [get_hw_axis hw_axi_1] -address 00001000 -len 4 -type read -quiet -force
    run_hw_axi rd_txn
    return [get_property DATA [get_hw_axi_txns rd_txn]]
}

proc print_eth_hdr {} {
    set raw [rd_rx_ping_eth_hdr]
    set dest_mac [string range $raw 30 31]
    append dest_mac ":" [string range $raw 28 29]
    append dest_mac ":" [string range $raw 26 27]
    append dest_mac ":" [string range $raw 24 25]
    append dest_mac ":" [string range $raw 22 23]
    append dest_mac ":" [string range $raw 20 21]
    puts "Dest MAC:  $dest_mac"
    set src_mac [string range $raw 18 19]
    append src_mac ":" [string range $raw 16 17]
    append src_mac ":" [string range $raw 14 15]
    append src_mac ":" [string range $raw 12 13]
    append src_mac ":" [string range $raw 10 11]
    append src_mac ":" [string range $raw 8 9]
    puts "Src MAC:   $src_mac"
    set ethertype [string range $raw 6 7]
    append ethertype [string range $raw 4 5]
    puts "Ethertype: $ethertype"
    set ipver [string range $raw 2 2]
    puts "IP Ver:    $ipver"
    set iplen [string range $raw 3 3]
    puts "IP Length: $iplen"
}

proc rd_uart_rx {} {
    create_hw_axi_txn rd_txn [get_hw_axis hw_axi_1] -address 00100000 -len 4 -type read -quiet -force
    run_hw_axi rd_txn
    return [get_property DATA [get_hw_axi_txns rd_txn]]
}

proc rd_uart_rx_stat {} {
    create_hw_axi_txn rd_txn [get_hw_axis hw_axi_1] -address 00100008 -len 1 -type read -quiet -force
    run_hw_axi rd_txn
    return [get_property DATA [get_hw_axi_txns rd_txn]]
}

proc wr_uart_tx_a {} {
    create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00100004 -len 1 -data 00000041 -type write -quiet -force
    run_hw_axi wr_txn
}

proc rd_cdma_stat {} {
    create_hw_axi_txn rd_txn [get_hw_axis hw_axi_1] -address 00200004 -len 1 -type read -quiet -force
    run_hw_axi rd_txn
    return [get_property DATA [get_hw_axi_txns rd_txn]]
}

print_eth_hdr