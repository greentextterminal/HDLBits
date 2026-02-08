/*
Sim/circuit7
This is a sequential circuit. 
Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
The behavior of the output in the waveforms:
q is asserted when a is 0
q is deasserted when a is 1
*/

module top_module (
    input clk,
    input a,
    output q 
);

  // creating the dff
  reg out;

  // capturing the logic in the waveforms
  always @ (posedge clk) begin
    if (a) begin 
      out <= 0; // deassert q when a is 1
    end
    else begin
      out <= 1;
    end
  end

  // driving the output with the register
  assign q = out;

endmodule
