LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY or_gate IS

	PORT(A, B: IN STD_LOGIC;
			F: OUT STD_LOGIC);
END or_gate;

ARCHITECTURE or_gate_arch OF or_gate IS
BEGIN
	F <= A OR B;
END or_gate_arch;