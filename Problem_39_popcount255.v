module top_module( 
    input [254:0] in,  // 255 bit input vector
    output [7:0] out );

    // Building a "population count" circuit to count the number of 1's in an input vector
    // In this solution we are using a for loop to check all 255 bit indices for a 1 bit value
    // If the bit index contains a 1 we increment our out variable
    // It is important to remember that we must initialize our out to 0 to prevent inferring a latch if for instance an all 0 input is provided
    
    reg [7:0] i; // declare incrementer
    always @ (*) begin
        out = 0; // initialize out to 0 prevent latches
        for (i = 0; i < 255; i = i + 1) begin
            if (in[i] == 1) begin
               out = out + 1'd1;
            end
        end
    end
endmodule
