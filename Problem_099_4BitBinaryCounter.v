/*
Count15
Build a 4-bit binary counter that counts from 0 through 15, inclusive, with a period of 16. 
The reset input is synchronous, and should reset the counter to 0.
*/

module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q
);

  // register to hold the count
  reg [3:0] count; 

  // output to q
  assign q = count;
  
  always @ (posedge clk) begin
    // reset the count if reset
    if (reset) begin
      count <= 4'h0;
    end
    // increment the count
    else begin
      count <= count + 1'b1;
    end
  end

endmodule
