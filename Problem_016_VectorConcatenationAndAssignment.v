module top_module (
    input [4:0] a, b, c, d, e, f, // 5 bits * 6 inputs  = 30 bit width
    output [7:0] w, x, y, z );    // 8 bits * 4 outputs = 32 bit width

    assign {w, x, y, z} = {a, b, c, d, e, f, 2'b11}; // 30 bits + 2 bits = 32 bits
endmodule
