onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /L2_arbi_mem_tb/clk_cache
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/addr_hig_1
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/data_hig_1
add wave -noupdate /L2_arbi_mem_tb/rw_hig_1
add wave -noupdate /L2_arbi_mem_tb/ce_hig_1
add wave -noupdate /L2_arbi_mem_tb/RDY_hig_1
add wave -noupdate /L2_arbi_mem_tb/CA_L2_1/rep_set
add wave -noupdate /L2_arbi_mem_tb/CA_L2_1/state
add wave -noupdate /L2_arbi_mem_tb/snoop_2
add wave -noupdate {/L2_arbi_mem_tb/CA_L2_2/C0/tag[0]}
add wave -noupdate /L2_arbi_mem_tb/CA_L2_2/rep_set
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/addr_hig_2
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/data_hig_2
add wave -noupdate /L2_arbi_mem_tb/rw_hig_2
add wave -noupdate /L2_arbi_mem_tb/ce_hig_2
add wave -noupdate /L2_arbi_mem_tb/RDY_hig_2
add wave -noupdate /L2_arbi_mem_tb/snoop_1
add wave -noupdate /L2_arbi_mem_tb/CA_L2_2/sp_state
add wave -noupdate /L2_arbi_mem_tb/CA_L2_2/state
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/addr_sp_1
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/addr_sp_2
add wave -noupdate /L2_arbi_mem_tb/clk_arbi
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/addr_arbi_1
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/data_arbi_out_1
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/data_arbi_in_1
add wave -noupdate /L2_arbi_mem_tb/rw_arbi_1
add wave -noupdate /L2_arbi_mem_tb/ce_arbi_1
add wave -noupdate /L2_arbi_mem_tb/pro_1
add wave -noupdate /L2_arbi_mem_tb/RDY_arbi_1
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/addr_arbi_2
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/data_arbi_out_2
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/data_arbi_in_2
add wave -noupdate /L2_arbi_mem_tb/rw_arbi_2
add wave -noupdate /L2_arbi_mem_tb/ce_arbi_2
add wave -noupdate /L2_arbi_mem_tb/RDY_arbi_2
add wave -noupdate /L2_arbi_mem_tb/pro_2
add wave -noupdate /L2_arbi_mem_tb/clk_mem
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/data_mem
add wave -noupdate -radix hexadecimal /L2_arbi_mem_tb/addr_mem
add wave -noupdate /L2_arbi_mem_tb/rw_mem
add wave -noupdate /L2_arbi_mem_tb/RDY_mem
add wave -noupdate /L2_arbi_mem_tb/ce_mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {428 ns} 0}
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
WaveRestoreZoom {286 ns} {552 ns}
