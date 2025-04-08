module top_module (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum);

    // wires for 16bit adders
    wire lower_cout;
    wire [15:0] lower_sum, upper_sum; // 16 bit bus for 16b adders

    // lower 16 bit adder
    add16 add16_lower(.a(a[15:0]),
                      .b(b[15:0]),
                      .cin(1'b0), // no cin
                      .sum(lower_sum),
                      .cout(lower_cout)); // carry out 

    // upper 16 bit adder
    add16 add16_upper(.a(a[31:16]),
                      .b(b[31:16]),
                      .cin(lower_cout),
                      .sum(upper_sum),
                      .cout()); // leaving cout unoconnected since not in use

    // creating 32 bit summation from the 2 16b adders via concatenation
    assign sum = {upper_sum, lower_sum};
endmodule

// 16 add1's needed to construct 1 add16 module
module add1 ( input a, input b, input cin, output sum, output cout );
	// Full adder module here
    wire [1:0] temp_sum;
    assign temp_sum = a + b + cin;
    assign sum  = temp_sum[0]; // sum from first bit
    assign cout = temp_sum[1]; // carry out from second bit
endmodule
