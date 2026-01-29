/*
Create 16 D flip-flops. It's sometimes useful to only modify parts of a group of flip-flops. 
The byte-enable inputs control whether each byte of the 16 registers should be written to on that cycle. 
byteena[1] controls the upper byte d[15:8], while byteena[0] controls the lower byte d[7:0].

resetn is a synchronous, active-low reset.

All DFFs should be triggered by the positive edge of clk.
*/

module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
  // if byteena is decimal 0 : do nothing
  // if byteena is decimal 1: write to lower byte
  // if byteena is decimal 2: write to upper byte
  // if byteena is decimal 3: write to upper and lower byte

  always @ (posedge clk) begin
    // synchronous active low reset
    if (!resetn) begin
      q <= 16'h0000;
    end
    // the byte control could be triggered independently (upper/lower) or in parallel
    else begin
      // byteena[1] controls upper byte d[15:8] 
      if (byteena[1]) begin
        q[15:8] <= d[15:8];
      end
      // byteena[0] controls lower byte d[7:0] 
      if (byteena[0]) begin
        q[7:0] <= d[7:0];
      end
    end
  end

endmodule
