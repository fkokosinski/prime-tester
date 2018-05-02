library ieee;
use ieee.std_logic_1164.all;

entity Multiplexer2 is
	port (
		input_1: in std_logic;
		input_2: in std_logic;
		input_3: in std_logic;
		input_4: in std_logic;
		steer: in std_logic_vector (1 downto 0);
		
		output: out std_logic
	);
end Multiplexer2;

architecture synth of Multiplexer2 is
begin
	process (steer)
	begin
		case steer is
			when "00" => output <= input_1;
			when "01" => output <= input_2;
			when "10" => output <= input_3;
			when others => output <= input_4;
		end case;
	end process;
end synth;