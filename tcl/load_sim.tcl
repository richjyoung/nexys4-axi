puts "Simulation Sources:"
foreach {lib} [glob -nocomplain -tails -directory "$ws/sim" -type d *] {
	puts -nonewline "\t$lib: "
	puts [glob -nocomplain -tails -directory "$ws/sim/$lib" "*.vhd"]
	set added [add_files -fileset sim_1 [glob -nocomplain "$ws/sim/$lib/*.vhd"]]
	set_property library $lib $added
	set_property used_in_synthesis false $added
}