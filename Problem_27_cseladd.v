module top_module(
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum);
  
    // wires
    wire lower_cout; // this will act as the sel line for our multiplexer
    wire [15:0] lower_sum, upper_sum_cin0, upper_sum_cin1;

    // lower 16 bit adder
    add16 add16_lower(.a(a[15:0]),
                      .b(b[15:0]),
                      .cin(1'b0), // no carry in
                      .sum(lower_sum),
                      .cout(lower_cout));
    
    // upper 16 bit adder with no cin
    add16 add16_upper_cin0(.a(a[31:16]),
                           .b(b[31:16]),
                           .cin(1'b0), // no cin
                           .sum(upper_sum_cin0),
                           .cout()); // leave unconnected since not in use
    
    // upper 16 bit adder with cin
    add16 add16_upper_cin1(.a(a[31:16]),
                           .b(b[31:16]),
                           .cin(1'b1), // with cin
                           .sum(upper_sum_cin1),
                           .cout()); // leave unconnected since not in use
    
    // multiplexer to select which adders output to use based on lower_cout select line
    always @ (*) begin
        case (lower_cout) 
            // output 32 bit sum via concatenation
            1'b0: sum = {upper_sum_cin0, lower_sum}; // no cin sum
            1'b1: sum = {upper_sum_cin1, lower_sum}; // w/ cin sum
        endcase 
    end
    
endmodule
