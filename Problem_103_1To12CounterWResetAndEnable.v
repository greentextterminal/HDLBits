/*
Exams/ece241 2014 q7a
Design a 1-12 counter with the following inputs and outputs:

Reset Synchronous active-high reset that forces the counter to 1
Enable Set high for the counter to run
Clk Positive edge-triggered clock input
Q[3:0] The output of the counter
c_enable, c_load, c_d[3:0] Control signals going to the provided 4-bit counter, so correct operation can be verified.
You have the following components available:

the 4-bit binary counter (count4) below, which has Enable and synchronous parallel-load inputs (load has higher priority than enable). 
The count4 module is provided to you. Instantiate it in your circuit.
logic gates
module count4(
	input clk,
	input enable,
	input load,
	input [3:0] d,
	output reg [3:0] Q
);
The c_enable, c_load, and c_d outputs are the signals that go to the internal counter's enable, load, and d inputs, respectively. Their purpose is to allow these signals to be checked for correctness.
*/

module top_module (
  input clk,  
  input reset,   
  input enable,
  output [3:0] Q,   // <- Q from counter instantiation
  output c_enable,  // <- enable from input
  output c_load,    // <- load
  output [3:0] c_d  // <- data
); 

  assign c_enable = enable; // top out
  assign c_load = load;     // top out
  assign c_d = data;        // top out

  reg load;
  reg [3:0] data;

  // load has higher priority than enable
  always @ (posedge clk) begin
    if (reset || (Q == 4'd12)) begin
      load <= 1;
      data <= 4'b0001;
    end
    else if (!enable) begin
      load <= 1;
      data <= 4'b0001;
      Q <= Q; // load asserts if enable deasserts
    end
    else begin
      load <= 0;
      data <= 4'b0000;
    end  
  end
  
  // instantiating the counter
  count4 the_counter (.clk(clk),         // in : clk    <- clk
                      .enable(enable),   // in : enable <- enable
                      .load(c_load),     // in : load   <- c_load
                      .d(c_d),           // in : data   <- c_d 
                      .Q(Q)              // out: Q      -> Q
                     );

endmodule

