module top_module( 
    input [99:0] in,
    output out_and, // output of a 100-input AND gate
    output out_or,  // output of a 100-input OR gate
    output out_xor  // output of a 100-input XOR gate
);
	  // Reduction operators are great in instances where you need high input gate functionality
    // With a reduction operator you can operate on every bit in a vector with the same operation specified in the reduction operator
    assign out_and = &in;
    assign out_or  = |in;
    assign out_xor = ^in;    
    
endmodule
