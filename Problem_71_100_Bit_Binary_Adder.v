// Problem 71)
/*
Create a 100-bit binary adder. 
The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out.
*/

module top_module( 
    input  [99:0] a, b,
    input  cin,
    output cout,
    output [99:0] sum 
);

// 1 bit cout + 100 bit sum via concatenation -> 101 bits
// 100 bit a + 100 bit b + 1 bit cin wired into a 101 bit wide output {cout, sum}
assign {cout, sum} = a + b + cin;

endmodule
