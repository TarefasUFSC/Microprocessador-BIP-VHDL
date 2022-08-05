onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_caminho_controle/w_address_rom
add wave -noupdate /tb_caminho_controle/w_clk
add wave -noupdate /tb_caminho_controle/w_en_ram
add wave -noupdate /tb_caminho_controle/w_en_rom
add wave -noupdate /tb_caminho_controle/w_opcode
add wave -noupdate /tb_caminho_controle/w_rst
add wave -noupdate /tb_caminho_controle/w_sel_op1
add wave -noupdate /tb_caminho_controle/w_sel_op2
add wave -noupdate /tb_caminho_controle/w_sel_ula
add wave -noupdate /tb_caminho_controle/w_wr_acc
add wave -noupdate /tb_caminho_controle/w_wr_ram
add wave -noupdate /tb_caminho_controle/UUT/w_en_pc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30563 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 274
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {205080 ps}
