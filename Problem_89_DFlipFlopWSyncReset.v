/*
Implement the circuit:
    ___________
---| D       Q |---
   |           |
---|>    R     |
   |_____|_____|
         |
        
Note: this is a D Flip Flop (DFF) with an synchronous reset
*/

module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q
);
  // to get a synchronous reset it needs to be in the always block so that reset is sampled during a clk edge
  always @ (posedge clk) begin
    if (r) begin
      q <= 0; 
    end
    else begin
      q <= d;
    end
  end

endmodule
