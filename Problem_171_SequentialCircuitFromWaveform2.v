/*
Sim/circuit8
This is a sequential circuit. 
Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
From the behavior in the waveforms we observe the following:
output p seems to track whatever input a is during assertion of the clock
output q seems to latch whatever p is during the negative edge of the clock
*/

module top_module (
    input clock,
    input a,
    output p,
    output q 
);

  // invoking the dffs
  reg p_out, q_out;

  // modelling the first part of p output behavior (combinationl) (NOTE: we are inferring a latch here!!!)
  always @ (*) begin
    if (clock) begin // creating a level sensitive enable signal rather than using the clock edge like in a sequential circuit
      p_out = a; // p_out tracks a while the clock (level) is enabled, latch like behavior
    end
  end

  // modelling the second part of p output behavior (sequential)
  always @ (negedge clock) begin
    // latch a during the negative edge of the clock
    p_out <= p_out;
  end

  // modelling the q output behavior
  always @ (negedge clock) begin
    q_out <= p_out;
  end

  // driving the output from the dff registers
  assign p = p_out;
  assign q = q_out;

endmodule
