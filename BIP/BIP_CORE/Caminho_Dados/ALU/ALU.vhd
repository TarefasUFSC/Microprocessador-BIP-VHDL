library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	Generic(
		p_data_width		: integer := 16
	);
	port(
		i_A 					: in std_logic_vector((p_data_width-1) downto 0);

		-- esse aqui entra o acumulador
		i_B 					: in std_logic_vector((p_data_width-1) downto 0);
		i_sel_ula			: in std_logic;
		o_Saida 				: out std_logic_vector((p_data_width-1) downto 0)
	);
end ALU;
ARCHITECTURE behavior of ALU IS
	signal w_sum 					: unsigned((p_data_width-1) downto 0);
	signal w_sub 					: unsigned((p_data_width-1) downto 0);
	signal w_A 	 					: unsigned((p_data_width-1) downto 0);
	signal w_B 						: unsigned((p_data_width-1) downto 0);
BEGIN
	w_A <= unsigned(i_A);
	w_B <= unsigned(i_B);
	w_sum <= w_A + w_B;
	w_sub <= w_B - w_A;
--	process (i_sel_ula,i_A,iB)
--	begin
--		if(i_sel_ula = '0') then
--			o_Saida <= i_A + i_B;
--		else			
--			o_Saida <= i_A - i_B;
--		end if;
--		--o_Saida <= result;
--	end process;
		WITH i_sel_ula SELECT      
			o_Saida 	<= 	std_logic_vector(w_sum) WHEN '0',
								std_logic_vector(w_sub) WHEN '1',
								(others => '0') when others;

END behavior;


