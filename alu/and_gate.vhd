LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY and_gate IS

	PORT(A, B: IN STD_LOGIC;
			F: OUT STD_LOGIC);
END and_gate;

ARCHITECTURE and_gate_arch OF and_gate IS
BEGIN
	F <= A AND B;
END and_gate_arch;