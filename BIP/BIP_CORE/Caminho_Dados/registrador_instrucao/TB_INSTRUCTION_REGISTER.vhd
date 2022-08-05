library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_INSTRUCTION_REGISTER is
	Generic(
			p_data_width		: integer := 16;
			p_add_width 		: integer := 12
		);
end TB_INSTRUCTION_REGISTER;

architecture behavioral of TB_INSTRUCTION_REGISTER is

	component INSTRUCTION_REGISTER is
		
		port(
			i_rom					: in std_logic_vector((p_data_width-1) downto 0);
			o_opcode				: out std_logic_vector(3 downto 0);
			o_address_ram		: out std_logic_vector((p_add_width-1) downto 0)
			
		);
	end component;
	
	-- cria um signal w_x pra cada port
	SIGNAL w_rom				: std_logic_vector((p_data_width-1) downto 0);
	SIGNAL w_opcode			: std_logic_vector(3 downto 0);
	SIGNAL w_address_ram		: std_logic_vector((p_add_width-1) downto 0);
	
begin

	UUT: INSTRUCTION_REGISTER
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_rom					=> w_rom,
		o_opcode				=> w_opcode,
		o_address_ram			=> w_address_ram
	);
	



-- teste INSTRUCTION_REGISTER
	process
	begin
		-- colocar os sinais aqui
		w_rom <= "0011000000010011"; -- é pra sair 0011 no opcode e 000000010011 no endereço
		wait;
		
	end process;
end behavioral;