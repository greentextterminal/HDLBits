/*
Implement the circuit:
    ___________
---| D       Q |---
   |           |
---| Ena       |
   |___________|

Note: this is a latch, so expect the synthesizer to throw a warning 
*/

module top_module (
    input d, 
    input ena,
    output q
);

  always @ (*) begin
    if (ena) begin
      q = d;
    end
    else begin
      q = q;
    end
  end

endmodule
