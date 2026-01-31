/*
For each bit in an 8-bit vector, detect when the input signal changes from one clock cycle to the next (detect any edge). 
The output bit should be set the cycle after a 0 to 1 transition occurs.
*/

/*
  We are looking for transitions from 0 to 1 or for transitions from 1 to 0. asserting an output signal for 1 clock cycle or pulsing,
  which perfectly fits a positive and negative edge detection circuit

  Positive Edge Detction
                            ______________
    signal             _____|
                                 _________
    delayed_signal     __________|
                            ______
    positive edge pulse ____|    |________

  Negative Edge Detction
                        __________
    signal                       |________
                         ______________
    delayed_signal                    |_____
                                 ______
    positive edge pulse _________|    |________
*/

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

  // any edge detector
  reg [7:0] delayed_signal;
  reg [7:0] delayed_anyedge; // addition will be done combinatorially before getting sampled into the registers
  wire [7:0] posedge_detect;
  wire [7:0] negedge_detect;

  // positive edge detection
  assign posedge_detect = in & ~delayed_signal;

  // negative edge detection
  assign negedge_detect = ~in & delayed_signal;

  // combining results from positive edge and negative edge into a single result
  /* 
  1 to 0 or 0 to 1 transitions only occur in a certain index position, they will not overlap during a clock cycle
  therefore we can simply add the results of the positive and negative edge detectors or do a bitwise OR and get an anyedge result.
  Since we need to assert the bit of any anyedge a clock cycle later after detection we can do 2 things in 1 move. We need to do either
  an addition operation or a bitwise OR and delay the anyedge result by 1 CC. Since we know the transitions will never overlap during a clock cycle
  we can combine detector outputs into a single result. This result can be obtained via addition or a bitwise OR. In terms of hardware it would be much more 
  efficient to do a bitwise OR because the hardware cost of an addition operation in this case would an 8 bit adders worth of logic.
  Therefore we can just assign the bitwise OR operation to a a DFF and the resulting output will be our anyedge detector.
  */  

  // any edge detection
  assign anyedge = delayed_anyedge;

  always @ (posedge clk) begin
    delayed_signal <= in;
    delayed_anyedge <= posedge_detect | negedge_detect;
  end
endmodule
