module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    // Implement a sum of products in order to synthesize an arbitrary circuit from a truth table
    always @ (*) begin
        if ( (~x3 & x2 & ~x1) | 
             (~x3 & x2 & x1)  |
             (x3 & ~x2 & x1)  |
             (x3 & x2 & x1) ) begin
            f = 1'b1;
        end
        else begin
            f = 1'b0;
        end
    end

endmodule
