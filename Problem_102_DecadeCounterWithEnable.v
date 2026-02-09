/*
Countslow
Build a decade counter that counts from 0 through 9, inclusive, with a period of 10. 
The reset input is synchronous, and should reset the counter to 0. 
We want to be able to pause the counter rather than always incrementing every clock cycle, so the slowena input indicates when the counter should increment.
*/

module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q
);

  // register to hold the count
  reg [3:0] count;

  // drive the outout with count
  assign q = count;
  
  always @ (posedge clk) begin
    if (reset) begin
      count <= 0;
    end
    else if (count == 9) begin
        if (!slowena) begin
          count <= count;
        end
        else begin
          count <= 0;
        end
    end
    else if (slowena) begin
      count <= count + 1; // increment if slowena
    end
    else begin
      count <= count; // hold the current value
    end
  end

endmodule
