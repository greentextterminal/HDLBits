module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum);
  
    // internal wires
    wire lower_cout; // cout from lower 16b adder
    wire [15:0] lower_sum, upper_sum;
    wire [31:0] b_xor_out;
    
    // infer a multiplexer via if statments; this determines the 32 bit b group input
    // b_xor_out becomes the new b signal
    always @ (*) 
        begin
            if (sub == 1'b1)
                begin
                    b_xor_out = b ^ {32{1'b1}}; // b XOR with sub (1)
                end
        	else 
                begin
                    b_xor_out = b;
                end    
        end
  
    // lower 16b adder
    add16 add16_lower(.a(a[15:0]),
                      .b(b_xor_out[15:0]),
                      .cin(sub), // sub is cin
                      .sum(lower_sum),
                      .cout(lower_cout)); // cout from lower adder
    
    // upper 16b adder
    add16 add16_upper(.a(a[31:16]),
                      .b(b_xor_out[31:16]),
                      .cin(lower_cout),
                      .sum(upper_sum),
                      .cout()); // leave unconnected since no cout needed
    
    // create sum via concatenation 
    assign sum = {upper_sum,lower_sum};
    
endmodule
