library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_BIP_CORE is
	generic(
		p_address_width : integer := 12;
		p_data_width : integer := 16
	);
end TB_BIP_CORE;

architecture behavioral of TB_BIP_CORE is

	component BIP_CORE is
		
		port(
			i_dout_rom : in std_logic_vector(p_data_width-1 downto 0);
			i_dout_ram : in std_logic_vector(p_data_width-1 downto 0);
			i_clk : in std_logic;
			i_rst : in std_logic;
			i_switches : in std_logic_vector(p_address_width-1 downto 0);
			o_address_rom : out std_logic_vector(p_address_width-1 downto 0);
			o_address_ram : out std_logic_vector(p_address_width-1 downto 0);
			o_din_ram: out std_logic_vector(p_data_width-1 downto 0);
			o_out_acc : out std_logic_vector(p_data_width-1 downto 0)
		);
	end component;
	
	-- cria um signal w_x pra cada port
	SIGNAL w_dout_rom :  std_logic_vector(p_data_width-1 downto 0);
	SIGNAL w_dout_ram :  std_logic_vector(p_data_width-1 downto 0);
	SIGNAL w_clk :  std_logic;
	SIGNAL w_rst :  std_logic;
	SIGNAL w_switches :  std_logic_vector(p_address_width-1 downto 0);
	SIGNAL w_address_rom :  std_logic_vector(p_address_width-1 downto 0);
	SIGNAL w_address_ram :  std_logic_vector(p_address_width-1 downto 0);
	SIGNAL w_din_ram:  std_logic_vector(p_data_width-1 downto 0);
	SIGNAL w_out_acc :  std_logic_vector(p_data_width-1 downto 0);
	
	
	
	
begin

	UUT: BIP_CORE
	port map(
		-- Só lembra que aqui a seta é: pino_do_componente => w_x equivalente
		i_dout_rom =>w_dout_rom ,
		i_dout_ram =>w_dout_ram ,
		i_clk =>w_clk,
		i_rst =>w_rst,
		i_switches =>w_switches ,
		o_address_rom =>w_address_rom ,
		o_address_ram =>w_address_ram ,
		o_din_ram=> w_din_ram,
		o_out_acc =>w_out_acc 
	);
	

-- Sinais
	-- clock
	process
	begin
		w_switches <= x"007";
		w_clk <= '0';
		wait for 10 NS;
		w_clk <= '1';
		wait for 10 NS;
	end process;

	-- reset
	process
	begin
		w_rst <= '1';
		wait for 20 NS;
		w_rst <= '0';
		wait;
	end process;
	

-- teste XX
	process
	begin
		wait for 50 ns;
		-- // Carrega o A
		w_dout_rom <= x"3013";-- LDI  0x013
		wait for 20 ns; 
		w_dout_rom <= x"1000";-- STO  0x000
		wait for 20 ns;
		-- // Carrega o  B
		w_dout_rom <= x"300A";-- LDI  0x00A
		wait for 20 ns; 
		w_dout_rom <= x"1001";-- STO  0x001
		wait for 20 ns;
		-- // Carrega os switches
		w_dout_rom <= x"8000";-- INP  0xXXX
		wait for 20 ns;
		w_dout_rom <= x"1002";-- STO  0x002
		wait for 20 ns;

		-- // Soma com os imediatos A+B = 1D 
		w_dout_rom <= x"2000";-- LD   0x000
		w_dout_ram <= x"0013";		
		wait for 20 ns;
		w_dout_rom <= x"4001";-- ADD  0x001
		w_dout_ram <= x"000A";		
		wait for 20 ns;
		w_dout_rom <= x"1003";-- STO  0x003
		wait for 20 ns;

		-- // SUB nnn significa ACC = ACC - nnn
		-- // Subtração com os imediatos A-B = 9
		w_dout_rom <= x"2000";-- LD   0x000
		w_dout_ram <= x"0013";		
		wait for 20 ns;
		w_dout_rom <= x"6001";-- SUB  0x001
		w_dout_ram <= x"000A";		
		wait for 20 ns;
		w_dout_ram <= x"0009";	
		w_dout_rom <= x"1004";-- STO  0x004
		wait for 20 ns;


		-- // Soma com o resultado da subtração anterior com os switches 9 - SWITCH 
		-- // vou testar o switch no tb com 7 -> 9 + 7 = 10
		w_dout_rom <= x"2004";-- LD   0x004
		wait for 20 ns;
		w_dout_rom <= x"4002";-- ADD  0x002
		w_dout_ram <= x"0007";		
		wait for 20 ns;
		w_dout_rom <= x"1005";--S STO  0x005
		wait for 20 ns;
		wait;
	end process;

end behavioral;