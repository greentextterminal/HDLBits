
module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );

    // if an input bit and higher idx bit, left neighbor are both 1 then output 1 to the lower bits idx on out_both bus
    genvar a;
    generate
        for (a = 0; a < 100 - 1; a = a + 1) begin : both
            assign out_both[a] = in[a + 1] & in[a];
        end 
    endgenerate
    
    // if an input bit or lower idx bit, right neighbor are 1 then output 1 to the higher bits idx on out_any bus
    genvar b;
    generate
        for (b = 99; b > 0; b = b - 1) begin : any
            assign out_any[b] = in[b] | in[b - 1];
        end 
    endgenerate
    
    // if an input bit and higher idx bit, left neighbor don't match then output 1 to the lower bits idx on out_both bus
    // the bits should "wrap" around so for bit idx 99 compare with idx 0 and for this comparison assign output to idx 99
    // This is an XOR gate case
    genvar c;
    generate
        for (c = 0; c < 100 - 1; c = c + 1) begin : different
            assign out_different[c] = in[c + 1] ^ in[c];
        end 
    endgenerate
    
    // handle the wrap around case with a direct assign statement
    assign out_different[99] = in[0] ^ in[99];
    
endmodule
