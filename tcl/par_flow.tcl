#-------------------------------------------------------------------------------
# Place & Route Module Flow
#-------------------------------------------------------------------------------
# $URL: http://kyler:18080/svn/nexys4/branches/mb_test/tcl/par_flow.tcl $
# $Date: 2015-03-30 22:06:15 +0100 (Mon, 30 Mar 2015) $
# $Author: rich $
# $Rev: 54 $
#-------------------------------------------------------------------------------
set ws [file normalize $::env(WORKSPACE)]
set top $::env(TOP)
set part $::env(PART)
#################################################
read_edif "$ws/output/$top/$top.edn"
source "$ws/tcl/load_constraints.tcl" -notrace
link_design -part $part -top $top

# Run IP pre-par scripts
foreach {lib} [glob -tails -directory "$ws/ip" -type d *] {
	puts -nonewline "$lib: "
	#source "$ws/ip/$lib/pre_par.tcl" -notrace
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
file copy -force $ws/vivado/vivado.log $ws/output/$top/par.log
