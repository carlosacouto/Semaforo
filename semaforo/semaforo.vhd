library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity semaforo is
	generic (
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 1023
	);
	
    port (
	 --------------- ENTRADAS ----------------
			CLK  			:	in	std_logic; 							-- Clock input
			tg 			: in std_logic_vector(6 downto 0); --:= "0000100"; -- Verde
			tr 			: in std_logic_vector(6 downto 0); --:= "0000100"; -- Amarelo
			ty 			: in std_logic_vector(3 downto 0); --:= "0001"; -- Vermelho
			
	 --------------- SAIDAS ----------------
			GC, GP	:	out	std_logic;			-- LED do sinal verde (Green)
			Y			:  out	std_logic;			-- LED do sinal amarelo
			RC, RP	:	out	std_logic;			-- LED do sinal vermelho (Red)
			Som		:	out	std_logic; 			-- Saída do som
			Enable	: buffer std_logic := '0';
			t 			: out std_logic_vector(6 downto 0);
			--t_inicial : buffer integer  range MIN_COUNT to MAX_COUNT := 0;
			Tempo		: out integer range MIN_COUNT to MAX_COUNT -- Falta a saida do display para mostrar o tempo restante
			
    );
end semaforo;

architecture logica of semaforo is

	------------------------------------------------------
						-- Componentes --
	------------------------------------------------------
component estados is
port 
	(
		clk					: in std_logic; 
		tg 	: in std_logic_vector(6 downto 0); --:= "0000100"; -- Verde
		tr 	: in std_logic_vector(6 downto 0); --:= "0000100"; -- Amarelo
		ty 	: in std_logic_vector(3 downto 0); --:= "0001"; -- Vermelho										-- Clock
		GC, Y, RC, GP, RP	: out std_logic; 										-- Saidas dos leds 
		Tempo					: out integer range MIN_COUNT to MAX_COUNT;
		SOM					: out std_logic;
		Enable				: buffer std_logic;
		t	: out std_logic_vector(6 downto 0)
		--t_inicial : buffer integer  := 0
	);

end component;

component clock_div is
		port(
			clk				: in std_logic;
			clock_out 		: out std_logic	
		);
	end component;


	------------------------------------------------------------
						-- Declaracao dos sinais --
	------------------------------------------------------------
		

signal clock_t 			: 	std_logic;
begin
	
	------------------------------------------------------------
						-- Declaracao das instancias --
	------------------------------------------------------------
	
	instancia_clock_div : clock_div port map (clk, clock_t);
	instancia_estados   : estados port map (clock_t, tg=>tg, tr=>tr, ty=>ty, gc=>GC, gp=>GP, y=>Y, rc=>RC, rp=>RP, tempo=>tempo, som=>som, enable=>enable, t=>t);

end architecture;