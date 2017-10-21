LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY xor_gate_3i IS

	PORT(A, B, C: IN STD_LOGIC;
			F: OUT STD_LOGIC);
END xor_gate_3i;

ARCHITECTURE xor_gate_3i_arch OF xor_gate_3i IS
BEGIN
	F <= A XOR B XOR C;
END xor_gate_3i_arch;