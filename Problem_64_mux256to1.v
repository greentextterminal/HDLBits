module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );
    
    // 256 bit wide input, 1 bit ouput
    // @ sel=0   -> out = in[0]
    // @ sel=1   -> out = in[1]
    // ...
    // @ sel=255 -> out = in[255]
    
    assign out = in[sel];
    
endmodule
