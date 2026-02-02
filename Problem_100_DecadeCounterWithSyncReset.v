/*
Count10
Build a decade counter that counts from 0 through 9, inclusive, with a period of 10. 
The reset input is synchronous, and should reset the counter to 0.
*/

module top_module (
    input clk,
    input reset, // Synchronous active-high reset
    output [3:0] q
);

  // register to hold the count
  reg [3:0] count;

  // driving q with count
  assign q = count;

  always @ (posedge clk) begin
    if (reset | (count==4'd9)) begin // reset counter to 0 once we hit 9
      count <= 4'h0;
    end
    else begin
      count <= count + 1'b1;
    end
  end
       
endmodule
