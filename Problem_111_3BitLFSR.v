/*
Mt2015 lfsr
Write the Verilog code for this sequential circuit (Submodules are ok, but the top-level must be named top_module). 
Assume that you are going to implement the circuit on the DE1-SoC board. 
Connect the R inputs to the SW switches, connect Clock to KEY[0], and L to KEY[1]. Connect the Q outputs to the red lights LEDR.
*/

module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

  // SW is the load data
  // KEY[1] is the select line for loading the data into the regs
  // KEY[0] is the clk line
  // LEDR is the output

  // muxdff1
  muxdff muxdff1 (
    .r(),
    .Qin(),
    .L(),
    .clk(),
    .Qout()
  );

  // muxdff2
  muxdff muxdff2 (
    .r(),
    .Qin(),
    .L(),
    .clk(),
    .Qout()
  );

  // muxdff3
  muxdff muxdff3 (
    .r(),
    .Qin(),
    .L(),
    .clk(),
    .Qout()
  );
  
  always @ (posedge KEY[0]) begin
    // load operation
    if (KEY[1]) begin
      LEDR <= SW;  
    end
    // creating the LFSR
    
    // muxdff1
    muxdff muxdff1 
  end

endmodule


module muxdff (
  input r, Qin, L, clk,
  output reg Qout
);
  wire mux;
  assign mux = L ? r : Qin;
  
  always @ (posedge clk) begin
    Qout <= mux;
  end
  
endmodule
