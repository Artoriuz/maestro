onerror {exit -code 1}
vlib work
vcom -work work riscv_microcontroller.vho
vcom -work work microcontroller.vwf.vht
vsim -novopt -c -t 1ps -L cycloneiv -L altera -L altera_mf -L 220model -L sgate -L altera_lnsim work.microcontroller_vhd_vec_tst
vcd file -direction riscv_microcontroller.msim.vcd
vcd add -internal microcontroller_vhd_vec_tst/*
vcd add -internal microcontroller_vhd_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f
