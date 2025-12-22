// Problem 70) Signed Addition Overflow
// assume you have two 8 bit 2's complement numbers: a[7:0] and b[7:0]
// these numbers are added to produce s[7:0]
// In 2s complement you always add, even when subtracting (you "add" a negatively expressed number)

/*
Example with 4 bit numbers
Upper bound is given by 2^(n-1)-1, @n=4 upper bound is 2^(4-1)-1=7
Lower bound is giveb by -2^(n-1),  @n=4 upper bound is -2^(4-1)=-8

+7 in 2s complement: 0111 -> 0+4+2+1=7
-8 in 2s complement:
  1) Express 8 in positive binary
    1000
  2) Invert all bits
    0111
  3) Add 1 bit
    0111
   +   1
   _____
    1000
  4) Final value is expressed as 1000
    1000 -> this value can be rexpressed as (-8)+0+0+0=-8

Testing conditions around upper and lower bounds:
-------------------------------------------------

Upper bound overflow:
a = 7
b = 8
a + b = 7 + 1
0111 + 0001 = 1000 = 8 
Overflow occurred!
Result should be positive
MSB is reserved for indicating negative numbers

Lower bound overflow
a = -8
b = -1
a + b = (-8) + (-1) = (-9)
Ooverflow occurred!
Result should be negative
MSB is reserved for indicating negative numbers, exceeded bit size and carried over into 5th bit
1000 + 1111 = (1)0111
*/

module top_module (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] s,
    output overflow
);

// capture result of a + b in s
assign s = a + b; 
  
always @ (*) begin
  if (!a[7] & !b[7] & s[7]) begin
    overflow = 1;
  end
  else if (a[7] & b[7] & !s[7]) begin
    overflow = 1;
  end
  else begin
    overflow = 0;
  end
end

endmodule
