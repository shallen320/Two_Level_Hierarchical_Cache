onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_tb/clk
add wave -noupdate -radix hexadecimal /memory_tb/data
add wave -noupdate -radix hexadecimal /memory_tb/addr
add wave -noupdate /memory_tb/rw
add wave -noupdate /memory_tb/ce
add wave -noupdate /memory_tb/RDY
add wave -noupdate -radix hexadecimal /memory_tb/data_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55 ns} 0}
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {130 ns}
