/*
Create 8 D flip-flops with active high asynchronous reset. All DFFs should be triggered by the positive edge of clk.
*/

module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);

  // by keeping the areset in the sensitivity list you achieve asynchronous behavior
  always @ (posedge clk or posedge areset) begin
    if (areset) begin
      q <= 8'h00;
    end
    else begin
      q <= d;
    end
  end

endmodule
