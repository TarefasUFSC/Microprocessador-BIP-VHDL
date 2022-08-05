library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ROM is
	Generic(
		p_tipo_memoria		: string  := "INTEL"; -- Opções são INTEL e BL_LOGICO
		p_data_width		: integer := 16;
		p_add_width 		: integer := 12
	);
	Port(
		-- clock
		i_clk 				: in 	std_logic;			
		-- pino SEL do logisim
			-- Se a ROM ta ligada
		i_en 					: in 	std_logic;
		-- entrada de endereço
		i_add 				: in 	std_logic_vector((p_add_width-1) downto 0);
		
		-- saida
		o_data 				: out std_logic_vector((p_data_width-1) downto 0)
	);
end ROM;

architecture Behavioral of ROM is
	type mem_type is array( 0 to (p_add_width*p_add_width-1)) of std_logic_vector(o_data'range);	
	
	signal w_memoria_rom : mem_type := (
		x"3013",
	   x"1000",
	   x"300A",
	   x"1001",
	   x"8000",
	   x"1002",
	   x"2000",
	   x"4002",
	   x"1003",
	   x"2000",
	   x"6001",
	   x"1004",
	   x"2004",
	   x"4002",
	   x"1005",
		others => x"0000"
	);
	
	component ROM_INTEL_SREG
		PORT
		(
			address	: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			clken		: IN STD_LOGIC  := '1';
			clock		: IN STD_LOGIC  := '1';
			q			: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	end component;

begin

	intel : if(p_tipo_memoria = "INTEL") generate	
		U01 : ROM_INTEL_SREG PORT MAP (
		address		=> i_add,
		clken	 	=> i_en,
		clock	 	=> i_clk,
		q			=> o_data
	);

	
	end generate;
	
	bl_logico : if(p_tipo_memoria = "BL_LOGICO") generate	

----------------------- Funcionamento--------------------------
	-- Memória com blocos logicos 
	-- Quando o a ROM estiver desativada a saída fica em 0
---------------------------------------------------------------
		process(i_clk)
		begin
			
			if(rising_edge(i_clk)) then
				
				if(i_en = '1') then
					
						o_data <= w_memoria_rom(conv_integer(i_add));
						
					end if;
				
			end if;
				
		end process;
	
	end generate;
	
end Behavioral;