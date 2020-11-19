library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity clock_div is
	port(
			clk			: in std_logic;
			clock_out 	: out std_logic	
		 );
end clock_div;


architecture teste of clock_div is
signal count 			: integer := 0;

begin

	---------- Divisor de Clock ----------

	process(clk,count)
	begin
		if (rising_edge(clk)) then 
			if (count < 4) then 
				clock_out <= '0';
				count <= count + 1;
			elsif (count = 8) then
				clock_out <= '1';
				count <= 0;
			else 
				clock_out <= '1';
				count <= count + 1;
				
			end if;
		end if;
	end process;
end teste;	


