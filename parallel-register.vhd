library ieee;
use ieee.std_logic_1164.all;

entity ParallelRegister is
	port (
		input: in std_logic_vector (7 downto 0);
		load_enable: in std_logic;
		clock: in std_logic;
		
		output: out std_logic_vector (7 downto 0)
	);
end ParallelRegister;

architecture synth of ParallelRegister is
begin
	process (clock) is
	begin
		if rising_edge(clock) and load_enable = '1' then
			output <= input;
		end if;
	end process;
end synth;
