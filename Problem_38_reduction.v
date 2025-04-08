module top_module (
    input [7:0] in,
    output parity); 
    
    // Parity checking
    // determine parity bit for an 8 bit byte
    // parity bit will be the 9th bit and determiend by XOR'ing all the 8 data bits (use reduction operators)
    assign parity = ^in;

endmodule
