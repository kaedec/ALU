# ALU
CPE 462 Midterm Project for implementation onto Altera DE2-115 Cyclone IV E FPGA
https://github.com/kaedec/ALU

Usage is as follows:

Input A: Switches 3 down to 0
Input B: Switches 8 down to 5
Operation Select: Switches 15 down to 13
Carry/Borrow in: Switch 17

Inputs and Outputs will be displays as follows:

Inputs
A: Hex displays 7 and 6
B: Hex displays 5 and 4
Carry/Borrow in: Green LED 8

Outputs
C: Green LEDs 3 down to 0, as well as hex displays 1 and 0
Carry/Borrow out: Green LED 5, as well as hex display 2
Overflow: Green LED 7, as well as hex display 3

The basic operations to be selected with switches 15 down to 13 are as follows:

000: Pass
001: Addition
010: Subtraction
011: Logical OR
100: Logical XOR
101: Arithmetic Shift Right
110: Logical Shift Left
111: Rotate Right

See the requirements.png file for more details.