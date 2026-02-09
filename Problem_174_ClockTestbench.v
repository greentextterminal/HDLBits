/*
Tb/clock
You are provided a module with the following declaration:
module dut ( input clk ) ;

Write a testbench that creates one instance of module dut (with any instance name), and create a clock signal to drive the module's clk input. 
The clock has a period of 10 ps. The clock should be initialized to zero with its first transition being 0 to 1.
*/

/*
the clock needs a period of 10ps
this means the clock is high for 5ps and low for 5ps for a total period of 10ps
*/

`timescale 1ps/1ps // timescale compiler directive: `timescale <time_unit> / <resolution or time_precision> 
module top_module ( );
  reg clock; // input stimulus

  initial begin
    clock = 0; // initialize the clock to zero
    forever begin
      #5 // delay of 5ps (total clock cycle period is 10ps)
      clock = ~clock; // creating an oscillating clock in a forever loop
    end
  end
  
  dut clock1 (.clk(clock));
endmodule
