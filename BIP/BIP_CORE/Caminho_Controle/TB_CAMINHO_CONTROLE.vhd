library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_CAMINHO_CONTROLE is
	generic(
		p_data_width	: integer := 16;
		p_address_width : integer := 12
	);
end TB_CAMINHO_CONTROLE;

architecture behavioral of TB_CAMINHO_CONTROLE is

	component CAMINHO_CONTROLE is
		-- mesmos ports do coponente (só copiar do entity)
			
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
	
	-- cria um signal w_x pra cada port
	signal w_opcode		: STD_LOGIC_VECTOR(3 downto 0);
	signal w_clk			: STD_LOGIC;
	signal w_rst			: STD_LOGIC;
	signal w_address_rom	: STD_LOGIC_VECTOR(p_address_width-1 downto 0);
	signal w_en_ram		: STD_LOGIC;
	signal w_wr_ram		: STD_LOGIC;
	signal w_en_rom		: STD_LOGIC;
	signal w_wr_acc		: STD_LOGIC;
	signal w_sel_op1		: STD_LOGIC_VECTOR(1 downto 0);
	signal w_sel_op2		: STD_LOGIC;
	signal w_sel_ula		: STD_LOGIC;
	
begin

	UUT: CAMINHO_CONTROLE
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_opcode		=> w_opcode,
		i_clk			=> w_clk,
		i_rst			=> w_rst, 
		o_address_rom	=> w_address_rom, 
		o_en_ram		=> w_en_ram, 
		o_wr_ram		=> w_wr_ram, 
		o_en_rom		=> w_en_rom, 
		o_wr_acc		=> w_wr_acc, 
		o_sel_op1		=> w_sel_op1, 
		o_sel_op2		=> w_sel_op2, 
		o_sel_ula		=> w_sel_ula
	);
	

-- Sinais
	-- clock
	process
	begin
		w_clk <= '0';
		wait for 10 NS;
		w_clk <= '1';
		wait for 10 NS;
	end process;

	-- reset
	process
	begin
		w_rst <= '1';
		wait for 20 NS;
		w_rst <= '0';
		wait;
	end process;
	

-- teste XX
	process
	begin
		-- colocar os sinais aqui
		w_opcode <= (others => '0');
		wait for 20 NS;
		w_opcode <= "0001";
		wait for 20 NS;
		w_opcode <= "0010";
		wait for 20 NS;
		w_opcode <= "0011";
		wait for 20 NS;
		w_opcode <= "0100";
		wait for 20 NS;
		w_opcode <= "0101";
		wait for 20 NS;
		w_opcode <= "0110";
		wait for 20 NS;
		w_opcode <= "0111";
		wait for 20 NS;
		w_opcode <= "1000";
		wait for 20 NS;

		
		wait;
		
	end process;
end behavioral;