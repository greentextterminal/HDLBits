module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum 
);
    
    // Creating a 100 digit BCD ripple carry adder
    // Each digit is a number ranging from 0 to 9, by the nature of BCD any number >9 is illegal
    // Since we are only concerned with numbers ranging from 0 to 9 we will need up to 4 bits to represent a digit
    // 0: [0000], 1: [0001], ..., 9: [1001]
    // Each digit is represented by 4 bits and we need to make a 100 digit BCD ripple carry adder that adds 2 100 digit numbers
    // Therefore (4 bits per digit) * 100 digits = 400 bits, this is how we get our 400 bit vector for the inputs a and b

    // In order to manage the cout and the first cin we need to make a wire vector that is 1 + 100 bits wide (cin + 100 cout bits from each bcd_fadd)
    wire [100:0] carry;    // 101 bit wide wire vector
    assign carry[0] = cin; // assign the 1st index (0th bit) (LSB) with cin
    
    // creating 100 copies of bcd_fadd
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : bcd_fadd100_block
            bcd_fadd bcd_fadd100 (.a(a[ (i+1)*4-1 : (i*4) ]),
                                  .b(b[ (i+1)*4-1 : (i*4) ]),
                                  .cin(carry[i]),
                                  .cout(carry[i+1]),
                                  .sum(sum[ (i+1)*4-1 : (i*4) ]) 
                                 );
                                  // Need to take 4 bit slices of the inputs assign the sum 4 bits at a time
                                  // ..., [11:8], [7:4], [3:0]
                                  // @i=0 [3:0], @i=1 [7:4], @i=2 [11:8], ..., @i=99 [399:396]
        end
    endgenerate
    
    // assign the cout with the last idx value of the carry wire
    assign cout = carry[100];
    
endmodule
