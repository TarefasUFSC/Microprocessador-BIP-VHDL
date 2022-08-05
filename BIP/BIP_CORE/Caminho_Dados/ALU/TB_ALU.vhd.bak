library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_ALU is
	Generic(
		p_data_width		: integer := 16
	);
end TB_ALU;

architecture behavioral of TB_ALU is

	component ALU is
		
		port(
			i_A 					: in std_logic_vector((p_data_width-1) downto 0);
			i_B 					: in std_logic_vector((p_data_width-1) downto 0);
			i_sel_ula			: in std_logic;
			o_Saida 				: out std_logic_vector((p_data_width-1) downto 0)
		);
	end component;
	
	-- cria um signal w_x pra cada port
	signal w_A 					:  std_logic_vector((p_data_width-1) downto 0);
	signal w_B 					:  std_logic_vector((p_data_width-1) downto 0);
	signal w_sel_ula			:  std_logic;
	signal w_Saida 			:  std_logic_vector((p_data_width-1) downto 0);
	
begin

	UUT: ALU
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_A 					=> w_A,
		i_B 					=> w_B,
		i_sel_ula			=> w_sel_ula,
		o_Saida 				=> w_Saida
	);
	



-- teste ALU
	process
	begin
		-- colocar os sinais aqui
		w_A <= x"0008";
		w_B <= x"0002";
		w_sel_ula <= '0';
		wait for 10 ns;
		
		w_sel_ula <= '1';
		wait;
		
	end process;
end behavioral;