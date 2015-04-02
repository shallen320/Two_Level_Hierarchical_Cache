onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /arbiter_tb/clk
add wave -noupdate -radix hexadecimal /arbiter_tb/data_in_1
add wave -noupdate -radix hexadecimal /arbiter_tb/data_out_1
add wave -noupdate -radix hexadecimal /arbiter_tb/addr_1
add wave -noupdate /arbiter_tb/rw_1
add wave -noupdate /arbiter_tb/RDY_1
add wave -noupdate /arbiter_tb/ce_1
add wave -noupdate /arbiter_tb/pro_1
add wave -noupdate -radix hexadecimal /arbiter_tb/data_in_2
add wave -noupdate -radix hexadecimal /arbiter_tb/data_out_2
add wave -noupdate -radix hexadecimal /arbiter_tb/addr_2
add wave -noupdate /arbiter_tb/rw_2
add wave -noupdate /arbiter_tb/ce_2
add wave -noupdate /arbiter_tb/RDY_2
add wave -noupdate /arbiter_tb/pro_2
add wave -noupdate -radix hexadecimal /arbiter_tb/addr_low
add wave -noupdate -radix hexadecimal /arbiter_tb/data_low
add wave -noupdate /arbiter_tb/rw_low
add wave -noupdate /arbiter_tb/ce_low
add wave -noupdate /arbiter_tb/RDY_low
add wave -noupdate -radix hexadecimal /arbiter_tb/DUT/addr_que
add wave -noupdate /arbiter_tb/DUT/rw_que
add wave -noupdate -radix hexadecimal -childformat {{{/arbiter_tb/DUT/data_que[3]} -radix hexadecimal} {{/arbiter_tb/DUT/data_que[2]} -radix hexadecimal} {{/arbiter_tb/DUT/data_que[1]} -radix hexadecimal} {{/arbiter_tb/DUT/data_que[0]} -radix hexadecimal}} -subitemconfig {{/arbiter_tb/DUT/data_que[3]} {-radix hexadecimal} {/arbiter_tb/DUT/data_que[2]} {-radix hexadecimal} {/arbiter_tb/DUT/data_que[1]} {-radix hexadecimal} {/arbiter_tb/DUT/data_que[0]} {-radix hexadecimal}} /arbiter_tb/DUT/data_que
add wave -noupdate /arbiter_tb/DUT/id
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {193 ns} 0}
configure wave -namecolwidth 167
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
WaveRestoreZoom {88 ns} {216 ns}
