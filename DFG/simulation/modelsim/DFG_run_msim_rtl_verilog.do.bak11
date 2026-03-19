transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/final.v}
vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/dds_phase_acc.v}
vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/freq_decoder.v}
vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/debounce_counter.v}
vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/decade_counter.v}
vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/clk_divider.v}
vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/multiData.v}
vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/amp_adjust.v}

vlog -vlog01compat -work work +incdir+D:/EDA/DigitalFrequencyGenerator {D:/EDA/DigitalFrequencyGenerator/tb_top2.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_top2

add wave *
view structure
view signals
run -all
