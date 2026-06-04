module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q );
  
    // interal wires (specifies 3 set of 8 bit wide buses)
    wire [7:0] q1, q2, q3;
    
    // dff8 1
    my_dff8 dff8_1(.clk(clk),
                   .d(d),
                   .q(q1));
    
    // dff8 2
    my_dff8 dff8_2(.clk(clk),
                   .d(q1),
                   .q(q2));
    
    // dff8 3
    my_dff8 dff8_3(.clk(clk),
                   .d(q2),
                   .q(q3));
    
    // multiplexer
    always @ (*) begin
        case(sel)
            2'b00 : q = d;
            2'b01 : q = q1;
            2'b10 : q = q2;
            2'b11 : q = q3;   
        endcase 
    end 

endmodule
