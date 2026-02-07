/*
Sim/circuit1
This is a combinational circuit. 
Read the simulation waveforms to determine what the circuit does, then implement it.
*/

module top_module (
    input a,
    input b,
    output q 
);
  // the waveforms behavior is that of an AND gate
  assign q = a & b;

endmodule
