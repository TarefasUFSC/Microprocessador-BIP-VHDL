library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_LOGICA_CONTROLE is

end TB_LOGICA_CONTROLE;

architecture behavioral of TB_LOGICA_CONTROLE is

	component LOGICA_CONTROLE is
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
	
	-- cria um signal w_x pra cada port
	signal w_OPCODE:		std_logic_vector(3 downto 0);
	signal w_WR_RAM:		std_logic;
	signal w_EN_RAM:		std_logic;
	signal w_EN_PC:		std_logic;
	signal w_EN_ROM:		std_logic;
	signal w_WR_ACC:		std_logic;
	signal w_SEL_OP1:		std_logic_vector(1 downto 0);
	signal w_SEL_OP2:		std_logic;
	signal w_SEL_ULA:		std_logic;
	
begin

	UUT: LOGICA_CONTROLE
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_OPCODE 	=> w_OPCODE,
		o_WR_RAM 	=> w_WR_RAM,
		o_EN_RAM 	=> w_EN_RAM,
		o_EN_PC 		=> w_EN_PC,
		o_EN_ROM 	=> w_EN_ROM,
		o_WR_ACC 	=> w_WR_ACC,
		o_SEL_OP1 	=> w_SEL_OP1,
		o_SEL_OP2 	=> w_SEL_OP2,
		o_SEL_ULA 	=> w_SEL_ULA
	);
	



-- teste XX
	process
	begin
		-- colocar os sinais aqui
		w_OPCODE<= "0000";
		wait for 10 ns;
		w_OPCODE<= "0001";
		wait for 10 ns;
		w_OPCODE<= "0010";
		wait for 10 ns;
		w_OPCODE<= "0011";
		wait for 10 ns;
		w_OPCODE<= "0100";
		wait for 10 ns;
		w_OPCODE<= "0101";
		wait for 10 ns;
		w_OPCODE<= "1000";
		wait for 10 ns;
		wait;
		
	end process;
end behavioral;