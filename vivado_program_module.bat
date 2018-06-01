@echo off
rem ----------------------------------------------------------------------------
rem Synthesise Module
rem ----------------------------------------------------------------------------
call environment_setup
cd vivado
call vivado -mode tcl -source ../tcl/program_flow.tcl -notrace
cd ..
