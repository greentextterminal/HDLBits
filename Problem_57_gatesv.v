module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
    
    // if an input bit and higher idx bit, left neighbor are both 1 then output 1 to the lower bits idx on out_both bus
    assign {out_both[2], out_both[1], out_both[0]} = { {in[3] & in[2]}, {in[2] & in[1]}, {in[1] & in[0]}};
    
    // if an input bit or lower idx bit, right neighbor are 1 then output 1 to the higher bits idx on out_any bus
    assign {out_any[3], out_any[2], out_any[1]} = { {in[3] | in[2]}, {in[2] | in[1]}, {in[1] | in[0]}}; 
    
    // if an input bit and higher idx bit, left neighbor don't match then output 1 to the lower bits idx on out_both bus
    // the bits should "wrap" around so for bit idx 3 compare with idx 0 and for this comparison assign output to idx 3
    // This is an XOR gate case
    assign {out_different[3], 
            out_different[2], 
            out_different[1], 
            out_different[0]} = { {in[0] ^ in[3]}, 
                                  {in[3] ^ in[2]}, 
                                  {in[2] ^ in[1]}, 
                                  {in[1] ^ in[0]}}; 
    
endmodule
