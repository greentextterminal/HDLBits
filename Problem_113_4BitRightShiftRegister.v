/*
Exams/m2014 q4k
Implement the following circuit:
*depiction of a 4 bit right shift register*
*/

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);

  // 4 bit wide register
  reg [3:0] register;

  // modelling the 4 bit right shift register
  always @ (posedge clk) begin
    if (~resetn) begin // active low reset
      register <= 0; // zero out the shift register
    end
    else begin
      register <= {in, register[3:1]}; // shifting contents right ->
    end
  end

  // driving output with the LSB of the shift register
  assign out = register[0];

endmodule
