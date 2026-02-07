/*
Fsm3s
The following is the state transition table for a Moore state machine with one input, one output, and four states. 
Implement this state machine. Include an asynchronous reset that resets the FSM to state A.

State	Next state	Output
      in=0	in=1
  A	    A	   B	   0
  B   	C	   B	   0
  C	    A	   D	   0
  D   	C	   B	   1
*/

module top_module(
    input clk,
    input in,
    input areset,
    output out
); 

  // combo logic -> next state DFF -> state DFF
  //   ^__________________________________|

  // PARAMETERS
  localparam A=0, B=1, C=2, D=3; // A (00), B (01), C (10), D (11)

  // state and next_state registers
  reg [3:0] state, next_state;

  // State transition logic
  // determine the next state 
  always @ (*) begin
    case (state)
      A: begin
        next_state = in ? B : A;
      end
      B: begin
        next_state = in ? B : C;
      end
      C: begin
        next_state = in ? D : A;
      end
      D: begin
        next_state = in ? B : C;
      end
    endcase
  end

  // State flip-flops with asynchronous reset
  always @ (posedge clk) begin
    if (reset) begin
      state <= A; // reset to state A
    end
    else begin
      state <= next_state;
    end
  end

  // Output logic
  assign out = (state == D) ? 1 : 0;

endmodule
