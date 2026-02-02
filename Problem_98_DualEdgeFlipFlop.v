/*
You're familiar with flip-flops that are triggered on the positive edge of the clock, or negative edge of the clock. 
A dual-edge triggered flip-flop is triggered on both edges of the clock. 
However, FPGAs don't have dual-edge triggered flip-flops, and always @(posedge clk or negedge clk) is not accepted as a legal sensitivity list.

Build a circuit that functionally behaves like a dual-edge triggered flip-flop:
*/

module top_module (
    input clk,
    input d,
    output q
);
  /*
  The posedge clk automatically makes the flop flop positive edge clock triggered because of the (posedge clk) sensitivity list
  Need to implement a negative edge detector to get the flop to "react" to the negative edge of the clk
  */
    
    // negedge detector
    reg clk_dly;
    wire clk_negedge;
    assign clk_negedge = ~clk & clk_dly; // use the clk_negedge as the select line
    
    // for the negedge detector
    always @ (posedge clk) begin
    	clk_dly <= clk; // delayed clk signal
    end

    // create two flops to sample at different clock edges
    reg posedge_dff;
    reg negedge_dff;

    // sample d at posedge of the clk
    always @ (posedge clk) begin
    	posedge_dff <= d;
    end

    // sample d at negative of the clk
    always @ (posedge clk_negedge) begin
        negedge_dff <= d;
    end

    // multiplex the output by selecting the flop correposonding to the clk edge (clk is the select line)
    assign q = clk ? posedge_dff : negedge_dff;

endmodule
