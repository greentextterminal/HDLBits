/*
Sim/circuit5
This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.
*/

module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q );

endmodule

/*
If the input c is between 0 and 3, then one of the inputs (a, b, d, e) is selected. 
If the input c is outside of this range then output f. The mapping is shown below.
if (c is inclusively between 0 and 3):
  @ c = 0, q = b
  @ c = 1, q = e
  @ c = 2, q = a
  @ c = 2, q = d
else 
  q = f
*/

module top_module (
    input  [3:0] a,
    input  [3:0] b,
    input  [3:0] c,
    input  [3:0] d,
    input  [3:0] e,
    output [3:0] q 
);

  always @ (*) begin
    case (c)
      4'd0:    q = b;
      4'd1:    q = e;
      4'd2:    q = a;
      4'd3:    q = d;
      default: q = 4'hF;
    endcase
  end
    
endmodule
