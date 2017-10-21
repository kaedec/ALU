LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY concurrent_ssd IS

	PORT(S: IN UNSIGNED(3 DOWNTO 0);
			F: OUT UNSIGNED(0 TO 6));
END concurrent_ssd;

ARCHITECTURE concurrent_ssd_arch OF concurrent_ssd IS

BEGIN

WITH S SELECT
	F <= "1001111" when "0001", -- 1
		  "0010010" when "0010", -- 2
		  "0000110" when "0011", -- 3
		  "1001100" when "0100", -- 4
		  "0100100" when "0101", -- 5
		  "0100000" when "0110", -- 6
		  "0001111" when "0111", -- 7
		  "0000000" when "1000", -- -8
		  "0001111" when "1001", -- -7
		  "0100000" when "1010", -- -6
		  "0100100" when "1011", -- -5
		  "1001100" when "1100", -- -4
		  "0000110" when "1101", -- -3
		  "0010010" when "1110", -- -2
		  "1001111" when "1111", -- -1
		  "1111111" when OTHERS;

END concurrent_ssd_arch;