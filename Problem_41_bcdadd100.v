module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    // Creating a 100 digit BCD ripple carry adder
    // Each digit is a number ranging from 0 to 9, by the nature of BCD any number >9 is illegal
    // Since we are only concerned with numbers ranging from 0 to 9 we will need up to 4 bits to represent a digit
    // 0: [0000], 1: [0001], ..., 9: [1001]
    // If each digit is represented by 4 bits and need to make a 100 digit BCD ripple carry adder that adds 2 100 digit numbers
    // Therefore (4 bits per digit) * 100 digits = 400 bits, this is how we get our 400 bit vector for the inputs a and b

endmodule

module bcd_rca100(
    input [] a, 
    input
    input
    output
    output);
    // creating 100 copies of bcd_fa
    genvar i
    generate
        for (i = 0; i < 100; i = i + 1) begin
            
        end
    endgenerate
    
endmodule
