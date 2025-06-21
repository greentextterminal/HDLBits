module top_module( 
    input a, b,
    output cout, sum 
);
    
    // Truth Table
    // a | b | s | c
    // 0 | 0 | 0 | 0
    // 0 | 1 | 1 | 0
    // 1 | 0 | 1 | 0
    // 1 | 1 | 0 | 1
    
    assign sum  = a + b;
    assign cout = a & b;

endmodule
