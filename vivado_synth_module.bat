@echo off
rem ----------------------------------------------------------------------------
rem Synthesise Module
rem ----------------------------------------------------------------------------
call environment_setup
cd vivado
call vivado -mode tcl -source ../tcl/synth_flow.tcl -notrace
cd ..
