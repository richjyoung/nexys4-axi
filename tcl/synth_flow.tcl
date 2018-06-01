#-------------------------------------------------------------------------------
# Synthesise Module Flow
#-------------------------------------------------------------------------------
# $URL: http://kyler:18080/svn/nexys4/branches/mb_test/tcl/synth_flow.tcl $
# $Date: 2015-03-30 22:06:15 +0100 (Mon, 30 Mar 2015) $
# $Author: rich $
# $Rev: 54 $
#-------------------------------------------------------------------------------
set ws [file normalize $::env(WORKSPACE)]
set top $::env(TOP)
set part $::env(PART)
#################################################
source $ws/tcl/load_src.tcl
source $ws/tcl/load_ip.tcl
source $ws/tcl/load_constraints.tcl
source $ws/tcl/synth_module.tcl
file copy -force $ws/vivado/vivado.log $ws/output/$top/synth.log
