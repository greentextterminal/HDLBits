/*
You're familiar with flip-flops that are triggered on the positive edge of the clock, or negative edge of the clock. 
A dual-edge triggered flip-flop is triggered on both edges of the clock. 
However, FPGAs don't have dual-edge triggered flip-flops, and always @(posedge clk or negedge clk) is not accepted as a legal sensitivity list.

Build a circuit that functionally behaves like a dual-edge triggered flip-flop:
*/

/*
The design implemented is as follows:

Negative edge detector circuit:
                   __________        ______
       ------clk-->|NOT GATE|--~clk->|    |
       |           |________|        |AND |----> clk_negedge
       |     _______                 |GATE|
       ----->|     |----clk_dly----->|____|
clk ---|     | DFF |
       ----->|>    |
             |_____| 


Dual edge flip flop circuit:
                            ___________
                       D--->|         |
        ________________    | posedge |                       
        | clk negative |    | clk DFF |---posedge_dff---      __________
clk---->| edge detector|--->|>        |                |      |        |
     |  |______________|    |_________|                |----->|1       |
     |                      ___________                       |   MUX  |----> q
     |                 D--->|         |                |----->|0       |
     |                      | negedge |                |      |___sel__|
     |                      | clk DFF |---negedge_dff---           |
     ---------clk---------->|>        |                            |
     |                      |_________|                            |
     |                                                             |
     |--------clk--------------------------------------------------|
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
    assign clk_negedge = ~clk & clk_dly;
    
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

// -------------------------THIS DESIGN CAN BE OPTIMIZED-------------------------//
/*
The above approach was a conceptual approach but we can optimize the logic a bit.
We can simplify the negative edge detector as follows:
- We can observe that during a clk high the clk_dly will be a 1
 (During a posedge of clk, clk gets sampled, and since the sample is held for the duration of the clock cycle then the clk_dly register will always output a 1)
- We can replace the register for delaying the signal (clk) and collapse the negative edge detector to: assign clk_negedge = ~clk & 1'b1 = ~clk and ultimately just use (~clk) as our negative clk edge detector

The optimized design is below:
*/

module top_module (
    input clk,
    input d,
    output q
);
    // create two flops to sample at different clock edges
    reg posedge_dff;
    reg negedge_dff;

    // sample d at posedge of the clk
    always @ (posedge clk) begin
    	posedge_dff <= d;
    end

    // sample d at negative of the clk
  always @ (posedge ~clk) begin
        negedge_dff <= d;
    end

    // multiplex the output by selecting the flop correposonding to the clk edge (clk is the select line)
    assign q = clk ? posedge_dff : negedge_dff;

endmodule
