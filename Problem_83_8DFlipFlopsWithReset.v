/*
Create 8 D flip-flops with active high synchronous reset. All DFFs should be triggered by the positive edge of clk.
*/

module top_module (
    input clk,
    input reset, // Synchronous reset
    input  [7:0] d,
    output [7:0] q
);

  genvar i;
  generate 
    for (i=0; i<8; i=i+1) begin : DFF8
      always @ (posedge clk) begin
        if (reset) begin // synchronous reset: posedge clk && posedge reset
          q[i] <= 0;
        end
        else begin
          q[i] <= d[i];
        end
      end
    end
  endgenerate

endmodule
