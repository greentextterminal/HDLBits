/*
Implement the circuit:

___________________________________
|     _______      _________      |
|_____|XNOR |----->| D    Q |----------out
      |GATE |      |        |
in--->|_____|   ---|>       |
                |  |________|
clk------------/   

Note: this is a D Flip Flop (DFF) driven by an XNOR gate
*/

module top_module (
    input clk,
    input in, 
    output out
);

  wire xor_out;
  assign xor_out = in ^ out;

  always @ (posedge clk) begin
    out <= xor_out;
  end
  
endmodule
