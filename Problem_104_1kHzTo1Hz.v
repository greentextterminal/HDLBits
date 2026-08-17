/*
From a 1000 Hz clock, derive a 1 Hz signal, called OneHertz, that could be used to drive an Enable signal for a set of hour/minute/second counters to create a digital wall clock. 
Since we want the clock to count once per second, the OneHertz signal must be asserted for exactly one cycle each second. 
Build the frequency divider using modulo-10 (BCD) counters and as few other gates as possible. 
Also output the enable signals from each of the BCD counters you use (c_enable[0] for the fastest counter, c_enable[2] for the slowest).

The following BCD counter is provided for you. 
Enable must be high for the counter to run. 
Reset is synchronous and set high to force the counter to zero. 
All counters in your circuit must directly use the same 1000 Hz signal.

module bcdcount (
	input clk,
	input reset,
	input enable,
	output reg [3:0] Q
);
*/

module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);
    /*
    BCD has 4 outputs. Since we need to count to 1000 we need at least 10 bits to represent this number.
    We are using three BCDs so we will have 12 bits of output.
    1000 in binary is 11 1110 1000
    */

    // localparams
    localparam N  = 12'b1000;
    
    // regs
    reg bundle_idx = 4;
    
    // wires
    wire [11:0] bcd_output_bundle;

    // enable logic selection
    always @ (posedge clk) begin
        if (reset || (bcd_output_bundle == N)) begin
            bundle_idx <= 4;
        end
        else begin
            if ()
        end
    end

    // instantiating the bcd counters
    bcdcount counter0 (clk, reset, c_enable[0], bcd0_out);
    bcdcount counter1 (clk, reset, c_enable[1], bcd1_out);
    bcdcount counter2 (clk, reset, c_enable[2], bcd2_out);

    // bcd output wire bundle
    assign bcd_output_bundle = {bcd2_out, bcd1_out, bcd0_out};
      
endmodule
