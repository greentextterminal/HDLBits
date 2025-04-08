module top_module (input x, 
                   input y, 
                   output z
);

    // implement the function z = (x^y) & x
    assign z = (x ^ y) & x;
endmodule
