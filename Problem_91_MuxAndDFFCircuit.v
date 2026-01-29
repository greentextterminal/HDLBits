/*
Assume that you want to implement hierarchical Verilog code for this circuit, using three instantiations of a submodule that has a flip-flop and multiplexer in it. 
Write a Verilog module (containing one flip-flop and multiplexer) named top_module for this submodule.
*/

module top_module (
	input clk,
	input L,     // select line
	input r_in,  // input 0
	input q_in,  // input 1
	output reg Q // dff out
);

  // describing the mux
  wire mux_out;//(sel) (in1)  (in0)
  assign mux_out = L ? r_in : q_in; // if L 0 then q_in, if L 1 then r_in

  // describing the dff
  always @ (posedge clk) begin
    Q <= mux_out; //
  end

endmodule

/*

// This RTL uses descriptive signal names that map directly to hardware 

module mux_dff (
  input  clk,
  input  mux_in0,
  input  mux_in1,
  input  mux_sel,
  output dff_out
);
  // describing the mux
  wire mux_out;//  (sel)     (in1)      (in0)
  assign mux_out = mux_sel : mux_in1 ? mux_in0; // if sel 0 then mux_in0, if sel 1 then mux_in1

  // describing the dff
  always @ (posedge clk) begin
    dff_out <= mux_out; //
  end
  
endmodule
