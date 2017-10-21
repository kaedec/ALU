--Library Declarations
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------------------------

------------------------------------------------------
--Entity Declaration
ENTITY alu IS
	GENERIC(N: INTEGER := 4);
	PORT(A_BUS, B_BUS: IN SIGNED(N-1 DOWNTO 0); 					--Inputs
		  F_BUS: IN STD_LOGIC_VECTOR(2 DOWNTO 0);			 		--Select
		  CBin: IN STD_LOGIC;									 		--Carry/Borrow In
		  C_BUS: OUT SIGNED(N-1 DOWNTO 0);		 					--Output
		  CBout: OUT STD_LOGIC;								    		--Carry/Borrow Out
		  A_SSD, B_SSD, C_SSD: OUT STD_LOGIC_VECTOR(0 TO 6);	--Hex Decimal Displays
		  A_NEG, B_NEG, C_NEG: OUT STD_LOGIC_VECTOR(0 TO 6);	--Hex Negative Displays
		  OVERFLOW: OUT STD_LOGIC);									--Overflow
END alu;
------------------------------------------------------

------------------------------------------------------
--Architecture
ARCHITECTURE alu_arch OF alu IS

CONSTANT N_USER: INTEGER := 4;
------------------------------------------------------
--Component Declarations
--SSD display component
COMPONENT concurrent_ssd 
	PORT(S: IN UNSIGNED(3 DOWNTO 0);
			F: OUT UNSIGNED(0 TO 6));
END COMPONENT;

--Generic RCA for use in arithmetic operations in this project
COMPONENT scalable_rca
	GENERIC(N: INTEGER := 4);
	PORT(A, B: IN SIGNED(N-1 DOWNTO 0);
			C0: IN STD_LOGIC;
			S: OUT SIGNED(N-1 DOWNTO 0);
			Clast, OV: OUT STD_LOGIC);
END COMPONENT;
------------------------------------------------------
BEGIN

A_sevensegs: concurrent_ssd PORT MAP(A_BUS, A_SSD);
B_sevensegs: concurrent_ssd PORT MAP(B_BUS, B_SSD);
C_sevensegs: concurrent_ssd PORT MAP(C_BUS_Signal, C_SSD);

Addition: scalable_rca GENERIC MAP(N_USER) PORT MAP (A_BUS, B_BUS, CBin

--C_BUS assignment
WITH F_BUS SELECT
	C_BUS <= A_BUS WHEN "000",
			<= A_BUS + B_BUS WHEN "001",
END alu_arch;