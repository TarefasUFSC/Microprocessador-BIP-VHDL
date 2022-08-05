library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CAMINHO_CONTROLE is
	generic(
		p_data_width	: integer := 16;
		p_address_width : integer := 12
	);
	port(
		i_opcode		: IN STD_LOGIC_VECTOR(3 downto 0);
		i_clk			: IN STD_LOGIC;
		i_rst			: IN STD_LOGIC;
		o_address_rom	: OUT STD_LOGIC_VECTOR(p_address_width-1 downto 0);
		o_en_ram		: OUT STD_LOGIC;
		o_wr_ram		: OUT STD_LOGIC;
		o_en_rom		: OUT STD_LOGIC;
		o_wr_acc		: OUT STD_LOGIC;
		o_sel_op1		: OUT STD_LOGIC_VECTOR(1 downto 0);
		o_sel_op2		: OUT STD_LOGIC;
		o_sel_ula		: OUT STD_LOGIC
	);
end CAMINHO_CONTROLE;
ARCHITECTURE behavior of CAMINHO_CONTROLE IS
	signal w_en_pc		: STD_LOGIC;
	component address_counter is
		port(
			i_clk	:	in	std_logic;
			i_rst	:	in	std_logic;
			i_en_pc	:	in	std_logic;
			o_address	:	out	std_logic_vector(p_address_width-1 downto 0)
			
		);
	end component;
	component logica_controle is
		port(
			i_OPCODE: 	in std_logic_vector(3 downto 0);
			o_WR_RAM: 	out std_logic;
			o_EN_RAM: 	out std_logic;
			o_EN_PC: 	out std_logic;
			o_EN_ROM: 	out std_logic;
			o_WR_ACC: 	out std_logic;
			o_SEL_OP1: 	out std_logic_vector(1 downto 0);
			o_SEL_OP2: 	out std_logic;
			o_SEL_ULA: 	out std_logic
	);
	end component;
BEGIN
	add_counter : address_counter
	port map(
		i_clk	=> i_clk,
		i_rst	=> i_rst,
		i_en_pc	=> w_en_pc,
		o_address	=> o_address_rom
	);
	log_controle : logica_controle
	port map(
		i_OPCODE	=> i_opcode,
		o_WR_RAM	=> o_wr_ram,
		o_EN_RAM	=> o_en_ram,
		o_EN_PC		=> w_en_pc,
		o_EN_ROM	=> o_en_rom,
		o_WR_ACC	=> o_wr_acc,
		o_SEL_OP1	=> o_sel_op1,
		o_SEL_OP2	=> o_sel_op2,
		o_SEL_ULA	=> o_sel_ula
	);
END behavior;