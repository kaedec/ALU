LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY or_gate_3i IS

	PORT(A, B, C: IN STD_LOGIC;
			F: OUT STD_LOGIC);
END or_gate_3i;

ARCHITECTURE or_gate_3i_arch OF or_gate_3i IS
BEGIN
	F <= A OR B OR C;
END or_gate_3i_arch;