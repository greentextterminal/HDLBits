module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    // Build a 4 bit priority encoder
  
    // Solution 1)
    // one solutiuon is to have a bunch of case statements numerically ordered from 0 to highest value (unoptimal and verbose solution).
    // This solutions leverages the fact that much like a case statement in C, only the first case match is executed.
    // The drawbacks of this approach are a lot typing for the 16 (decimal value) cases, and manually assigning the first high bit idx which 
    // is obtained by translating decimal values into their binary equivalents and finding the first 1 bit
    // (Ex: decimal 4'd12 is 4'b1100, therefore the first 1 is at bit idx 2)
    // always @ (*) begin
    //    case (in)
    //        4'd1  : pos = 0;
    //        4'd2  : pos = 1;
    //        4'd3  : pos = 0;
    //        4'd4  : pos = 2;
    //        4'd5  : pos = 0;
    //        4'd6  : pos = 1;
    //        4'd7  : pos = 0;
    //        4'd8  : pos = 3;
    //        4'd9  : pos = 0;
    //        4'd10 : pos = 1;
    //        4'd11 : pos = 0;
    //        4'd12 : pos = 2;
    //        4'd13 : pos = 0;
    //        4'd14 : pos = 1;
    //        4'd15 : pos = 0;
    //        4'd16 : pos = 0;  
    //        default : pos = 0;
    //    endcase 
    //end

    // Solution 2)
    // if-else executes line by line and uses the first one thats true
    // Since we scan for the first 1 from LSB to MSB we can structure our if else statement from bit[0] to bit[n] (this order is important for functionality!)
    // Functionally equivalent to a C switch statement, where the first case match is executed
    // The benefits of this approach are less typing and that the bit idx we are checking is the bit idx we output (no need to manually find and assign the bit idx)
    always @ (*) begin
        if (in[0])
            pos = 0;
        else if (in[1])
            pos = 1;
        else if (in[2])
            pos = 2;
        else if (in[3])
            pos = 3;
        else 
            pos = 0; // this is our 'default' case to prevent latches
    end
	

endmodule
