library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_PLL is

end TB_PLL;

architecture behavioral of TB_PLL is

	component PLL is
		port(
		i_clk		: in std_logic;
		i_rst		: in std_logic;
		o_clk		: out std_logic;
		o_locked	: out std_logic
	);
	end component;
	
	-- cria um signal w_x pra cada port
	signal w_i_clk		: std_logic;
	signal w_rst		: std_logic;
	signal w_o_clk		: std_logic;
	signal w_locked	: std_logic;
	
begin

	UUT: PLL
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_clk		=> w_i_clk,
		i_rst		=> w_rst,
		o_clk		=> w_o_clk,
		o_locked	=> w_locked
	);
	

-- Sinais
	-- clock
	process
	begin
		w_i_clk <= '0';
		wait for 10 NS;
		w_i_clk <= '1';
		wait for 10 NS;
	end process;

	-- reset
	process
	begin
		w_rst <= '1';
		wait for 10 NS;
		w_rst <= '0';
		wait;
	end process;
	

-- teste XX
	process
	begin
		-- colocar os sinais aqui
		wait;
		
	end process;
end behavioral;