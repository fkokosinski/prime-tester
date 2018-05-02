library ieee;
use ieee.std_logic_1164.all;

entity ReadOnlyMemory is
	port (
		address: in std_logic_vector (2 downto 0);
		
		instruction_type: out std_logic;
		condition: out std_logic_vector (1 downto 0);
		steer: out std_logic_vector (6 downto 0);
		jmp_address: out std_logic_vector (2 downto 0)
	);
end ReadOnlyMemory;

architecture synth of ReadOnlyMemory is
-- warunek spelniony -> skok, brak warunku -> inkrementuj
-- steer:
-- 0. LAE
-- 1. LBE
-- 2. CLE
-- 3. CCE
-- 4. MUX
-- 5. WYNIK
-- 6. pierwsza

-- warunki
-- 0. start
-- 1. jedynka
-- 2. ujemna
-- 3. zero

begin
	process (address)
	begin
		case address is
			when "000" => 
				instruction_type <= '0';
				condition <= "00";
				steer <= (others => '0');
				jmp_address <= "000";
			when "001" =>
				instruction_type <= '1';
				condition <= "00";
				steer <= (0 => '1',
							 2 => '1',
							 others => '0');
				jmp_address <= "010";
			when "010" =>
				instruction_type <= '0';
				condition <= "01";
				steer <= (1 => '1',
							 3 => '1',
							 4 => '0',
							 others => '0');
				jmp_address <= "110";
			when "011" =>
				instruction_type <= '0';
				condition <= "10";
				steer <= (1 => '1',
							 4 => '1', 
							 others => '0');
				jmp_address <= "010";
			when "100" =>
				instruction_type <= '0';
				condition <= "11";
				steer <= (others => '0');
				jmp_address <= "011";
			when "101" =>
				instruction_type <= '1';
				condition <= "00";
				steer <= (5 => '1',
							 6 => '1',
							 others => '0');
				jmp_address <= "000";
			when others =>
				instruction_type <= '1';
				condition <= "00";
				steer <= (5 => '1',
							 6 => '0',
							 others => '0');
				jmp_address <= "000";
		end case;
	end process;
end synth;