@echo off
rem ----------------------------------------------------------------------------
rem Simulate Module
rem ----------------------------------------------------------------------------
call environment_setup
cd vivado
call %XSIM% --gui %SIM_TOP% --view ../sim/%SIM_TOP%.wcfg -t ../sim/%SIM_LIB%/%SIM_TOP%.tcl
cd ..
