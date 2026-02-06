/*
Fsm3comb
The following is the state transition table for a Moore state machine with one input, one output, and four states. 
Use the following state encoding: A=2'b00, B=2'b01, C=2'b10, D=2'b11.
Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. 
Given the current state (state), compute the next_state and output (out) based on the state transition table.
*/

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out
);

  parameter A=0, B=1, C=2, D=3;

  // State transition logic: next_state = f(state, in)
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

  // Output logic:  out = f(state) for a Moore state machine
  always @ (*) begin
    case (state)
      A: out = 0;
      B: out = 0;
      C: out = 0;
      D: out = 1;
    endcase
  end

endmodule
