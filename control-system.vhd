library ieee;
use ieee.std_logic_1164.all;

entity ControlSystem is
	port (
		clock: in std_logic;
		reset: in std_logic;
		
		start: in std_logic;
		finished: in std_logic;
		not_divisible: in std_logic;
		divisible: in std_logic;
		
		load_reg_a_enable: out std_logic;
		load_reg_b_enable: out std_logic;
		load_counter_enable: out std_logic;
		count_counter_enable: out std_logic;
		mux_steer: out std_logic;
		
		result: out std_logic;
		is_prime: out std_logic
	);
end ControlSystem;

architecture synth of ControlSystem is

component CounterUp is
	port (
		input: in std_logic_vector (2 downto 0);
		load_enable: in std_logic;
		clock: in std_logic;
		reset: in std_logic;
		
		output: out std_logic_vector (2 downto 0)
	);
end component;

component ReadOnlyMemory is
	port (
		address: in std_logic_vector (2 downto 0);
		
		instruction_type: out std_logic;
		condition: out std_logic_vector (1 downto 0);
		steer: out std_logic_vector (6 downto 0);
		jmp_address: out std_logic_vector (2 downto 0)
	);
end component;

component Multiplexer2 is
	port (
		input_1: in std_logic;
		input_2: in std_logic;
		input_3: in std_logic;
		input_4: in std_logic;
		steer: in std_logic_vector (1 downto 0);
		
		output: out std_logic
	);
end component;

signal instruction_type_out: std_logic;
signal condition_out: std_logic_vector (1 downto 0);
signal steer_out: std_logic_vector (6 downto 0);
signal jmp_address_out: std_logic_vector (2 downto 0);

signal mux_out: std_logic;
signal counter_out: std_logic_vector(2 downto 0);

begin
	MEMORY: ReadOnlyMemory
		port map (
			address => counter_out,
			instruction_type => instruction_type_out,
			condition => condition_out,
			steer => steer_out,
			jmp_address => jmp_address_out
		);
		
	MUX: Multiplexer2
		port map (
			input_1 => start,
			input_2 => finished,
			input_3 => not_divisible,
			input_4 => not divisible,
			steer => condition_out,
			output => mux_out
		);
	
	COUNTER: CounterUp
		port map (
			input => jmp_address_out,
			load_enable => mux_out or instruction_type_out,
			clock => clock,
			reset => reset,
			output => counter_out
		);
	
end synth;
