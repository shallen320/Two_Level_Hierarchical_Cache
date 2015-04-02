onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cache_l1_tb/clk
add wave -noupdate /cache_l1_tb/reset
add wave -noupdate /cache_l1_tb/ce_cpu
add wave -noupdate /cache_l1_tb/rw_cpu
add wave -noupdate -radix hexadecimal /cache_l1_tb/data_cpu_in
add wave -noupdate -radix hexadecimal /cache_l1_tb/data_cpu_out
add wave -noupdate -radix hexadecimal /cache_l1_tb/addr_cpu
add wave -noupdate /cache_l1_tb/RDY_cpu
add wave -noupdate /cache_l1_tb/CACHE_1/state
add wave -noupdate /cache_l1_tb/RDY_low
add wave -noupdate -radix hexadecimal /cache_l1_tb/addr_low
add wave -noupdate /cache_l1_tb/ce_low
add wave -noupdate /cache_l1_tb/rw_low
add wave -noupdate -radix hexadecimal /cache_l1_tb/data_low_in
add wave -noupdate /cache_l1_tb/data_low_out
add wave -noupdate /cache_l1_tb/pro
add wave -noupdate /cache_l1_tb/snoop_sig
add wave -noupdate /cache_l1_tb/addr_sp_in
add wave -noupdate -radix hexadecimal /cache_l1_tb/addr_sp_out
add wave -noupdate /cache_l1_tb/snoop_req
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {145 ns} 0}
configure wave -namecolwidth 189
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {29 ns} {285 ns}
