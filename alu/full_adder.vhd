LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY full_adder IS

	PORT(A, B, Cin: IN STD_LOGIC;
			Sum, Cout: OUT STD_LOGIC);
			
END full_adder;

ARCHITECTURE full_adder_arch OF full_adder IS

COMPONENT and_gate PORT (A, B: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
COMPONENT xor_gate_3i PORT (A, B, C: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
COMPONENT or_gate_3i PORT (A, B, C: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;

SIGNAL s1, s2, s3: STD_LOGIC;

BEGIN

--Cout <= ((A AND B) OR (A AND Cin) OR (B AND Cin));
--Sum <= A XOR B XOR Cin;

U1: and_gate PORT MAP (a, b, s1);
U2: and_gate PORT MAP (a, cin, s2);
U3: and_gate PORT MAP (b, cin, s3);
U4: or_gate_3i PORT MAP (s1, s2, s3, Cout);
U5: xor_gate_3i PORT MAP (a, b, cin, Sum);

END full_adder_arch;