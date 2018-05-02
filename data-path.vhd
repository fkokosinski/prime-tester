library ieee;
use ieee.std_logic_1164.all;

entity DataPath is
	port (
		input: in std_logic_vector (7 downto 0);
		clock: in std_logic;
		
		load_reg_a_enable: in std_logic;
		load_reg_b_enable: in std_logic;
		load_counter_enable: in std_logic;
		count_counter_enable: in std_logic;
		mux_steer: in std_logic;
		
		
		finished: out std_logic;
		not_divisible: out std_logic;
		divisible: out std_logic
	);
end DataPath;

architecture synth of DataPath is

component CounterDown is
	port (
		input: in std_logic_vector (7 downto 0);
		load_enable: in std_logic;
		count_enable: in std_logic;
		clock: in std_logic;
		
		output: out std_logic_vector (7 downto 0)
	);
end component;

component EqualsOne is
	port (
		input: in std_logic_vector (7 downto 0);
		output: out std_logic
	);
end component;

component Multiplexer is
	port (
		input_1: in std_logic_vector (7 downto 0);
		input_2: in std_logic_vector (7 downto 0);
		steer: in std_logic;
		
		output: out std_logic_vector (7 downto 0)
	);
end component;

component ParallelRegister is
	port (
		input: in std_logic_vector (7 downto 0);
		load_enable: in std_logic;
		clock: in std_logic;
		
		output: out std_logic_vector (7 downto 0)
	);
end component;

component Subtractor is
	port (
		input_1: in std_logic_vector (7 downto 0);
		input_2: in std_logic_vector (7 downto 0);
		
		underflow: out std_logic;
		output: out std_logic_vector (7 downto 0)
	);
end component;

signal counter_output: std_logic_vector (7 downto 0);
signal reg_a_output: std_logic_vector (7 downto 0);
signal reg_b_output: std_logic_vector (7 downto 0);
signal mux_output: std_logic_vector (7 downto 0);
signal sub_output: std_logic_vector (7 downto 0);
constant zeros: std_logic_vector (7 downto 0) := (others => '0');

begin
	COUNTER: CounterDown
		port map (
			input => input,
			clock => clock,
			load_enable => load_counter_enable,
			count_enable => count_counter_enable,
			output => counter_output
		);
	
	REGISTER_A: ParallelRegister
		port map (
			input => input,
			clock => clock,
			load_enable => load_reg_a_enable,
			output => reg_a_output
		);
	
	REGISTER_B: ParallelRegister
		port map (
			input => reg_a_output,
			clock => clock,
			load_enable => load_reg_b_enable,
			output => reg_b_output
		);
		
	MUX: Multiplexer
		port map (
			input_1 => reg_a_output,
			input_2 => sub_output,
			steer => mux_steer,
			output => mux_output
		);
		
	COMPARATOR: EqualsOne
		port map (
			input => counter_output,
			output => finished
		);
	
	SUB: Subtractor
		port map (
			input_1 => reg_b_output,
			input_2 => counter_output,
			output => sub_output,
			underflow => not_divisible
		);
	
	divisible <= '1' when sub_output = zeros else '0';
end synth;
