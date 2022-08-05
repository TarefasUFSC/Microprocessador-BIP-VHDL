library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity RAM is
	Generic(
		p_tipo_memoria		: string  := "BL_LOGICO"; -- opções são INTEL e BL_LOGICO
		p_data_width		: integer := 16;
		p_add_width 		: integer := 12
	);
	Port(
		-- clock
		i_clk 				: in 	std_logic;
		
		-- entrada
		i_data 				: in 	std_logic_vector((p_data_width-1) downto 0);
		
		-- pino LD do logisim
			-- se 1 → bota na saida o que ta no endereço
			-- se 0 → escreve no endereço o que ta na entrada de dados
		i_wr					: in 	std_logic;
		
		-- pino SEL do logisim
			-- Se a ram ta ligada
		i_en 					: in 	std_logic;
		
		-- apenas uma entrada de endereço, pois estou usando o mesmo modelo do logisim
		i_add 				: in 	std_logic_vector((p_add_width-1) downto 0);
		
		-- botão de reset da ram
		i_clr					: in 	std_logic;
		
		-- saida
		o_data 				: out std_logic_vector((p_data_width-1) downto 0)
	);
end RAM;

architecture Behavioral of RAM is
	type mem_type is array(0 to p_add_width*p_add_width-1) of std_logic_vector(i_data'range);
	signal w_memoria_ram : mem_type:= (others => (others => '0'));
	signal w_address 	: std_logic_vector(p_add_width-1 downto 0):= (others => '0');
	signal w_address_num 	: unsigned(p_add_width-1 downto 0);
	
	-- isso aqui serve pra resolver esse erro:
		-- character ''z'' used but not declared for type "std_ulogic"
	-- mas não funcionou
--		TYPE std_ulogic IS ( 
--			'U',  -- Uninitialized
--			'X',  -- Forcing  Unknown
--			'0',  -- Forcing  0
--			'1',  -- Forcing  1
--			'Z',  -- High Impedance   
--			'W',  -- Weak     Unknown
--			'L',  -- Weak     0       
--			'H',  -- Weak     1       
--			'-'   -- Don't care
--		);


	signal w_wr : std_logic := '0';
	signal w_en : std_logic;
	component RAM_SREG
	PORT
	(
		aclr					: IN 	STD_LOGIC  := '0';
		address				: IN 	STD_LOGIC_VECTOR ((p_add_width-1) DOWNTO 0);
		clken					: IN 	STD_LOGIC  := '1';
		clock					: IN 	STD_LOGIC  := '1';
		data					: IN 	STD_LOGIC_VECTOR ((p_data_width-1) DOWNTO 0);
		wren					: IN 	STD_LOGIC ;
		q						: OUT STD_LOGIC_VECTOR ((p_data_width-1) DOWNTO 0)
	);
end component;

begin
	
	intel : if(p_tipo_memoria = "INTEL") generate
		U01 : RAM_SREG PORT MAP (
			aclr	 			=> i_clr,
			address				=> w_address,
			clken	 			=> w_en,
			clock	 			=> i_clk,
			data	 			=> i_data,
			wren	 			=> w_wr,
			q	 				=> o_data
		);	
		--A logica do wren para configurar escrita é inversa do BIP
		process(i_wr,i_clk)
		begin
			if(i_wr = '1') then
				w_address_num <= unsigned(i_add) + 1;
			else
				w_address_num <= unsigned(i_add);
			end if;
		end process;
		
		w_address <= std_logic_vector(w_address_num);
		w_wr <=  not i_wr;
	end generate;
	w_en <=  i_en;
	

	
-- o 'z' ta dando erro e eu não consigo arrumar se eu colocar pra funcionar o negocio da intel junto, mas se descomentar funciona

	bl_logico : if(p_tipo_memoria = "BL_LOGICO") generate	
	w_address <= i_add;
	w_wr <=  not i_wr;
----------------------- Funcionamento--------------------------
	-- Memória com blocos logicos com clear síncrono
	-- Quando o a ram estiver desativada a saída fica em 0
---------------------------------------------------------------
		w_memoria_ram(conv_integer(w_address)) <= i_data when w_wr = '0' and falling_edge(i_clk) and w_en = '1'  else
										w_memoria_ram(conv_integer(w_address));
		o_data <= w_memoria_ram(conv_integer(w_address)) when not rising_edge(i_clk)  and w_en = '1' and i_clr = '0' and w_wr = '1' 
					--else (others => '0');
					else (others => '0') when w_en = '0' and i_clr = '1' 
					else w_memoria_ram(conv_integer(w_address));


		-- Não funciona na subida do clock... pega o dado anterior
		-- process(i_clk)
		-- begin
			
		-- 	if(rising_edge(i_clk)) then
				
		-- 		if(i_en = '1') then
		-- 			if(i_clr = '1') then
		-- 				o_data <= (others => '0');
		-- 			else
		-- 				if (w_wr = '1') then
		-- 					-- leitura
		-- 					o_data <= w_memoria_ram(conv_integer(w_address));
		-- 				else
		-- 					-- escrita
		-- 					w_memoria_ram(conv_integer(w_address)) <= i_data;
		-- 				end if;
		-- 			end if;
		-- 		else
		-- 			o_data <= (others => '0');
		-- 		end if;
		-- 	end if;
				
		-- end process;
	
	end generate;
	
end Behavioral;