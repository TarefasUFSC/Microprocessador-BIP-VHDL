onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_logica_controle/w_OPCODE
add wave -noupdate /tb_logica_controle/w_EN_PC
add wave -noupdate /tb_logica_controle/w_EN_RAM
add wave -noupdate /tb_logica_controle/w_EN_ROM
add wave -noupdate /tb_logica_controle/w_SEL_OP1
add wave -noupdate /tb_logica_controle/w_SEL_OP2
add wave -noupdate /tb_logica_controle/w_SEL_ULA
add wave -noupdate /tb_logica_controle/w_WR_ACC
add wave -noupdate /tb_logica_controle/w_WR_RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6529 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
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
WaveRestoreZoom {0 ps} {102540 ps}
