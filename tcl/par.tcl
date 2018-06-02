source "tcl/env.tcl"
source "tcl/procs.tcl"

read_edif_file
read_constraint_files
run_link
run_par

puts "\[+\] Place and Route completed."
