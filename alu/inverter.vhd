LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY inverter IS

	PORT(A: IN STD_LOGIC;
			F: OUT STD_LOGIC);
END inverter;

ARCHITECTURE inverter_arch OF inverter IS
BEGIN
	F <= NOT A;
END inverter_arch;