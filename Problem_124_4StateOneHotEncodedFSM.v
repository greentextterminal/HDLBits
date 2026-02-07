/*
Fsm3onehot
The following is the state transition table for a Moore state machine with one input, one output, and four states. 
Use the following one-hot state encoding: A=4'b0001, B=4'b0010, C=4'b0100, D=4'b1000.
Derive state transition and output logic equations by inspection assuming a one-hot encoding. 
Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. 
(The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated).

State	Next state	Output
      in=0	in=1
  A	    A	    B	     0
  B    	C	    B	     0
  C   	A	    D	     0
  D     C	    B	     1
*/

module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

  parameter A=0, B=1, C=2, D=3;

  // State transition logic: Derive an equation for each state flip-flop.
  // use the transition logic into the state to assign to the specifc one hot encoded state
  assign next_state[A] = (state[A] & ~in) | (state[C] & ~in);
  assign next_state[B] = (state[A] & in) | (state[B] & in) | (state[D] & in);
  assign next_state[C] = (state[B] & ~in) | (state[D] & ~in);
  assign next_state[D] = (state[C] & in);

  // Output logic: 
  assign out = state[D] ? 1 : 0;

endmodule
