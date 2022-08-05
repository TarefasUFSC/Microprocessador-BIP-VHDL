library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BIP_CORE is
	generic(
		p_address_width : integer := 12;
		p_data_width : integer := 16
	);
	port(
		i_dout_rom : in std_logic_vector(p_data_width-1 downto 0);
		i_dout_ram : in std_logic_vector(p_data_width-1 downto 0);
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_switches : in std_logic_vector(p_address_width-1 downto 0);
		o_address_rom : out std_logic_vector(p_address_width-1 downto 0);
		o_address_ram : out std_logic_vector(p_address_width-1 downto 0);
		o_din_ram: out std_logic_vector(p_data_width-1 downto 0);
		o_wr_ram			: out std_logic;
		o_en_rom			: out std_logic;
		o_en_ram			: out std_logic;
		o_out_acc : out std_logic_vector(p_data_width-1 downto 0)
	);
end BIP_CORE;
ARCHITECTURE behavior of BIP_CORE IS
	signal w_opcode		:  STD_LOGIC_VECTOR(3 downto 0);
	signal w_clk			:  STD_LOGIC;
	signal w_rst			:  STD_LOGIC;
	signal w_address_rom	:  STD_LOGIC_VECTOR(p_address_width-1 downto 0);
	signal w_address_ram	:  STD_LOGIC_VECTOR(p_address_width-1 downto 0);
	signal w_en_ram		:  STD_LOGIC;
	signal w_wr_ram		:  STD_LOGIC;
	signal w_en_rom		:  STD_LOGIC;
	signal w_wr_acc		:  STD_LOGIC;
	signal w_sel_op1		:  STD_LOGIC_VECTOR(1 downto 0);
	signal w_sel_op2		:  STD_LOGIC;
	signal w_sel_ula 	:  STD_LOGIC;
	component CAMINHO_CONTROLE is
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
	end component;
	component CAMINHO_DADOS is 
	port(
		i_switches		: in std_logic_vector((p_address_width-1) downto 0);
		i_wr_acc			: in std_logic ;
		i_sel_op1		: in std_logic_vector(1 downto 0) ;
		i_sel_op2		: in std_logic ;
		i_sel_ula		: in std_logic ;
		i_dout_rom		: in std_logic_vector((p_data_width-1)downto 0) ;
		i_dout_ram		: in std_logic_vector((p_data_width-1)downto 0) ;
		i_clk				: in std_logic ;
		i_rst				: in std_logic ;
		o_opcode			: out std_logic_vector(3 downto 0);
		o_address_ram	: out std_logic_vector((p_address_width-1) downto 0);
		o_din_ram		: out std_logic_vector((p_data_width-1) downto 0);
		o_out_acc		: OUT STD_LOGIC_VECTOR(p_data_width-1 downto 0)

	);
	end component;
BEGIN
	o_address_rom <= w_address_rom;
	o_address_ram <= w_address_ram;
	o_wr_ram <= w_wr_ram;
	o_en_rom <= w_en_rom;
	o_en_ram <= w_en_ram;
	cam_controle: CAMINHO_CONTROLE
	port map(
			i_opcode		=>w_opcode ,
			i_clk			=>i_clk ,
			i_rst			=>i_rst ,
			o_address_rom	=>w_address_rom ,
			o_en_ram		=>w_en_ram ,
			o_wr_ram		=>w_wr_ram ,
			o_en_rom		=>w_en_rom ,
			o_wr_acc		=>w_wr_acc ,
			o_sel_op1		=>w_sel_op1 ,
			o_sel_op2		=>w_sel_op2 ,
			o_sel_ula		=>w_sel_ula
	);

	cam_dados: CAMINHO_DADOS
	port map(
		i_switches		=>i_switches,
		i_wr_acc			=>w_wr_acc,
		i_sel_op1		=>w_sel_op1, 
		i_sel_op2		=>w_sel_op2,
		i_sel_ula		=>w_sel_ula,
		i_dout_rom		=>i_dout_rom, 
		i_dout_ram		=>i_dout_ram, 
		i_clk				=>i_clk,
		i_rst				=>i_rst,
		o_opcode			=>w_opcode,
		o_address_ram	=>w_address_ram,
		o_din_ram		=>o_din_ram,
		o_out_acc		=>o_out_acc

	);
END behavior;