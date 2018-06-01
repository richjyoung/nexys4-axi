set ws [file normalize $::env(WORKSPACE)]
source "$ws/tcl/env.tcl" -notrace
source "$ws/tcl/load_src.tcl" -notrace
source "$ws/tcl/load_constraints.tcl" -notrace
source "$ws/tcl/load_ip.tcl"
source "$ws/tcl/load_sim.tcl" -notrace
set_property source_mgmt_mode All [current_project]

#start_gui
