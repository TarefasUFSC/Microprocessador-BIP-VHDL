library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CAMINHO_DADOS is
	generic(
		p_data_width	: integer := 16;
		p_address_width : integer := 12
	);
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
		o_out_acc		:out std_logic_vector((p_data_width-1) downto 0)
	);
end CAMINHO_DADOS;
ARCHITECTURE behavior of CAMINHO_DADOS IS
	signal w_out_ula				: std_logic_vector((p_data_width-1) downto 0) ;
	signal w_in_ula0				: std_logic_vector((p_data_width-1) downto 0) ;
	signal w_in_ula1				: std_logic_vector((p_data_width-1) downto 0) ;
	signal w_expanded_out_ir	: std_logic_vector((p_data_width-1) downto 0);
	signal w_expanded_switches	: std_logic_vector((p_data_width-1) downto 0);
	signal w_in_acc				: std_logic_vector((p_data_width-1) downto 0);
	signal w_out_acc				: std_logic_vector((p_data_width-1) downto 0);
	signal w_address_ram			: std_logic_vector((p_address_width-1) downto 0);
	
	component ALU is
		
		port(
			i_A 					: in std_logic_vector((p_data_width-1) downto 0);
			i_B 					: in std_logic_vector((p_data_width-1) downto 0);
			i_sel_ula			: in std_logic;
			o_Saida 				: out std_logic_vector((p_data_width-1) downto 0)
		);
	end component;
	
	component ACC is
		
		Port(
			i_RST 				: in std_logic;
			i_CLK 				: in std_logic;
			i_WR_ACC				: in std_logic;
			i_DATA				: in std_logic_vector((p_data_width-1) downto 0);
			o_DATA				: out std_logic_vector((p_data_width-1) downto 0)
			
		);
	end component;
	
	component INSTRUCTION_REGISTER is
		
		port(
			i_rom					: in std_logic_vector((p_data_width-1) downto 0);
			o_opcode				: out std_logic_vector(3 downto 0);
			o_address_ram		: out std_logic_vector((p_address_width-1) downto 0)
			
		);
	end component;

BEGIN
	
	-- Expansões
	exp_i: for i in 3 downto 0 generate
		w_expanded_out_ir((p_data_width-1)-(3-i)) <=  '0';	
		w_expanded_switches((p_data_width-1)-(3-i)) <=  '0';								
	end generate exp_i;
	exp_ir: for i in (p_address_width-1) downto 0 generate
		w_expanded_out_ir(i) <=  w_address_ram(i);									
	end generate exp_ir;
	exp_sw: for i in (p_address_width-1) downto 0 generate
		w_expanded_switches(i) <=  i_switches(i);									
	end generate exp_sw;
	
	-----------------------------------------------------------------------------------------------

	-- Multiplexadores
	
	-- Mux padrão (entrada 1 da ULA)
		-- entradas:
			-- dout_ram
			-- address_ram (saida do ir ) [pelo pdf do trabalho essa entrada compete com i_switches
											-- então precisa de mais um outro mux, 
											-- mas daria pra fazer só colocando na 4a entrada...]
												-- Foi o que eu fiz :)
			-- w_out_ula (saida da ula)
		-- i_switches
	WITH i_sel_op1 SELECT      -- expressao_escolha =
	w_in_acc <= i_dout_ram WHEN "00",
					w_expanded_out_ir WHEN "01",
					w_out_ula WHEN "10",
					w_expanded_switches WHEN "11",
					(others =>'0') WHEN OTHERS;


	-- Mux da entrada 0 da ULA
	with i_sel_op2 SELECT      -- expressao_escolha =
		w_in_ula0 <= i_dout_ram when '0',
					w_expanded_out_ir when '1',
					(others =>'0') when OTHERS;

	-----------------------------------------------------------------------------------------------
	-- Conexões internas
	
	w_in_ula1 <= w_out_acc;
	o_din_ram <= w_out_acc;
	o_address_ram <= w_address_ram;
	o_out_acc <= w_out_acc;
	
	-----------------------------------------------------------------------------------------------
	-- Atribuições de componentes
	
	uni_logica_arit: ALU
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_A 					=> w_in_ula0, -- esquerda do diagrama
		i_B 					=> w_in_ula1, -- direita do diagrama
		i_sel_ula			=> i_sel_ula,
		o_Saida 				=> w_out_ula-- vai pro mux padrão
	);
	
	acumulador: ACC
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_RST 				=> i_rst ,
		i_CLK 				=> i_clk ,
		i_WR_ACC			=> i_wr_acc ,
		i_DATA				=>  w_in_acc, -- aqui entra a saída do mux padrão
		o_DATA				=> w_out_acc
	);
	
	registrador_instrucao: INSTRUCTION_REGISTER
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_rom					=> i_dout_rom,
		o_opcode				=> o_opcode,
		o_address_ram		=> w_address_ram -- esse aqui eu vou ter que extender depois com "0000" e colocar no mux padrão
	);
	
END behavior;