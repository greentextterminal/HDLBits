/*
You're familiar with flip-flops that are triggered on the positive edge of the clock, or negative edge of the clock. 
A dual-edge triggered flip-flop is triggered on both edges of the clock. 
However, FPGAs don't have dual-edge triggered flip-flops, and always @(posedge clk or negedge clk) is not accepted as a legal sensitivity list.

Build a circuit that functionally behaves like a dual-edge triggered flip-flop:
*/

module top_module (
    input clk,
    input d,
    output q
);
  /*
  The posedge clk automatically makes the flop flop positive edge clock triggered because of the (posedge clk) sensitivity list
  Need to implement a negative edge detector to get the flop to "react" to the negative edge of the clk
  */
  // negative edge detector
  reg clk_dly;
  wire clk_negedge;
  assign clk_negedge = ~clk & clk_dly;

  reg posedge_clk_dff;
  reg negedge_clk_dff;

  assign q = clk_negedge ? negedge_clk_dff : posedge_clk_dff;
  
  always @ (posedge clk) begin
    clk_dly <= clk;
    posedge_clk_dff <= d;
    if (clk_negedge) begin
      negedge_clk_dff <= d;
    end
  end

endmodule
