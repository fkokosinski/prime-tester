library ieee;
use ieee.std_logic_1164.all;

entity Multiplexer is
	port (
		input_1: in std_logic_vector (7 downto 0);
		input_2: in std_logic_vector (7 downto 0);
		steer: in std_logic;
		
		output: out std_logic_vector (7 downto 0)
	);
end Multiplexer;

architecture synth of Multiplexer is
begin
	output <= input_1 when steer = '0' else input_2;
end synth;