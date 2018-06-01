@echo off
rem ----------------------------------------------------------------------------
rem Place & Route Module
rem ----------------------------------------------------------------------------
call environment_setup
cd vivado
call vivado -mode tcl -source ../tcl/par_flow.tcl -notrace
cd ..
