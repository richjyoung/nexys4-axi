@echo off
rem ----------------------------------------------------------------------------
rem Load files into Vivado
rem ----------------------------------------------------------------------------
call environment_setup
cd vivado
call vivado -mode tcl -source ../tcl/load_files.tcl -notrace
cd ..
