module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum);

    // internal wires
    wire lower_cout; // single wire
    wire [15:0] lower_sum, upper_sum; // 16 bit bus
    
    // lower 16 bit adder
    add16 add16_lower(.a(a[15:0]),
                      .b(b[15:0]),
                      .cin(1'b0),
                      .sum(lower_sum),
                      .cout(lower_cout));
    
    // upper 16 bit adder
    add16 add16_upper(.a(a[31:16]),
                      .b(b[31:16]),
                      .cin(lower_cout),
                      .sum(upper_sum),
                      .cout()); // leave cout unconnected since not in use
    
    // summation via concatenation
    assign sum = {{upper_sum},{lower_sum}};

endmodule
