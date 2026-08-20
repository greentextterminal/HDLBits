/*
Sim/circuit6
This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
Based on the waveforms, there appears to be a direct mapping to a 4 hex value.
For every input of a between 0 and 8, there exists a specific 4 hex value.
*/

module top_module (
    input [2:0] a,
    output [15:0] q 
); 

  // a hex character consists of 4 bits, our output values consist of 4
  // 4 * 4 = 16 bits needed to represent the values
  localparam [15:0] val0 = 16'h1232,
                    val1 = 16'haee0,
                    val2 = 16'h27d4,
                    val3 = 16'h5a0e,
                    val4 = 16'h2066,
                    val5 = 16'h64ce,
                    val6 = 16'hc526,
                    val7 = 16'h2f19,
                    val_default = 16'h0;

  always @ (*) begin
    case (a) 
      4'd0: q = val0;
      4'd1: q = val1;
      4'd2: q = val2;
      4'd3: q = val3;
      4'd4: q = val4;
      4'd5: q = val5;
      4'd6: q = val6;
      4'd7: q = val7;
      default: q = val_default;
    endcase
  end
    
endmodule
