LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ssd_negs IS

	PORT(S: IN SIGNED(3 DOWNTO 0);
			F: OUT STD_LOGIC_VECTOR(0 TO 6));
END ssd_negs;

ARCHITECTURE ssd_negs_arch OF ssd_negs IS

BEGIN

WITH S(3) SELECT
	F <= "1111110" when '1',			-- Negative Numbers
		  "1111111" when OTHERS; 		-- Posiive Numbers and Others

END ssd_negs_arch;