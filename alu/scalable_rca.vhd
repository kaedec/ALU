LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY scalable_rca IS
	GENERIC(N: INTEGER := 4);
	PORT(A, B: IN SIGNED(N-1 DOWNTO 0);
			C0: IN STD_LOGIC;
			S: OUT SIGNED(N-1 DOWNTO 0);
			Clast, OV: OUT STD_LOGIC);
END scalable_rca;

ARCHITECTURE scalable_rca_arch OF scalable_rca IS

COMPONENT and_gate PORT (A, B: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT inverter PORT(A: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT or_gate PORT(A, B: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT xor_struct PORT (A, B: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT xor_gate_3i PORT (A, B, C: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT or_gate_3i PORT (A, B, C: IN STD_LOGIC; F: OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT full_adder PORT (A, B, Cin: IN STD_LOGIC; Sum, Cout: OUT STD_LOGIC);
	END COMPONENT;
	
SIGNAL carries: STD_LOGIC_VECTOR(N DOWNTO 0);
SIGNAL Clastov: STD_LOGIC;

BEGIN

carries(0) <= C0;

genloop: FOR i IN 0 TO N-1 GENERATE
	Ui: full_adder PORT MAP(A(i), B(i), carries(i), S(i), carries(i+1));
END GENERATE genloop;

U5: xor_struct PORT MAP(carries(N-1), carries(N), Clastov);

Clast <= carries(N);
OV <= Clastov;

END scalable_rca_arch;