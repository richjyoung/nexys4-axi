puts "--------------------------------------------------------------------------------"
puts "Create Simulator Project"
puts "--------------------------------------------------------------------------------"

set prj_file [open "$ws/sim/xsim.prj" "w"]

foreach {lib} [glob -tails -directory "$ws/src" -type d *] {
	foreach {vhdl_file} [glob -tails -directory "$ws/src/$lib" "*.vhd"] {
		puts $prj_file "vhdl $lib $ws/src/$lib/$vhdl_file"
	}
}

#create_fileset -simset sim_srcs
foreach {lib} [glob -tails -directory "$ws/sim" -type d *] {
	foreach {vhdl_file} [glob -tails -directory "$ws/sim/$lib" "*.vhd"] {
		puts $prj_file "vhdl $lib $ws/sim/$lib/$vhdl_file"
	}
}

close $prj_file
puts ""
