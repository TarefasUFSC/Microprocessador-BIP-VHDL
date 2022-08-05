library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BIP is
	Generic(
		mode					: string  := "fpga"; -- Opções são tst e fpga
		p_data_width			: integer := 16;
		p_add_width 			: integer := 12
	);
	port(
		i_clk 					: in std_logic;
		i_switches 				: in std_logic_vector(p_add_width-1 downto 0);
		-- i_add_tst				: in std_logic_vector(p_add_width-1 downto 0);
		-- i_wr_ram 				: in std_logic;
		-- i_en_ram 				: in std_logic;
		-- i_en_rom 				: in std_logic;
		i_rst 					: in std_logic 
	);
end BIP;
ARCHITECTURE behavior of BIP IS
	signal w_din_ram 			: std_logic_vector(p_data_width-1 downto 0);
	signal w_wr_ram 			: std_logic := '0';
	signal w_en_ram 			: std_logic := '1';
	signal w_en_rom 			: std_logic := '1';
	signal w_rst_pll	 		: std_logic ;
	signal w_rst	 			: std_logic ;
	signal w_rst_bip 			: std_logic ;
	signal w_clk_pll 			: std_logic ;
	signal w_add_ram 			: std_logic_vector(p_add_width-1 downto 0);
	signal w_add_rom 			: std_logic_vector(p_add_width-1 downto 0);
	signal w_switches 			: std_logic_vector(p_add_width-1 downto 0);
	signal w_dout_ram 			: std_logic_vector(p_data_width-1 downto 0);
	signal w_dout_rom 			: std_logic_vector(p_data_width-1 downto 0);
	signal w_out_acc 			: std_logic_vector(p_data_width-1 downto 0);


	-- O caminho para o arquivo de dados não está relativo, então está com o caminho absoluto da minha máquina
		-- Para sintetizar é necessário alterar o arquivo rom_intel_sreg.vhd e colocar o endereço absoluto para o .mif de sua máquina
	component ROM is
		port(
			-- clock
		i_clk 					: in 	std_logic;			
		-- pino SEL do logisim
			-- Se a ROM ta ligada
		i_en 					: in 	std_logic;
		-- entrada de endereço
		i_add 					: in 	std_logic_vector((p_add_width-1) downto 0);

		
		-- saida
		o_data 					: out std_logic_vector((p_data_width-1) downto 0)
	);
	end component;
	component RAM is
		
		port(
			-- mesmos ports do coponente (só copiar do entity)

		i_clk					: in 	std_logic;
		i_data					: in 	std_logic_vector((p_data_width-1) downto 0);
		i_wr					: in 	std_logic;
		i_en					: in 	std_logic;
		i_add					: in 	std_logic_vector((p_add_width-1) downto 0);
		i_clr					: in 	std_logic;
		o_data					: out std_logic_vector((p_data_width-1) downto 0)
		);
	end component;
	component BIP_CORE is
		
		port(
			i_dout_rom 			: in std_logic_vector(p_data_width-1 downto 0);
			i_dout_ram 			: in std_logic_vector(p_data_width-1 downto 0);
			i_clk 				: in std_logic;
			i_rst 				: in std_logic;
			i_switches 			: in std_logic_vector(p_add_width-1 downto 0);
			o_address_rom 		: out std_logic_vector(p_add_width-1 downto 0);
			o_address_ram		: out std_logic_vector(p_add_width-1 downto 0);
			o_din_ram			: out std_logic_vector(p_data_width-1 downto 0);
			o_wr_ram			: out std_logic;
			o_en_rom			: out std_logic;
			o_en_ram			: out std_logic;
			o_out_acc 			: out std_logic_vector(p_data_width-1 downto 0)
		);
	end component;
	component PLL is
		port(
			i_clk		: in std_logic;
			i_rst		: in std_logic;
			o_clk		: out std_logic;
			o_locked	: out std_logic
		);
	end component;
BEGIN
	
	
	
	-- tst_m : if(mode = "tst") generate	
	-- 	w_en_rom <= i_en_rom;
	-- 	w_en_ram <= i_en_ram;
	-- 	w_wr_ram <= i_wr_ram;
	-- 	w_add_rom <= i_add_tst;
	-- 	w_add_ram <= i_add_tst;
	-- 	w_din_ram <= w_dout_rom;
	--  w_rst <= not i_rst;
	-- end generate;


	exp_i: for i in 1 downto 0 generate
		w_switches((p_add_width-1)-(1-i)) <=  '0';								
	end generate exp_i;
	U_RAM: RAM
	port map(
		i_clk 					=> i_clk, -- trocar caso usar o PLL
		i_data 					=> w_din_ram,
		i_wr					=> w_wr_ram,
		i_en 					=> w_en_ram,
		i_add 					=> w_add_ram,
		i_clr					=> w_rst,
		o_data 					=> w_dout_ram
	);
	U_ROM: ROM
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente =>  w_x equivalente
		i_clk 					=> i_clk, -- trocar caso usar o PLL
		i_en 					=> w_en_rom,
		i_add 					=> w_add_rom,
		o_data 					=> w_dout_rom
	);
	fpga_m : if(mode = "fpga") generate
		w_rst <= not i_rst;
		w_rst_bip <= not w_rst_pll;
		U_CORE: BIP_CORE
		port map(
			-- Só lembra que aqui a seta é: pino_do_componente =>  w_x equivalente
			i_dout_rom 				=> w_dout_rom ,
			i_dout_ram 				=> w_dout_ram ,
			i_clk 					=> i_clk, -- trocar caso usar o pll
			i_rst 					=> w_rst ,
			i_switches 				=> i_switches ,
			o_address_rom 			=> w_add_rom ,
			o_address_ram 			=> w_add_ram ,
			o_din_ram				=> w_din_ram,
			o_wr_ram				=> w_wr_ram,
			o_en_rom				=> w_en_rom,
			o_en_ram				=> w_en_ram,
			o_out_acc 				=> w_out_acc 
		);
		u_pll: PLL
		port map(
			i_clk 					=> i_clk,
			i_rst 					=> w_rst,
			o_clk 					=> w_clk_pll,
			o_locked 				=> w_rst_pll
		);
	end generate;

	
END behavior;