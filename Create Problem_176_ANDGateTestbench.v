/*
Tb/and
You are given the following AND gate you wish to test:

module andgate (
    input [1:0] in,
    output out
);
Write a testbench that instantiates this AND gate and tests all 4 input combinations, by generating the following timing diagram:
*/

`timescale 1ps/1ps
module top_module(reg out);
  // inputs
  reg [1:0] in;

  // stimulus pattern
  initial begin
    // init with zeros
    in = 0;
    #10 // delay of 10 time units
    // t = 10
    in[0] = 1;
    #10 // delay of 10 time units
    // t = 20
    in[0] = 0;
    in[1] = 1;
    #10 // delay of 10 time units
    // t = 30
    in[0] = 1;
  end

  // DUT
  andgate ag1 (.in(in),
               .out(out) // connect the out from the top as the out of this AND gate instance
              );
endmodule
