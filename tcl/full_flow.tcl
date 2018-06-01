#-------------------------------------------------------------------------------
# Module Flow
#-------------------------------------------------------------------------------
set ws [file normalize $::env(WORKSPACE)]
set top $::env(TOP)
set part $::env(PART)
#################################################
source $ws/tcl/load_src.tcl
source $ws/tcl/load_ip.tcl
source $ws/tcl/load_constraints.tcl
source $ws/tcl/synth_module.tcl

# Run IP pre-par scripts
foreach {lib} [glob -tails -directory "$ws/ip" -type d *] {
	puts -nonewline "$lib: "
	source "$ws/ip/$lib/pre_par.tcl" -notrace
}

opt_design
place_design
write_checkpoint -force "$ws/output/$top/checkpoints/post_place"
route_design
report_timing_summary -file "$ws/output/$top/reports/post_route_timing.rpt"
report_utilization -file "$ws/output/$top/reports/post_route_util.rpt"
report_utilization -hierarchical -file "$ws/output/$top/reports/post_route_util_hier.rpt"
report_drc -file "$ws/output/$top/reports/post_route_drc.rpt"
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
write_bitstream -force -file "$ws/output/$top/$top.bit"
write_checkpoint -force "$ws/output/$top/checkpoints/post_route"

source $ws/tcl/program_module.tcl -notrace
