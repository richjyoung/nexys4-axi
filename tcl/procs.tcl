proc get_src_libraries_list {} {
    return [glob -nocomplain -tails -directory "$::root/src" -type d *]
}

proc get_sim_libraries_list {} {
    return [glob -nocomplain -tails -directory "$::root/sim" -type d *]
}

proc read_vhdl_files {} {
    set libs [get_src_libraries_list]
    foreach {lib} $libs {
        puts -nonewline "\[+\] Library $lib: "
        puts [glob -nocomplain -tails -directory "$::root/src/$lib" "*.vhd"]
        read_vhdl -library "$lib" [glob -nocomplain "$::root/src/$lib/*.vhd"]
    }
}

proc read_sim_files {} {
    set libs [get_sim_libraries_list]
    foreach {lib} $libs {
        puts -nonewline "\[+\] Library $lib: "
        puts [glob -nocomplain -tails -directory "$::root/sim/$lib" "*.vhd"]
        set added [add_files -fileset sim_1 [glob -nocomplain "$::root/sim/$lib/*.vhd"]]
        set_property library $lib $added
        set_property used_in_synthesis false $added
    }
}

proc read_constraint_files {} {
    foreach {module} [glob -nocomplain -tails -directory "$::root/constraints" -type d *] {
        puts -nonewline "\[+\] Constraint $module: "
        puts [glob -nocomplain -tails -directory "$::root/constraints/$module" "*.xdc"]
        read_xdc -ref $module [glob -nocomplain "$::root/constraints/$module/*.xdc"]
    }
}

proc read_edif_file {} {
    read_edif "$::root/output/$::top/$::top.edn"
}

proc set_up_project {} {
    set_property part $::part [current_project]
    set_property target_language VHDL [current_project]
    set_property simulator_language VHDL [current_project]
    set_property source_mgmt_mode All [current_project]
}

proc read_ip_files {} {
    foreach {xci} [glob -nocomplain -tails -directory "$::root/ip" -type f *] {
        set module [file rootname $xci]
        puts "\[+\] IP: $module"
        file mkdir $::root/ip/${module}_generated
        file copy -force $::root/ip/$module.xci $::root/ip/${module}_generated/$module.xci
        read_ip $::root/ip/${module}_generated/$module.xci
        generate_target all [get_ips $module]
    }
}

proc run_ip_synth {} {
    foreach {module} [get_ips] {
        set synth_required [get_property generate_synth_checkpoint [get_files $module.xci]]
        if ($synth_required) {
            synth_ip $module
        }
    }
}

proc run_synth {} {
    file mkdir "$::root/output"
    file mkdir "$::root/output/$::top"
    file mkdir "$::root/output/$::top/reports"
    file mkdir "$::root/output/$::top/checkpoints"

    write_hwdef -force -file "$::root/output/$::top/$::top.hdf"
    set_property top $::top [current_fileset]
    update_compile_order
    synth_design -top $::top -part $::part -fsm_extraction auto -resource_sharing on
    write_edif -force "$::root/output/$::top/$::top.edn"
    report_utilization -file "$::root/output/$::top/reports/post_synth_util.rpt"
    report_utilization -hierarchical -file "$::root/output/$::top/reports/post_synth_util_hier.rpt"
    report_timing -file "$::root/output/$::top/reports/post_synth_timing.rpt"
    report_drc -file "$::root/output/$::top/reports/post_synth_drc.rpt"
    write_checkpoint -force "$::root/output/$::top/checkpoints/post_synth"
    file copy -force $::root/vivado.log $::root/output/$::top/synth.log
}

proc run_link {} {
    link_design -part $::part -top $::top
}

proc run_par {} {
    opt_design
    place_design
    write_checkpoint -force "$::root/output/$::top/checkpoints/post_place"
    route_design
    report_timing_summary -file "$::root/output/$::top/reports/post_route_timing.rpt"
    report_utilization -file "$::root/output/$::top/reports/post_route_util.rpt"
    report_utilization -hierarchical -file "$::root/output/$::top/reports/post_route_util_hier.rpt"
    report_drc -file "$::root/output/$::top/reports/post_route_drc.rpt"
    set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
    set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
    write_bitstream -force -file "$::root/output/$::top/$::top.bit"
    write_checkpoint -force "$::root/output/$::top/checkpoints/post_route"
    file copy -force $::root/vivado.log $::root/output/$::top/par.log
}

proc run_program {} {
    open_hw
    connect_hw_server
    set hw_target [lindex [get_hw_targets] 0]
    open_hw_target $hw_target
    set hw_device [lindex [get_hw_devices] 0]

    set_property PROBES.FILE {} $hw_device
    set_property PROGRAM.FILE "$::root/output/$::top/$::top.bit" $hw_device

    program_hw_devices $hw_device
    refresh_hw_device $hw_device
}