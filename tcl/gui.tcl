source "tcl/env.tcl"
source "tcl/procs.tcl"

start_gui
read_vhdl_files
read_constraint_files
set_up_project
read_ip_files
read_sim_files

puts "\[+\] Project load completed."
