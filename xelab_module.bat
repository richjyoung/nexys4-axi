@echo off
rem ----------------------------------------------------------------------------
rem Compile/Elaborate Module
rem ----------------------------------------------------------------------------
call environment_setup
cd vivado

if exist ../sim/%SIM_TOP%.prj (
    call %XELAB% --incremental --prj ../sim/%SIM_TOP%.prj --snapshot %SIM_TOP% --debug all %SIM_LIB%.%SIM_TOP%
) else (
    call %XELAB% --incremental --prj ../sim/xsim.prj --snapshot %SIM_TOP% --debug all %SIM_LIB%.%SIM_TOP%
)

cd ..
