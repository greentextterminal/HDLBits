/*
Rotate100

Build a 100-bit left/right rotator, with synchronous load and left/right enable. A rotator shifts-in the shifted-out bit from the other end of the register, unlike a shifter that discards the shifted-out bit and shifts in a zero. If enabled, a rotator rotates the bits around and does not modify/discard them.

load: Loads shift register with data[99:0] instead of rotating.
ena[1:0]: Chooses whether and which direction to rotate.
2'b01 rotates right by one bit
2'b10 rotates left by one bit
2'b00 and 2'b11 do not rotate.
q: The contents of the rotator.
*/

/*
DFF[99], DFF[98], ... , DFF[1], DFF[0] 
For a right shift idx 0 should become idx 99
For a left shift idx 99 should become idx 0

When shifting right, the LSB will be shifted out and discarded and the MSB will be padded with a 0
When shifting left, the MSB will be shifted out and discarded and the LSB will be padded with a 0

We dont want to lose these otherwise "discarded" values, so keep them in the rotation we need to save
the discarded bit to a register

Notice the enable line exhibits XOR like behavior
*/

module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
); 
  
  always @ (posedge clk) begin
    if (load) begin
      q <= data;
    end
    else if (ena == 1) begin // rotate right by one bit
      q <= {q[0], q[99:1]};
    end
    else if (ena == 2) begin // rotate left by one bit
      q <= {q[98:0], q[99]};
    end
    else begin
      q <= q; // hold the current order of the rotator
    end
  end
endmodule
