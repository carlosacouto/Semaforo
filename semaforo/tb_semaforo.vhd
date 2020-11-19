library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_semaforo is
generic(

		MIN_COUNT 			: natural := 0;
		MAX_COUNT 			: natural := 1023
	);
	
end tb_semaforo;

architecture teste of tb_semaforo is

component semaforo is
port (
	 --------------- ENTRADAS ----------------
			tG, tR 	:  in std_logic_vector(6 downto 0); 		-- Tempo de cada estado 
			tY       :  in std_logic_vector(3 downto 0);
			clk  			:	in	std_logic; 										-- Clock input
			
	 --------------- SAIDAS ----------------
			GC, GP	:	out	std_logic;				 -- LED do sinal verde (Green Car / Green People)
			Y			:  out	std_logic;				 -- LED do sinal amarelo (Yellow)
			RC, RP	:	out	std_logic;				 -- LED do sinal vermelho (Red Car / Red People)
			Som		:	out	std_logic;
			Tempo		:	out	integer range MIN_COUNT to MAX_COUNT; -- Falta a saida do display para mostrar o tempo restante
			Enable	:  buffer std_logic;
			t	: out std_logic_vector(6 downto 0)
			--t_inicial : buffer integer
    );
end component;

signal	 tG					 : std_logic_vector(6 downto 0) := "0000011"; -- Tempo de cada verde para carro
signal 	 tY					 : std_logic_vector(3 downto 0) := "0011"; 	 -- Tempo de amarelo para carro
signal 	 tR					 : std_logic_vector(6 downto 0) := "0001000"; -- Tempo de vermelho para carro 
signal 	 enable				 : std_logic := '0';
--signal    t_inicial 			 :  integer  := 0;
signal 	 clock 				 : std_logic := '0';
signal    GC, GP, Y, RC, RP : std_logic;
signal 	 som					 : std_logic;
signal	 Tempo				 : integer range MIN_COUNT to MAX_COUNT;
signal t 	:	std_logic_vector(6 downto 0);

begin
instancia_semaforo: semaforo port map (tY=>tY, tG=>tG, tR=>tR, clk=>clock, GC=>GC, GP=>GP, Y=>Y, RC=>RC, RP=>RP, som => som, Tempo=>Tempo, enable => enable, t=>t);

clock <= not clock after 200 ms;
end teste;
