set ws [file normalize $::env(WORKSPACE)]
set top $::env(TOP)
set part $::env(PART)
set sim_lib $::env(SIM_LIB)
set sim_top $::env(SIM_TOP)
puts "Workspace:  $ws"
puts "Top Module: $top"
puts "Part:       $part"
puts "Sim Lib:    $sim_lib"
puts "Sim Top:    $sim_top"