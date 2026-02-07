/*
Bugs mux4
This 4-to-1 multiplexer doesn't work. Fix the bug(s).

You are provided with a bug-free 2-to-1 multiplexer:

module mux2 (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] out
);
*/

module top_module (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  
); //

  /*
    you can create a 4:1 mux from three 2:1 muxes

    sel ? a : b

    a--/8-->|mux0   |--/8--> |       |
    b--/8-->|sel[0] |        |mux2   |
                             |sel[1] |
    c--/8-->|mux1   |--/8--->|       |
    d--/8-->|sel[0] |

    the first stage (the first two of the 2:1 muxes must share a select line
    the second stage of the 4:1 mux (the last 2:1 mux) must use a different select line (this is the last decision making bit)
  */

  
  // wires (match the bus width)
  wire [7:0] mux0out, mux1out; 
  // a / b mux (mux0)
  mux2 mux0 ( sel[0],    a,    b, mux0out );
  // c / d mux (mux1)
  mux2 mux1 ( sel[0],    c,    d, mux1out );
  // (a / b) or (c / d) mux (mux2) -> the 4:1 mux
  mux2 mux2 ( sel[1], mux0out, mux1out,  out );

endmodule

