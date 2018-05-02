library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Subtractor is
	port (
		input_1: in std_logic_vector (7 downto 0);
		input_2: in std_logic_vector (7 downto 0);
		
		underflow: out std_logic;
		output: out std_logic_vector (7 downto 0)
	);
end Subtractor;

architecture synth of Subtractor is
signal difference: integer;
begin
	difference <= to_integer(unsigned(input_1)) - to_integer(unsigned(input_2));
	
	process (difference)
	begin
		if difference < 0 then
			underflow <= '1';
		else
			underflow <= '0';
		end if;
			
		output <= std_logic_vector(to_unsigned(difference, output'length));
	end process;
end synth;
