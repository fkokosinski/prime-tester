library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CounterUp is
	port (
		input: in std_logic_vector (2 downto 0);
		load_enable: in std_logic;
		clock: in std_logic;
		reset: in std_logic;
		
		output: out std_logic_vector (2 downto 0)
	);
end CounterUp;

architecture synth of CounterUp is
constant COUNT_MIN: integer := 0;
constant COUNT_MAX: integer := 2**output'length;
signal current_val: integer range COUNT_MIN to COUNT_MAX;
begin
	process (clock) is
	begin
		if reset = '1' then
			current_val <= 0;
		elsif rising_edge(clock) and load_enable = '1' then
			current_val <= to_integer(unsigned(input));
		elsif rising_edge(clock) and load_enable = '0' then
			current_val <= (current_val + 1) mod COUNT_MAX;
		end if;
	end process;
	
	output <= std_logic_vector(to_unsigned(current_val, output'length));
end synth;
