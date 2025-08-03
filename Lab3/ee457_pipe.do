# ee457_pipe.do

vlib work
vlog +acc  "./ee457_alu.v"
vlog +acc  "./ee457_fwd.v"
vlog +acc  "./ee457_hdu.v"
vlog +acc  "./ee457_regfile_2r1w.v"
vlog +acc  "./ee457_scpu_cu.v"
vlog +acc  "./ee457_pipe_cpu.v"
vlog +acc  "./ee457_mem.v"
vlog +acc  "./ee457_pipe_cpu_tb.v"

# Redirect output to a transcript file
transcript file ee457_pipe_output.txt

vsim -novopt -t 1ps -lib work ee457_pipe_cpu_tb

do {wave.do}
view wave
view structure
view signals
log -r *

# First simulation run
run 800ns

WaveRestoreZoom {0 ps} {500 ns}