module top_module( 
    input a, b, cin,
    output cout, sum );
    
    // Truth Table
    // a | b | cin | sum | cout
    // 0 | 0 |  0  |  0  |  0  
    // 0 | 0 |  1  |  1  |  0
    // 0 | 1 |  0  |  1  |  0
    // 0 | 1 |  1  |  0  |  1  
    // 1 | 0 |  0  |  1  |  0
    // 1 | 0 |  1  |  0  |  1
    // 1 | 1 |  0  |  0  |  1
    // 1 | 1 |  1  |  1  |  1
    
    // from Truth Table the lines below can be derived
    // assign sum  = a + b + cin;
    // assign cout = (a & b) | (a & cin) | (b & cin);
    
    // the optimized approach is to concatenate the cout and sum and assign it with the sum of the inputs
    assign {cout, sum} = a + b + cin;

endmodule
