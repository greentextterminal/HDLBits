/*
Shift18
Build a 64-bit arithmetic shift register, with synchronous load. The shifter can shift both left and right, and by 1 or 8 bit positions, selected by amount.

An arithmetic right shift shifts in the sign bit of the number in the shift register (q[63] in this case) instead of zero as done by a logical right shift. Another way of thinking about an arithmetic right shift is that it assumes the number being shifted is signed and preserves the sign, so that arithmetic right shift divides a signed number by a power of two.

There is no difference between logical and arithmetic left shifts.

load: Loads shift register with data[63:0] instead of shifting.
ena: Chooses whether to shift.
amount: Chooses which direction and how much to shift.
2'b00: shift left by 1 bit.
2'b01: shift left by 8 bits.
2'b10: shift right by 1 bit.
2'b11: shift right by 8 bits.
q: The contents of the shifter.
*/

module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg signed [63:0] q // changed q to signed type to get it to work with the >>> operator
);

  always @ (posedge clk) begin
    if (load) begin
      q <= data;
    end
    else if (ena) begin // chooses whether we shift or not
      if (amount == 0) begin // shift left by 1 bit
        q <= q << 1; // zeros are auto padded using this method
      end
      else if (amount == 1) begin // shift left by 8 bits
        q <= q << 8; // zeros are auto padded using this method
      end
      else if (amount == 2) begin // arithmetic shift right by 1
        q <= q >>> 1;
      end
      else if (amount == 3) begin // arithmetic shift right by 8
        q <= q >>> 8;
      end
    end
    else begin
      q <= q; // hold the current data otherwise
    end
  end

endmodule
