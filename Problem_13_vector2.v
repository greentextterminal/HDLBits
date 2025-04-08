module top_module( 
    input [31:0] in,
    output [31:0] out );

    // Build a circuit that will reverse the byte ordering of the 4-byte word.
    // EX: AaaaaaaaBbbbbbbbCcccccccDddddddd => DdddddddCcccccccBbbbbbbbAaaaaaaa
    assign out[31:0] = {in[7:0],in[15:8],in[23:16],in[31:24]};
endmodule
