/*
For each bit in an 8-bit vector, detect when the input signal changes from 0 in one clock cycle to 1 the next (similar to positive edge detection). 
The output bit should be set the cycle after a 0 to 1 transition occurs.
*/

/*
    input is 8 bits wide
    EX 1:
    if input is decimal 2 then in binrary its 00000010
    if the input was decimal 0 initially, which is 00000000 in binary, then a transition from 0 to 2 is a transition from 00000000 to 00000010
    if the input is 8 bits wide [7:0] then bit position 1 changed from a 0 to 1 during this change in input data,
    therefore in the 8 bit output, bit index 1 will be set high

    EX 2: 
    input is decimal 2 or binary 00000010 then transitions to hex 5 or decimal 15 or 00001111  
    00000010
    00001111
    --------   the signals that changed from 0 to 1 are bit indexes 0, 2, and 3
    00001101   -> this is decimal 13 or hex C
    therefore the output will be hex C or 00001101 for the duration of the next clock cycle then reset back to 0

    since we are only looking for transitions from 0 to 1, asserting an output signal for 1 clock cycle or pulsing, then this perfectly fits a positive edge detection circuit
                            ______________
    signal             _____|
                                 _________
    delayed_signal     __________|
                            ______
    positive edge pulse ____|    |________
*/

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge // pos_edge_pulse
);

  // positive edge detection circuit (creating pulse)
  reg [7:0] in_dly; // register for delayed input signal
  reg [7:0] cc_dly; // 1 cc worth of delay for the output
  
  // positive edge detection
  wire [7:0] pos_edge_pulse;
  assign pos_edge_pulse = in & ~in_dly; // capturing the 0 to 1 transition as a pulse

  // 1 cc delay
  assign pedge = cc_dly;
  
  always @ (posedge clk) begin
    // delaying the signal by passing into DFFs to create pulse window
    in_dly <= in;
    // delaying the output pulse by 1 cc
    cc_dly <= pos_edge_pulse;
  end 

endmodule
