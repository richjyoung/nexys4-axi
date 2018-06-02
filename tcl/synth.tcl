source "tcl/env.tcl"
source "tcl/procs.tcl"

read_vhdl_files
read_constraint_files
set_up_project
read_ip_files

run_ip_synth
run_synth

puts "\[+\] Synthesis completed."
