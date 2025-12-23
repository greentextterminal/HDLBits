// Problem 73)
/*
Turn the K-Map into code.
The 4 adjacent 1's (quad) is the term: A
The two middles 1's on the left side is the term: !AC
The two 1's on the bottom left side is the term: !AB
Therefore the final equation is: A+!AC+!AB
Simplified the equation becomes: A+!A(C+B)
*/

module top_module(
    input  a,
    input  b,
    input  c,
    output out  
); 
assign out = a | !a & (c | b);
endmodule
