module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    
    // @ sel = 0   -> out = in[3:0]
    // @ sel = 1   -> out = in[7:4]
    // .. 
    // @ sel = 255 -> out = in[1023:1020]

    // use indexed part select
    assign out = in[(sel * 4) +: 4];

endmodule
