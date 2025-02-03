module top_module (
    input in1,
    input in2,
    output out
);
    
    // AND gate with in2 inverted
    assign out = in1 & (~in2);
endmodule
