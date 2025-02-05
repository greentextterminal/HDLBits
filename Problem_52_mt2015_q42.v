module top_module ( input x, input y, output z );

    // Truth table from simulation waveform:
    // x  |  y  |  z
    // 0  |  0  |  1  
    // 0  |  1  |  0
    // 1  |  0  |  0
    // 1  |  1  |  1
    
    // From the truth table we can conclude its for a 2 input xnor gate
    assign z = ~(x ^ y);

endmodule
