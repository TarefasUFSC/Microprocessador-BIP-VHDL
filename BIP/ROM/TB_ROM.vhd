library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_ROM is
	Generic(
		p_tipo_memoria		: string  := "INTEL"; -- outra opção é INTEL
		p_data_width		: integer := 16;
		p_add_width 		: integer := 12
	);
end TB_ROM;

architecture behavioral of TB_ROM is

	component ROM is
		port(
			-- clock
		i_clk 				: in 	std_logic;			
		-- pino SEL do logisim
			-- Se a ROM ta ligada
		i_en 					: in 	std_logic;
		-- entrada de endereço
		i_add 				: in 	std_logic_vector((p_add_width-1) downto 0);

		
		-- saida
		o_data 				: out std_logic_vector((p_data_width-1) downto 0)
	);
	end component;
	
	-- cria um signal w_x pra cada port
	signal w_clk 				:  	std_logic;
	signal w_clr 				:  	std_logic;
	signal w_en 				:  	std_logic;
	signal w_add 				:  	std_logic_vector((p_add_width-1) downto 0);
	signal w_data 				:  std_logic_vector((p_data_width-1) downto 0);
	
begin

	UUT: ROM
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_clk 	=>w_clk,
		i_en 		=>w_en,
		i_add 	=>w_add,
		o_data 	=>w_data
	);
	

-- Sinais
	-- clock
	process
	begin
		w_clk <= '0';
		wait for 5 NS;
		w_clk <= '1';
		wait for 5 NS;
	end process;

	
-- teste ROM
	process
	begin
		-- colocar os sinais aqui
		w_en <= '1';		
		w_add <= x"000";
		wait for 40 ns;
		w_en <= '0';
		w_add <= x"001";
		wait for 30 ns;
		w_add <= x"002";
		wait for 10 ns	;	
		w_en <= '1';	
		wait for 15 ns	;
		w_en <= '0';
		w_add <= x"002";
		wait for 15 ns	;
		w_en <= '1';
		w_add <= x"003";
		wait;
	end process;
	

end behavioral;