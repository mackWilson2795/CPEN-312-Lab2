library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity bcd_addsub is
	port
	(
		-- Input ports
		a, b	: in  std_logic_vector(3 downto 0);
		sub : in std_logic;
		carry_in	: in  std_logic;

		-- Output ports
		sum : out std_logic_vector(3 downto 0);
		carry : out std_logic
	);
end bcd_addsub;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture a of bcd_addsub is
	signal sum_tmp : std_logic_vector(4 downto 0);
	signal sum_tmp_adjs : std_logic_vector(4 downto 0);
	signal b_tmp : std_logic_vector(4 downto 0);

begin
	process(b, sub) is
	begin
		if sub = '1' then
			case b is
				when "0000" => b_tmp<="01001";
				when "0001" => b_tmp<="01000";
				when "0010" => b_tmp<="00111";
				when "0011" => b_tmp<="00110";
				when "0100" => b_tmp<="00101";
				when "0101" => b_tmp<="00100";
				when "0110" => b_tmp<="00011";
				when "0111" => b_tmp<="00010";
				when "1000" => b_tmp<="00001";
				when "1001" => b_tmp<="00000";
				when others => b_tmp<="00000";
			end case;
		else
			b_tmp <= ('0' & b);
		end if;
	end process;

	-- Process Statement (optional)
	process(a, b_tmp, sum_tmp, sum_tmp_adjs, carry_in)
	begin
		sum_tmp <= ('0' & a) + b_tmp + ("0000" & carry_in);
		sum_tmp_adjs <= sum_tmp + "00110";
		if (sum_tmp > 9) then
			carry <= '1';
			sum <= sum_tmp_adjs(3 downto 0);
		else
			carry <= '0';
			sum <= sum_tmp(3 downto 0);
		end if;
	end process;
end a;