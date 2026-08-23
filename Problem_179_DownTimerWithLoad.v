/*
Cs450/timer
*/

module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

  // declare wires
  wire zero_hit;
  
  // declare reg
  reg [9:0] count;

  // monitor for 0 by via comparator
  assign zero_hit = (count == 0) ? 1 : 0;

  // drive tc with monitor
  assign tc = zero_hit;

  // always block to load the down count reg
  always @ (posedge clk) begin
    // load the count reg with data once load goes high
    if (load) begin
      count <= data;
    end
    else if (zero_hit) begin
      count <= 0;
    end
    else begin
      // decrement
      count <= count - 1;
    end
  end

endmodule
