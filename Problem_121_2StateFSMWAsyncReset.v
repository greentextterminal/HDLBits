/*
Fsm2
This is a Moore state machine with two states, two inputs, and one output. Implement this state machine.
This exercise is the same as fsm2s, but using asynchronous reset.
*/

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out
);
    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
      // State transition logic (depends on present state)
      case (state)
        ON: begin
          out = 1;
          next_state = k ? OFF : ON;
        end
        OFF: begin
          out = 0;
          next_state = j ? ON : OFF;
        end
      endcase
    end

    always @(posedge clk, posedge areset) begin
      // State flip-flops with asynchronous reset
      if (areset) begin
        state <= OFF;
      end
      else begin
        state <= next_state;
      end
    end

endmodule
