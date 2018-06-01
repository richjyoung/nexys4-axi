puts "IP:"
set_property part $part [current_project]
set_property target_language VHDL [current_project]
set_property simulator_language VHDL [current_project]
foreach {xci} [glob -nocomplain -tails -directory $ws/ip -type f *] {
    set rootname [file rootname $xci]
	puts "\t$rootname"
	file mkdir $ws/ip/${rootname}_generated
	file copy -force $ws/ip/$rootname.xci $ws/ip/${rootname}_generated/$rootname.xci
	read_ip $ws/ip/${rootname}_generated/$rootname.xci

	generate_target all [get_ips $rootname]
	
	set synth_required [get_property generate_synth_checkpoint [get_files $rootname.xci]]
	if ($synth_required) {
		synth_ip [get_ips $rootname]
	}
}
puts ""
