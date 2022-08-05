library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LOGICA_CONTROLE is
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
end LOGICA_CONTROLE;
ARCHITECTURE behavior of LOGICA_CONTROLE IS
	signal w_A: std_logic;
	signal w_B: std_logic;
	signal w_C: std_logic;
	signal w_D: std_logic;
	
	signal W_reduction1 : std_logic;
	signal W_reduction2 : std_logic;
BEGIN
	w_A <= i_OPCODE(3);
	w_B <= i_OPCODE(2);
	w_C <= i_OPCODE(1);
	w_D <= i_OPCODE(0);
	-------------------
	W_reduction1 	<= (NOT W_B) AND (NOT W_C) AND W_D; 
	o_WR_RAM 		<= W_reduction1;
	
	O_EN_RAM 		<= (W_C and (not W_D)) or W_reduction1 or (W_B and (not W_D));
	
	W_reduction2	<= W_A or W_B or W_C or W_D;
	O_EN_PC 			<= W_reduction2;
	o_EN_ROM			<= '1';
	
	o_WR_ACC			<= W_A or W_B or W_C;
	
	o_SEL_OP1(1)	<= W_B or W_A;
	o_SEL_OP1(0)	<=	W_A or ((not W_B) and W_C and W_D);
	
	o_SEL_OP2		<= W_D and (W_B or W_C);
	
	o_SEL_ULA		<= W_B and W_C;
	
END behavior;