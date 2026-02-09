/*
Tb/tb1
Create a Verilog testbench that will produce the following waveform for outputs A and B:
*/

`timescale 1ps/1ps
module top_module (output reg A, 
                   output reg B 
                  );
  
    // generate input patterns here
    initial begin
      // initialize both outputs to 0
      // t = 0
      A = 0;
      B = 0;
      #10 // 10 time units
      // t = 10
      A = 1;
      #5 // 5 time units
      // t = 15
      B = 1;
      #5 // 5 time units
      // t = 20
      A = 0;
      #20 // 20 time units
      // t = 40
      B = 0;
    end

endmodule
