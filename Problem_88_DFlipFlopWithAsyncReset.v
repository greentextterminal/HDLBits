/*
Implement the circuit:
    ___________
---| D       Q |---
   |           |
---|>    AR    |
   |_____|_____|
         |
        
Note: this is a D Flip Flop (DFF) with an async reset
*/

module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q
);
  // to get an async reset it needs to be part of the sensitivity list
  always @ (posedge clk or posedge ar) begin
    if (ar) begin
      q <= 0; 
    end
    else begin
      q <= d;
    end
  end

endmodule
