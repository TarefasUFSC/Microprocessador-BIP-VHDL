library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADDRESS_COUNTER is
	generic(
		p_data_width	: integer := 16;
		p_address_width : integer := 12
	);
	port(
		i_clk	:	in	std_logic;
		i_rst	:	in	std_logic;
		i_en_pc	:	in	std_logic;
		o_address	:	out	std_logic_vector(p_address_width-1 downto 0)
		
	);
end ADDRESS_COUNTER;
ARCHITECTURE behavior of ADDRESS_COUNTER IS
	signal w_address	: unsigned(p_address_width-1 downto 0);
BEGIN
	process(i_clk)
	begin
		if i_rst = '1' then
			w_address <= (others => '0');
		elsif i_en_pc = '1' then
			if(rising_edge(i_clk)) then
				w_address <= w_address + 1;
				
			end if;
		end if;
		o_address <= std_logic_vector(w_address);
	end process;
END behavior;