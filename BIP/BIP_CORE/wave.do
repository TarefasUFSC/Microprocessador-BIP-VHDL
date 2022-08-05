onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_bip_core/w_clk
add wave -noupdate -radix hexadecimal /tb_bip_core/w_rst
add wave -noupdate -radix hexadecimal /tb_bip_core/w_switches
add wave -noupdate -radix hexadecimal /tb_bip_core/w_address_rom
add wave -noupdate -radix hexadecimal /tb_bip_core/w_address_ram
add wave -noupdate -radix hexadecimal /tb_bip_core/w_din_ram
add wave -noupdate -radix hexadecimal /tb_bip_core/w_dout_ram
add wave -noupdate -radix hexadecimal /tb_bip_core/w_dout_rom
add wave -noupdate -radix hexadecimal /tb_bip_core/w_out_acc
add wave -noupdate -divider {Caminho de Dados}
add wave -noupdate -radix hexadecimal /tb_bip_core/UUT/cam_dados/w_in_ula0
add wave -noupdate -radix hexadecimal /tb_bip_core/UUT/cam_dados/w_in_ula1
add wave -noupdate -radix hexadecimal /tb_bip_core/UUT/cam_dados/w_out_acc
add wave -noupdate -radix hexadecimal /tb_bip_core/UUT/cam_dados/uni_logica_arit/o_Saida
add wave -noupdate -divider {Caminho de Controle}
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/i_OPCODE
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_WR_RAM
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_EN_RAM
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_EN_PC
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_EN_ROM
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_WR_ACC
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_SEL_OP1
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_SEL_OP2
add wave -noupdate /tb_bip_core/UUT/cam_controle/log_controle/o_SEL_ULA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {357844 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 341
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
WaveRestoreZoom {51572 ps} {369772 ps}
