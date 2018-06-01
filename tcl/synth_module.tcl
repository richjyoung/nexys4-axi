puts "--------------------------------------------------"
puts "Synthesize $top"
puts "--------------------------------------------------"

file mkdir "$ws/output"
file mkdir "$ws/output/$top"
file mkdir "$ws/output/$top/reports"
file mkdir "$ws/output/$top/checkpoints"

write_hwdef -force -file "$ws/output/$top/$top.hdf"
set_property top $top [current_fileset]
update_compile_order
synth_design -top $top -part $part -fsm_extraction auto -resource_sharing on
write_edif -force "$ws/output/$top/$top.edn"
report_utilization -file "$ws/output/$top/reports/post_synth_util.rpt"
report_utilization -hierarchical -file "$ws/output/$top/reports/post_synth_util_hier.rpt"
report_timing -file "$ws/output/$top/reports/post_synth_timing.rpt"
report_drc -file "$ws/output/$top/reports/post_synth_drc.rpt"
write_checkpoint -force "$ws/output/$top/checkpoints/post_synth"
puts "--------------------------------------------------"
