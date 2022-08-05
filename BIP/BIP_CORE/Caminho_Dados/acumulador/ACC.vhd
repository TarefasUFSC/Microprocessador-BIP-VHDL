library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ACC is
	Generic(
		p_data_width		: integer := 16
	);
	Port(
		i_RST 				: in std_logic;
		i_CLK 				: in std_logic;
		i_WR_ACC 			: in std_logic;
		i_DATA				: in std_logic_vector((p_data_width-1) downto 0);
		o_DATA				: out std_logic_vector((p_data_width-1) downto 0)
		
	);
end ACC;
ARCHITECTURE behavior of ACC IS
BEGIN
	reg_assincrono: process(i_CLK,i_RST,i_WR_ACC)
	begin
	
			if (i_RST = '1') then
				o_DATA <= (others => '0'); 
			else
				if (i_WR_ACC = '1') then
					if (rising_edge(i_CLK)) then
						o_DATA <= i_DATA;
					end if;
				end if;
			end if;
	end process reg_assincrono;
END behavior;