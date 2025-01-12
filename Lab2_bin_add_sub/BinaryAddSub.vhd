library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity bin_adder is
	port
	(
		-- Input ports
		a, b	: in  std_logic_vector(7 downto 0);
		sub : in std_logic;
		carry_in	: in  std_logic;

		-- Output ports
		sum : out std_logic_vector(7 downto 0);
		carry : out std_logic
	);
end bin_adder;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture a of bin_adder is
	signal sum_tmp : std_logic_vector(8 downto 0);
	signal b_tmp : std_logic_vector(8 downto 0);

begin
	process(b, sub) is
	begin
		if sub = '1' then
			b_tmp <= (('0' & not(b)) + 1);
		else
			b_tmp <= ('0' & b);
		end if;
	end process;

	-- Process Statement (optional)
	process(a, b_tmp, sum_tmp, carry_in)
	begin
		sum_tmp <= ('0' & a) + b_tmp + ("0000" & carry_in);
		carry <= sum_tmp(8);
		sum <= sum_tmp(7 downto 0);
	end process;
end a;