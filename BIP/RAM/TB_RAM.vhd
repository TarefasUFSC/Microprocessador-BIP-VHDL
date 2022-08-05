library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_RAM is
	Generic(
		p_tipo_memoria		: string  := "INTEL"; -- outra opção é BL_LOGICO (mas n funciona kkkk)
		p_data_width		: integer := 16;
		p_add_width 		: integer := 12
	);

end TB_RAM;

architecture behavioral of TB_RAM is

	component RAM is
	
		port(
			-- mesmos ports do coponente (só copiar do entity)

		i_clk 				: in 	std_logic;
		i_data 				: in 	std_logic_vector((p_data_width-1) downto 0);
		i_wr					: in 	std_logic;
		i_en 					: in 	std_logic;
		i_add 				: in 	std_logic_vector((p_add_width-1) downto 0);
		i_clr					: in 	std_logic;
		o_data 				: out std_logic_vector((p_data_width-1) downto 0)
		);
	end component;
	
	-- cria um signal w_x pra cada port
		signal w_clk 				: std_logic;
		signal w_i_data 			: std_logic_vector((p_data_width-1) downto 0);
		
		-- pino LD do logisim
			-- se 1 → bota na saida o que ta no endereço
			-- se 0 → escreve no endereço o que ta na entrada de dados
		signal w_wr					: std_logic :='0';
		
		
		signal w_en 				: std_logic;
		signal w_add 				: std_logic_vector((p_add_width-1) downto 0);
		signal w_clr				: std_logic;
		signal w_o_data 			: std_logic_vector((p_data_width-1) downto 0);
	
begin

	UUT: RAM
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_clk					=> w_clk ,
		i_data				=> w_i_data ,
		i_wr					=> w_wr,
		i_en 					=> w_en ,
		i_add 				=> w_add ,
		i_clr					=> w_clr	,
		o_data 				=> w_o_data
	);
	

-- Sinais
	-- clock
	process
	begin
		w_clk <= '1';
		wait for 10 NS;
		w_clk <= '0';
		wait for 10 NS;
	end process;

	-- reset
	process
	begin
		w_clr <= '1';
		wait for 20 NS;
		w_clr <= '0';
		wait;
	end process;
	

-- teste RAM
	process
	begin
		-- colocar os sinais aqui
		
		wait for 40 NS;
		w_add 		<= x"000";
		w_en 		<= '1';
		w_wr 		<= '1';
		w_i_data <= x"AA0F";
		-- wait for 	40 NS;
		-- w_en 		<= '0';
		wait for 	20 NS;
		
		w_add 	<= x"001";
		w_en 		<= '1';
		w_wr 		<= '1';
		w_i_data <= x"B00B";
		-- wait for 	20 NS;
		-- w_en 		<= '0';
		wait for 	20 NS;
		
		w_add 	<= x"000";
		w_en 		<= '1';
		w_wr 		<= '0';
		-- wait for 	20 NS;
		-- w_en 		<= '0';
		wait for 	20 NS;
		
		w_add 	<= x"001";
		w_en 		<= '1';
		w_wr 		<= '0';
		-- wait for 	20 NS;
		-- w_en 		<= '0';
		wait for 	20 NS;
		
		wait;
		
	end process;
end behavioral;

-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.STD_LOGIC_ARITH.ALL;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity TB_RAM is
-- 	Generic(
-- 		p_tipo_memoria		: string  := "INTEL"; -- outra opção é BL_LOGICO (mas n funciona kkkk)
-- 		p_data_width		: integer := 16;
-- 		p_add_width 		: integer := 12
-- 	);

-- end TB_RAM;

-- architecture behavioral of TB_RAM is

-- 	component RAM is
	
-- 		port(
-- 			-- mesmos ports do coponente (só copiar do entity)

-- 		i_clk 				: in 	std_logic;
-- 		i_data 				: in 	std_logic_vector((p_data_width-1) downto 0);
-- 		i_wr					: in 	std_logic;
-- 		i_en 					: in 	std_logic;
-- 		i_add 				: in 	std_logic_vector((p_add_width-1) downto 0);
-- 		i_clr					: in 	std_logic;
-- 		o_data 				: out std_logic_vector((p_data_width-1) downto 0)
-- 		);
-- 	end component;
	
-- 	-- cria um signal w_x pra cada port
-- 		signal w_clk 				: std_logic;
-- 		signal w_i_data 			: std_logic_vector((p_data_width-1) downto 0);
		
-- 		-- pino LD do logisim
-- 			-- se 1 → bota na saida o que ta no endereço
-- 			-- se 0 → escreve no endereço o que ta na entrada de dados
-- 		signal w_wr					: std_logic;
		
		
-- 		signal w_en 				: std_logic;
-- 		signal w_add 				: std_logic_vector((p_add_width-1) downto 0);
-- 		signal w_clr				: std_logic;
-- 		signal w_o_data 			: std_logic_vector((p_data_width-1) downto 0);
	
-- begin

-- 	UUT: RAM
-- 	port map(
-- 		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
-- 		i_clk					=> w_clk ,
-- 		i_data				=> w_i_data ,
-- 		i_wr					=> w_wr,
-- 		i_en 					=> w_en ,
-- 		i_add 				=> w_add ,
-- 		i_clr					=> w_clr	,
-- 		o_data 				=> w_o_data
-- 	);
	

-- -- Sinais
-- 	-- clock
-- 	process
-- 	begin
-- 		w_clk <= '1';
-- 		wait for 10 NS;
-- 		w_clk <= '0';
-- 		wait for 10 NS;
-- 	end process;

-- 	-- reset
-- 	process
-- 	begin
-- 		w_clr <= '1';
-- 		wait for 20 NS;
-- 		w_clr <= '0';
-- 		wait;
-- 	end process;
	

-- -- teste RAM
-- 	process
-- 	begin
-- 		-- colocar os sinais aqui
		
-- 		wait for 20 NS;		
-- 		w_add 		<= x"000";
-- 		wait for 20 NS;		
-- 		w_add 	<= x"001";
-- 		wait for 20 NS;		
-- 		w_add 	<= x"000";
-- 		wait for 20 NS;		
-- 		w_add 	<= x"001";

-- 	end process;
-- 	process
-- 	begin
-- 		-- colocar os sinais aqui
		
-- 		wait for 30 NS;
-- 		w_en 		<= '1';
-- 		w_wr 		<= '0';
-- 		w_i_data <= x"AA0F";
-- 		-- wait for 	40 NS;
-- 		-- w_en 		<= '0';
-- 		wait for 	20 NS;
		
-- 		w_en 		<= '1';
-- 		w_wr 		<= '0';
-- 		w_i_data <= x"B00B";
-- 		-- wait for 	20 NS;
-- 		-- w_en 		<= '0';
-- 		wait for 	20 NS;
		
-- 		w_en 		<= '1';
-- 		w_wr 		<= '1';
-- 		-- wait for 	20 NS;
-- 		-- w_en 		<= '0';
-- 		wait for 	20 NS;
		
-- 		w_en 		<= '1';
-- 		w_wr 		<= '1';
-- 		-- wait for 	20 NS;
-- 		-- w_en 		<= '0';
-- 		wait for 	20 NS;
		
-- 		wait;
		
-- 	end process;
-- end behavioral;