puts "Constraints:"
foreach {module_dir} [glob -nocomplain -tails -directory "$ws/constraints" -type d *] {
	puts -nonewline "\t$module_dir: "
	puts [glob -nocomplain -tails -directory "$ws/constraints/$module_dir" "*.xdc"]
	read_xdc -ref $module_dir [glob -nocomplain "$ws/constraints/$module_dir/*.xdc"]
}
puts ""
