/*
Shift4

Build a 4-bit shift register (right shift), with asynchronous reset, synchronous load, and enable.

areset: Resets shift register to zero.
load: Loads shift register with data[3:0] instead of shifting.
ena: Shift right (q[3] becomes zero, q[0] is shifted out and disappears).
q: The contents of the shift register.
If both the load and ena inputs are asserted (1), the load input has higher priority.
*/

module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

  // async active high reset
  always @ (posedge clk or posedge areset) begin
    if (areset) begin
      q <= 4'h0;
    end
    else if (load) begin // load takes higher priority than ena
      q <= data;
    end
    else if (ena) begin
      q <= q >> 1; // shift the dat right by 1 bit
    end
  end

endmodule
