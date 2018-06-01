#-------------------------------------------------------------------------------
# Program Module
#-------------------------------------------------------------------------------
# $URL: http://kyler:18080/svn/nexys4/branches/mb_test/tcl/program_module.tcl $
# $Date: 2015-03-29 18:39:13 +0100 (Sun, 29 Mar 2015) $
# $Author: rich $
# $Rev: 35 $
#-------------------------------------------------------------------------------
open_hw
# start_gui
connect_hw_server
set hw_target [lindex [get_hw_targets] 0]
open_hw_target $hw_target
set hw_device [lindex [get_hw_devices] 0]

set_property PROBES.FILE {} $hw_device
set_property PROGRAM.FILE "$ws/output/$top/$top.bit" $hw_device

program_hw_devices $hw_device
refresh_hw_device $hw_device
