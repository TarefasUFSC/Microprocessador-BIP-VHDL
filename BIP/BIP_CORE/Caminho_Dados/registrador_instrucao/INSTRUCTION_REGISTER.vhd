library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity INSTRUCTION_REGISTER is
	Generic(
		p_data_width		: integer := 16;
		p_add_width 		: integer := 12
	);
	port(
		i_rom					: in std_logic_vector((p_data_width-1) downto 0);
		o_opcode				: out std_logic_vector(3 downto 0);
		o_address_ram		: out std_logic_vector((p_add_width-1) downto 0)
		
	);
end INSTRUCTION_REGISTER;
ARCHITECTURE behavior of INSTRUCTION_REGISTER IS
BEGIN
	opcode : for i in 3 downto 0 generate
		o_opcode(i) <= i_rom((p_data_width-1) - (3-i));
	end generate opcode;
	address : for i in (p_add_width-1) downto 0 generate
		o_address_ram(i) <= i_rom((p_add_width-1) - ((p_add_width-1)-i));
	end generate address;
END behavior;