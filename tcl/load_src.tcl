puts "Source Files:"
foreach {lib} [glob -nocomplain -tails -directory "$ws/src" -type d *] {
	puts -nonewline "\t$lib: "
	puts [glob -nocomplain -tails -directory "$ws/src/$lib" "*.vhd"]
	read_vhdl -library "$lib" [glob -nocomplain "$ws/src/$lib/*.vhd"]
}
