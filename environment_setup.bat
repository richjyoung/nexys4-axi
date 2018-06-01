@echo off
rem ----------------------------------------------------------------------------
rem Environment Setup
rem ----------------------------------------------------------------------------
set WORKSPACE=%cd%
set TOP=top_level
set PART=xc7a100tcsg324-1
set SIM_LIB=NEXYS4_TB
set SIM_TOP=nexys4_top_level_tb

if not exist vivado (
    mkdir vivado
)