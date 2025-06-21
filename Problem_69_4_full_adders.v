module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum
);
    // the eaisest way to implemet a 4 bit full adder is to simply do this
    // assign sum = x + y;
    
    // for the purposes of implementing the 4 stage full adder using actual full adder implementations we do the following:
    
    // wires for internal use
    wire [3:0] cout;
    
    // full adder 1
    fadd fadd1(.a(x[0]),
               .b(y[0]),
               .cin(1'b0), // first full adder stage is driven with since no cin input
               .sum(sum[0]),
               .cout(cout[0]));
    
    // full adder 2
    fadd fadd2(.a(x[1]),
               .b(y[1]),
               .cin(cout[0]),
               .sum(sum[1]),
               .cout(cout[1]));
    
    // full adder 3
    fadd fadd3(.a(x[2]),
               .b(y[2]),
               .cin(cout[1]),
               .sum(sum[2]),
               .cout(cout[2]));
    
    // full adder 4
    fadd fadd4(.a(x[3]),
               .b(y[3]),
               .cin(cout[2]),
               .sum(sum[3]),
               .cout(sum[4])); // the last cout is driven to the last bit of sum (sum[4])
    
endmodule

// full addder instantiation
module fadd(
    input  a, b, cin,
    output sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule
