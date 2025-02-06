module top_module( 
    input [2:0] in,
    output [1:0] out );
    
    // Population count circuit to determine number of 1's in a 3 bit input vecotr
    assign out = in[0] + in[1] + in[2];
endmodule
