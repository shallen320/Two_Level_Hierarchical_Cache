onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /L1_L2_mem_tb/clk_L1
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/addr_cpu_0
add wave -noupdate /L1_L2_mem_tb/CA_L1_0/state
add wave -noupdate /L1_L2_mem_tb/CA_L1_0/sp_state
add wave -noupdate /L1_L2_mem_tb/data_cpu_in_0
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_cpu_out_0
add wave -noupdate /L1_L2_mem_tb/rw_cpu_0
add wave -noupdate /L1_L2_mem_tb/ce_cpu_0
add wave -noupdate /L1_L2_mem_tb/RDY_cpu_0
add wave -noupdate /L1_L2_mem_tb/CA_L1_0/snoop_sig
add wave -noupdate /L1_L2_mem_tb/CA_L1_0/snoop_req
add wave -noupdate /L1_L2_mem_tb/CA_L1_1/sp_state
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/addr_cpu_1
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_cpu_in_1
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_cpu_out_1
add wave -noupdate /L1_L2_mem_tb/rw_cpu_1
add wave -noupdate /L1_L2_mem_tb/ce_cpu_1
add wave -noupdate /L1_L2_mem_tb/RDY_cpu_1
add wave -noupdate /L1_L2_mem_tb/CA_L1_1/snoop_req
add wave -noupdate /L1_L2_mem_tb/addr_cpu_2
add wave -noupdate /L1_L2_mem_tb/data_cpu_in_2
add wave -noupdate /L1_L2_mem_tb/data_cpu_out_2
add wave -noupdate /L1_L2_mem_tb/rw_cpu_2
add wave -noupdate /L1_L2_mem_tb/ce_cpu_2
add wave -noupdate /L1_L2_mem_tb/RDY_cpu_2
add wave -noupdate /L1_L2_mem_tb/CA_L1_2/state
add wave -noupdate /L1_L2_mem_tb/CA_L1_2/sp_state
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/CA_L1_2/addr_sp_in
add wave -noupdate /L1_L2_mem_tb/CA_L1_2/snoop_sig
add wave -noupdate /L1_L2_mem_tb/CA_L1_2/snoop_req
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/CA_L1_2/data_low_out
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/addr_cpu_3
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_cpu_in_3
add wave -noupdate /L1_L2_mem_tb/data_cpu_out_3
add wave -noupdate /L1_L2_mem_tb/rw_cpu_3
add wave -noupdate /L1_L2_mem_tb/ce_cpu_3
add wave -noupdate /L1_L2_mem_tb/RDY_cpu_3
add wave -noupdate /L1_L2_mem_tb/CA_L1_3/sp_state
add wave -noupdate /L1_L2_mem_tb/CA_L1_3/snoop_req
add wave -noupdate /L1_L2_mem_tb/CA_L1_3/state
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/addr_l1_3
add wave -noupdate /L1_L2_mem_tb/data_l1_out_3
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_l1_in_3
add wave -noupdate /L1_L2_mem_tb/rw_l1_3
add wave -noupdate /L1_L2_mem_tb/ce_l1_3
add wave -noupdate /L1_L2_mem_tb/RDY_l1_3
add wave -noupdate /L1_L2_mem_tb/pro_l1_3
add wave -noupdate /L1_L2_mem_tb/clk_L2
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/addr_hig_1
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_hig_1
add wave -noupdate /L1_L2_mem_tb/rw_hig_1
add wave -noupdate /L1_L2_mem_tb/ce_hig_1
add wave -noupdate /L1_L2_mem_tb/RDY_hig_1
add wave -noupdate /L1_L2_mem_tb/CA_L2_1/state
add wave -noupdate {/L1_L2_mem_tb/CA_L2_1/C2/tag[10152]}
add wave -noupdate /L1_L2_mem_tb/CA_L2_1/sp_state
add wave -noupdate /L1_L2_mem_tb/CA_L2_1/snoop_sig
add wave -noupdate /L1_L2_mem_tb/CA_L2_1/snoop_req
add wave -noupdate -radix hexadecimal -childformat {{{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[23]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[22]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[21]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[20]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[19]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[18]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[17]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[16]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[15]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[14]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[13]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[12]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[11]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[10]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[9]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[8]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[7]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[6]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[5]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[4]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[3]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[2]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[1]} -radix hexadecimal} {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[0]} -radix hexadecimal}} -subitemconfig {{/L1_L2_mem_tb/CA_L2_1/addr_sp_in[23]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[22]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[21]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[20]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[19]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[18]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[17]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[16]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[15]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[14]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[13]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[12]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[11]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[10]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[9]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[8]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[7]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[6]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[5]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[4]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[3]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[2]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[1]} {-height 15 -radix hexadecimal} {/L1_L2_mem_tb/CA_L2_1/addr_sp_in[0]} {-height 15 -radix hexadecimal}} /L1_L2_mem_tb/CA_L2_1/addr_sp_in
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/addr_hig_2
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_hig_2
add wave -noupdate /L1_L2_mem_tb/ce_hig_2
add wave -noupdate /L1_L2_mem_tb/rw_hig_2
add wave -noupdate /L1_L2_mem_tb/CA_L2_2/state
add wave -noupdate /L1_L2_mem_tb/CA_L2_2/sp_state
add wave -noupdate /L1_L2_mem_tb/CA_L2_2/snoop_sig
add wave -noupdate {/L1_L2_mem_tb/CA_L2_2/C2/tag[10152]}
add wave -noupdate /L1_L2_mem_tb/CA_L2_2/snoop_req
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/CA_L2_2/addr_sp_out
add wave -noupdate /L1_L2_mem_tb/CA_L2_2/RDY_low
add wave -noupdate /L1_L2_mem_tb/CA_L2_2/ce_low
add wave -noupdate /L1_L2_mem_tb/RDY_hig_2
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/CA_L2_2/data_low_in
add wave -noupdate /L1_L2_mem_tb/CA_L2_2/rep_set
add wave -noupdate /L1_L2_mem_tb/clk_arbi
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/data_in_1
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/data_out_1
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/addr_1
add wave -noupdate /L1_L2_mem_tb/ARBI2/rw_1
add wave -noupdate /L1_L2_mem_tb/ARBI2/ce_1
add wave -noupdate /L1_L2_mem_tb/ARBI2/pro_1
add wave -noupdate /L1_L2_mem_tb/ARBI2/RDY_1
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/data_in_2
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/data_out_2
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/addr_2
add wave -noupdate /L1_L2_mem_tb/ARBI2/rw_2
add wave -noupdate /L1_L2_mem_tb/ARBI2/ce_2
add wave -noupdate /L1_L2_mem_tb/ARBI2/pro_2
add wave -noupdate /L1_L2_mem_tb/ARBI2/RDY_2
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/addr_que
add wave -noupdate /L1_L2_mem_tb/ARBI2/rw_que
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/data_que
add wave -noupdate /L1_L2_mem_tb/ARBI2/id
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/data_low
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/ARBI2/addr_low
add wave -noupdate /L1_L2_mem_tb/ARBI2/rw_low
add wave -noupdate /L1_L2_mem_tb/ARBI2/RDY_low
add wave -noupdate /L1_L2_mem_tb/ARBI2/ce_low
add wave -noupdate /L1_L2_mem_tb/clk_mem
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/addr_mem
add wave -noupdate -radix hexadecimal /L1_L2_mem_tb/data_mem
add wave -noupdate /L1_L2_mem_tb/rw_mem
add wave -noupdate /L1_L2_mem_tb/ce_mem
add wave -noupdate /L1_L2_mem_tb/RDY_mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {566 ns} 0}
configure wave -namecolwidth 165
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
WaveRestoreZoom {0 ns} {512 ns}
