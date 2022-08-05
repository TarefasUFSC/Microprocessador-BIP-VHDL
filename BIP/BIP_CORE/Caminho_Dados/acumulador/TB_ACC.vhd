library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_ACC is
	Generic(
		p_data_width		: integer := 16
	);
end TB_ACC;

architecture behavioral of TB_ACC is

	component ACC is
		
		Port(
			i_RST 				: in std_logic;
			i_CLK 				: in std_logic;
			i_WR_ACC			: in std_logic;
			i_DATA				: in std_logic_vector((p_data_width-1) downto 0);
			o_DATA				: out std_logic_vector((p_data_width-1) downto 0)
			
		);
	end component;
	
	-- cria um signal w_x pra cada port
	signal w_RST 				: std_logic;
	signal w_CLK 				: std_logic;
	signal w_EN					: std_logic;
	signal w_i_DATA				: std_logic_vector((p_data_width-1) downto 0);
	signal w_o_DATA				: std_logic_vector((p_data_width-1) downto 0);
	
begin

	UUT: ACC
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_RST 				=> w_RST ,
		i_CLK 				=> w_CLK ,
		i_WR_ACC			=> w_EN ,
		i_DATA				=> w_i_DATA ,
		o_DATA				=> w_o_DATA
	);
	

-- Sinais
	-- clock
	process
	begin
		w_CLK <= '0';
		wait for 10 NS;
		w_CLK <= '1';
		wait for 10 NS;
	end process;

	-- reset
	process
	begin
		w_RST <= '1';
		wait for 10 NS;
		w_RST <= '0';
		wait;
	end process;
	

-- teste ACC
	process
	begin
		-- colocar os sinais aqui
		w_EN 	<= '0';
		
		wait for 30 ns;
		w_EN 	<= '1';
		w_i_DATA <= x"AAAA";
		wait for 30 ns;
		w_i_DATA <= x"00F0";
		wait for 30 ns;
		w_i_DATA <= x"0006";
		wait for 30 ns;
		w_i_DATA <= x"2C1F";
		wait;
		
	end process;
end behavioral;