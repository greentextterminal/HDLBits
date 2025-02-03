module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    
    // 2 input (in1, in2) XOR gate with inverted output feeding into another XOR gate and third signal (in3)
    wire not_xor_out;
    assign not_xor_out = ~(in1 ^ in2);
    assign out = not_xor_out ^ in3; 

endmodule
