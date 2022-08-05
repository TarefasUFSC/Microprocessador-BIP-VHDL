library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_ADDRESS_COUNTER is
	generic(
		p_data_width	: integer := 16;
		p_address_width : integer := 12
	);
end TB_ADDRESS_COUNTER;

architecture behavioral of TB_ADDRESS_COUNTER is

	component ADDRESS_COUNTER is
		
	port(
		i_clk	:	in	std_logic;
		i_rst	:	in	std_logic;
		i_en_pc	:	in	std_logic;
		o_address	:	out	std_logic_vector(p_address_width-1 downto 0)
		
	);
	end component;
	
	-- cria um signal w_x pra cada port
	signal w_clk	:	std_logic;
	signal w_rst	:	std_logic;
	signal w_en_pc	:	std_logic;
	signal w_address	:	std_logic_vector(p_address_width-1 downto 0);
begin

	UUT: ADDRESS_COUNTER
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_clk => w_clk,	
		i_rst => w_rst,	
		i_en_pc =>  w_en_pc,
		o_address => w_address			
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
		wait for 15 NS;
		w_rst <= '0';
		wait;
	end process;
	

-- teste XX
	process
	begin
		-- colocar os sinais aqui
		w_en_pc <= '0';
		wait for 30 NS;
		w_en_pc <= '1';
		wait;
		
	end process;
end behavioral;