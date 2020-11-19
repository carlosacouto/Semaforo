library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity estados is
	generic
	(
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 1023
	);
	
	port 
	(
		clk							: in std_logic; 
			tg 	: in std_logic_vector(6 downto 0); --:= "0000100"; -- Verde
			tr 	: in std_logic_vector(6 downto 0); --:= "0000100"; -- Amarelo
			ty 	: in std_logic_vector(3 downto 0); --:= "0001"; -- Vermelho		-- Clock
		
		GC, GP, Y, RP, RC			: out std_logic;							-- Saídas que acenderão os LEDs
		som							: out std_logic;
		Tempo							: out integer range MIN_COUNT to MAX_COUNT;
		enable						: buffer std_logic := '0';
		t	: out std_logic_vector(6 downto 0)
		--t_inicial: buffer integer  := 0;
	
	);

end estados;

architecture comportamento of estados is
	type estado is (S0, S1, S2);
	signal estado_atual: estado := S0;
	signal proximo_estado : estado := S1;
	signal t_passado 		 		: integer := 0; 									-- Sinal para contagem de tempo passado 
	signal t_total			 		: integer := to_integer(unsigned(tg));
	signal t_inicial : integer := 0;
	signal tt	: integer;
	
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
					t_passado <= t_passado + 1;
					tempo <= t_passado;
			estado_atual <= proximo_estado;
		end if;
		end process;
		
		process(clk)
		begin

		if (falling_edge(clk)) then
			if (t_passado - t_inicial = t_total) then
				t_inicial <= t_passado;
				enable <= '1';
				tt <= t_passado - t_inicial;
			else
				enable <= '0';
				tt <= t_passado - t_inicial;
			end if;
		end if;	
	end process ;
	
	---------- Mudança de estados e saídas de LED ----------
	
	process(tg, tr, ty, estado_atual, t_passado,  t_total) is
	begin
		case estado_atual is
			when S0 =>
				GC <= '1';
				GP <= '0';
				Y <= '0';
				RC <= '0';
				RP <= '1';
				som <= '0';
				
				if(enable = '1') then
					proximo_estado <= S1;
					t_total <= to_integer(unsigned(ty));
				else 
					proximo_estado <= S0;
				end if;
				
			when S1 =>
				GC <= '0';
				Y <= '1';
			
				if((enable = '1')) then
					proximo_estado <= S2;
					t_total <= to_integer(unsigned(tr));
				else 
					proximo_estado <= S1;
				end if;
			
			when S2 =>

				GP <= '1';
				Y <= '0';
				RC <= '1';
				RP <= '0';
				
				if (t_passado - t_inicial = t_total) then som <= '1';
					elsif (t_passado - t_inicial + 3 = t_total) then som <= '1';
						elsif (t_passado - t_inicial + 2 = t_total) then som <= '1';
							elsif (t_passado - t_inicial + 1 = t_total) then som <= '1';
								
					else som <= '0';
				end if;
				
				if(enable = '1') then
					proximo_estado <= S0;
					t_total <= to_integer(unsigned(tg));
				else 
					proximo_estado <= S2;
				end if;
	
		end case;
	end process;
	t <= std_logic_vector(to_unsigned(tt,7));
end comportamento;