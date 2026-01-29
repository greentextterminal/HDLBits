/*
exams/ece241_2014_q4
*/

module top_module (
    input clk,
    input x,
    output z
); 
  // declaring gate output wires
  wire xor_out, and_out, or_out;
  // declaring DFF output wires
  wire dff_out1, dff_out2, dff_out3;
  
  // xor gate
  assign xor_out = x ^ dff_out1;
  // and gate
  assign and_out = x & !dff_out2;
  // or gate
  assign or_out = x | !dff_out3;
  
  // describing the dff
  always @ (posedge clk) begin
    dff_out1 <= xor_out;
    dff_out2 <= and_out;
    dff_out3 <= or_out;
  end

  // nor gate (final output)
  assign z = !(dff_out1 | dff_out2 | dff_out3); 
endmodule
