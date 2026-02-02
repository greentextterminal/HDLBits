/*
Count1to10
Make a decade counter that counts 1 through 10, inclusive. 
The reset input is synchronous, and should reset the counter to 1.
*/

module top_module (
    input clk,
    input reset,
    output [3:0] q
);

  // register to hold the count
  reg [3:0] count; 

  // drive output with count
  assign q = count;

  always @ (posedge clk) begin
    if (reset || (count==10)) begin
      count <= 1;
    end
    else begin
      count <= count + 1;
    end
  end
endmodule
