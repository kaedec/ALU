LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY xor_struct IS

	PORT(A, B: IN STD_LOGIC;
			F: OUT STD_LOGIC);
END xor_struct;

ARCHITECTURE xor_struct_arch OF xor_struct IS

--Component Declarations

	COMPONENT inverter PORT(A: IN STD_LOGIC;
									F: OUT STD_LOGIC);
	END COMPONENT;
				
				
	COMPONENT and_gate PORT(A, B: IN STD_LOGIC;
									F: OUT STD_LOGIC);
	END COMPONENT;
	
	
	COMPONENT or_gate PORT(A, B: IN STD_LOGIC;
									F: OUT STD_LOGIC);
	END COMPONENT;
	
--Signal Declarations

	SIGNAL s1, s2, s3, s4: STD_LOGIC;

BEGIN

--Component Instantiations
	--By Name
	U1: inverter PORT MAP(A => A, F => s1);
	U2: inverter PORT MAP(A => B, F => s2);
	U3: and_gate PORT MAP(A => s1, B => B, F => s3);
	U4: and_gate PORT MAP(A => s2, B => A, F => s4);
	U5: or_gate PORT MAP(A => s3, B => s4, F => F);
	
	--By Position
	--U1: inverter PORT MAP(A, s1);
	--U2: inverter PORT MAP(B, s2);
	--U3: and_gate PORT MAP(s1, B, s3);
	--U4: and_gate PORT MAP(s2, A, s4);
	--U5: or_gate PORT MAP(s3, s4, F);
	
END xor_struct_arch;