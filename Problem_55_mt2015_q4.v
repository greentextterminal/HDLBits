module top_module (input x, input y, output z);
    // internal wires
    wire a1o, a2o, b1o, b2o;
    wire ab1_or, ab2_and;

    // first circuit a instantiation
    circuit_a a1 (.x(x),
                  .y(y),
                  .z(a1o));

    // first circuit b instantiation
    circuit_b b1 (.x(x),
                  .y(y),
                  .z(b1o));

    // second circuit a instantiation
    circuit_a a2 (.x(x),
                  .y(y),
                  .z(a2o));
  
    // second circuit b instantiation
    circuit_b b2 (.x(x),
                  .y(y),
                  .z(b2o));
    
    assign ab1_or  = a1o | b1o;        // a1 | b1 output
    assign ab2_and = a2o & b2o;        // a2 & b2 output
    assign z       = ab1_or ^ ab2_and; // final output

endmodule

module circuit_a (input x, 
                  input y, 
                  output z );
    
    // implement the function z = (x^y) & x
    assign z = (x ^ y) & x;
endmodule

module circuit_b (input x, 
                  input y, 
                  output z );

    // Truth table from simulation waveform:
    // x  |  y  |  z
    // 0  |  0  |  1  
    // 0  |  1  |  0
    // 1  |  0  |  0
    // 1  |  1  |  1
    
    // From the truth table we can conclude its for a 2 input xnor gate
    assign z = ~(x ^ y);
endmodule
