// Edge capture register

/*
For each bit in a 32-bit vector, capture when the input signal changes from 1 in one clock cycle to 0 the next. 
"Capture" means that the output will remain 1 until the register is reset (synchronous reset).

Each output bit behaves like a SR flip-flop: The output bit should be set (to 1) the cycle after a 1 to 0 transition occurs. 
The output bit should be reset (to 0) at the positive clock edge when reset is high. If both of the above events occur at the same time, reset has precedence. 
In the last 4 cycles of the example waveform below, the 'reset' event occurs one cycle earlier than the 'set' event, so there is no conflict here.
*/

/*
1 to 0 transitions over a clock cycle are negative edge detectors with a 1 clock cycle delay
We need to latch the output from the negative edge detector, delay by 1 CC, and deassert the latched outputs if reset is asserted
To latch the signals we need to implement a pulse to level converter in the form of an SR FF (this is done by sampling the flops own output)

|------------Stage 1---------------|    |--------Stage 2 (FF Delay)------|   |----------Stage 3 (output)-------------|
|negative edge detection           | -> |delayed output (FF stage 2)     |-> | output the levels
|(A FF is used but edge detection  |    |                                |   | if coming out of reset, use the stored
|is completed in the same cycle)   | -> |store result for use after reset|   | and new values, clear the store


*/

module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
  // negative edge detection
  wire [31:0] negedge_detect;
  reg [31:0] in_dly;
  assign negedge_detect = ~in & in_dly; // this creates our negative edge detection pulse
  
  // need to delay the output by 1 CC
  reg [31:0] delayed_output;
  assign out = delayed_output;

  // store result for use after reset
  reg [31:0] stored_output;

  always @ (posedge clk) begin
    in_dly <= in; // delayed signal for negative edge detection
    
    if (reset) begin
      delayed_output <= {32{1'b0}};
      stored_output <= negedge_detect;
    end
    else if (negedge_detect) begin 
      // assign the pulse to a reg (this pulse will get sampled and get kept in the DFF memory for 1 CC (CC N))
      delayed_output <= negedge_detect | stored_output; // or with store_output to recapture previous results
    end
    else begin
      // because negedge_detect is a pulse this logic will make the DFF sample its own output (D=Q) during CC N+1, 2, 3, ... and create a level until reset
      delayed_output <= delayed_output | stored_output;
      stored_output <= {32{1'b0}};
    end
  end

endmodule
