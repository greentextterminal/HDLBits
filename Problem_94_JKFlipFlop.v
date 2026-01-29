/*
A JK flip-flop has the below truth table. 
Implement a JK flip-flop with only a D-type flip-flop and gates. 
Note: Qold is the output of the D flip-flop before the positive clock edge.

J	K	Q
0	0	Qold
0	1	0
1	0	1
1	1	~Qold

*/

module top_module (
    input clk,
    input j,
    input k,
    output Q
);

  always @ (posedge clk) begin
    if (!j & !k) begin
      Q <= Q;
    end
    else if (!j & k) begin
      Q <= 0;
    end
    else if (j & !k) begin
      Q <= 1;
    end
    else if (j & k) begin
      Q <= !Q;
    end
  end
endmodule
