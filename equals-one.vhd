library ieee;
use ieee.std_logic_1164.all;

entity EqualsOne is
	port (
		input: in std_logic_vector (7 downto 0);
		output: out std_logic
	);
end EqualsOne;

architecture synth of EqualsOne is
constant one: std_logic_vector (7 downto 0) := (0 => '1', others => '0');
begin
	output <= '1' when input = one else '0';
end synth;
