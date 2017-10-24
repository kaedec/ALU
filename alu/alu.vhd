--Library Declarations
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
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
		  OV_SEG: OUT STD_LOGIC_VECTOR(0 TO 6);					--Hex Overflow Display
		  CBout_SEG: OUT STD_LOGIC_VECTOR(0 TO 6);				--Hex Carry/Borrow Out
		  CBin_LED: OUT STD_LOGIC;										--LED Carry/Borrow In
		  OVERFLOW: OUT STD_LOGIC);									--Overflow
END alu;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--Architecture
ARCHITECTURE alu_arch OF alu IS

--DECLARATIONS
CONSTANT N_USER: INTEGER := 4;
SIGNAL C_BUS_Signal: SIGNED(N_USER-1 DOWNTO 0);
SIGNAL OVSignal: STD_LOGIC;
SIGNAL CBoutsignal: STD_LOGIC;

--Intermediary signals for Addition and Subtraction operations
SIGNAL B_BUS_Cmpl, Sum_add, Sum_sub, Sum_subtemp, temp: SIGNED(N-1 DOWNTO 0);
SIGNAL CBout_add, CBout_sub, OV_add, OV_sub: STD_LOGIC;
SIGNAL CBin_sub: STD_LOGIC_VECTOR(0 TO 0);

--Intermediary signals for logical shift left operation
SIGNAL A_shift_bfore: SIGNED(N_USER-1 DOWNTO 0);
SIGNAL A_shift_after: SIGNED(N_USER-1 DOWNTO 0);
SIGNAL shift_ov_temp: STD_LOGIC_VECTOR(0 TO 1);
SIGNAL shift_ov_test: STD_LOGIC;

-------------------------------------------------------------------------------
--Component Declarations
--SSD display component

COMPONENT concurrent_ssd 
	PORT(S: IN SIGNED(3 DOWNTO 0);
			F: OUT STD_LOGIC_VECTOR(0 TO 6));
END COMPONENT;

COMPONENT ssd_negs
	PORT(S: IN SIGNED(3 DOWNTO 0);
			F: OUT STD_LOGIC_VECTOR(0 TO 6));
END COMPONENT;

--Generic RCA for use in arithmetic operations in this project
COMPONENT scalable_rca
	GENERIC(N: INTEGER := 4);
	PORT(A, B: IN SIGNED(N-1 DOWNTO 0);
			C0: IN STD_LOGIC;
			S: OUT SIGNED(N-1 DOWNTO 0);
			Clast, OV: OUT STD_LOGIC);
END COMPONENT;

-------------------------------------------------------------------------------
--BEHAVIOR

BEGIN

temp <= NOT B_BUS;

B_BUS_Cmpl <= temp+1 WHEN CBin = '0' ELSE
				  temp WHEN CBin = '1';

				  
				  
A_sevensegs: concurrent_ssd PORT MAP(A_BUS, A_SSD);
B_sevensegs: concurrent_ssd PORT MAP(B_BUS, B_SSD);
C_sevensegs: concurrent_ssd PORT MAP(C_BUS_Signal, C_SSD);

A_negsegs: ssd_negs PORT MAP(A_BUS, A_NEG);
B_negsegs: ssd_negs PORT MAP(B_BUS, B_NEG);
C_negsegs: ssd_negs PORT MAP(C_BUS_Signal, C_NEG);

CBin_LED <= CBin;

WITH OVSignal SELECT
	OV_SEG <= "1001111" WHEN '1',
				 "0000001" WHEN '0',
				 "1111111" WHEN OTHERS;
				 
WITH CBoutsignal SELECT
	CBout_SEG <= "1001111" WHEN '1',
					 "0000001" WHEN '0',
					 "1111111" WHEN OTHERS;



Addition: scalable_rca GENERIC MAP(N_USER) PORT MAP (A_BUS, B_BUS, CBin, Sum_add, CBout_add, OV_add);
Subtract: scalable_rca GENERIC MAP(N_USER) PORT MAP (A_BUS, B_BUS_Cmpl, '0', Sum_subtemp, CBout_sub, OV_sub);
--CBin_sub(0) <= CBin;
Sum_sub <= Sum_subtemp;-- - SIGNED(CBin_sub);



A_shift_bfore <= A_BUS;
shift_ov_temp(0) <= A_shift_bfore(N_USER-1);
A_shift_after <= A_BUS SLL 2;
shift_ov_temp(1) <= A_shift_after(N_USER-1);
shift_ov_test <= shift_ov_temp(0) XOR shift_ov_temp(1);

--C_BUS assignment
WITH F_BUS SELECT
	C_BUS_Signal <= A_BUS 						WHEN "000",
						 Sum_add 					WHEN "001",
						 Sum_sub 					WHEN "010",
						 A_BUS OR B_BUS 			WHEN "011",
						 A_BUS XOR B_BUS 			WHEN "100",
						 SHIFT_RIGHT(A_BUS, 3)	WHEN "101",
						 A_BUS SLL 2 				WHEN "110",
						 A_BUS ROL 3 				WHEN "111",
						 UNAFFECTED 				WHEN OTHERS;

--CBout assignment			
WITH F_BUS SELECT
	CBoutsignal <= CBout_add 			WHEN "001",
						CBout_sub 			WHEN "010",
						A_BUS(N_USER-1) 	WHEN "110",
						CBin 					WHEN OTHERS;
				
--OVERFLOW assignment
WITH F_BUS SELECT
	OVSignal <= OV_add 			WHEN "001",
					OV_sub 			WHEN "010",
					shift_ov_test 	WHEN "110",
					'0'				WHEN OTHERS;
					
C_BUS <= C_BUS_Signal;
CBout <= CBoutsignal;
OVERFLOW <= OVSignal;

END alu_arch;