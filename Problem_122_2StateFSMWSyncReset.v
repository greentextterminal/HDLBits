/*
Fsm2s
This is a Moore state machine with two states, two inputs, and one output. Implement this state machine.
This exercise is the same as fsm2, but using synchronous reset.
*/

module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out
);

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
      // State transition logic
      case (state)
        ON: begin
          out = 1;
          next_state = k ? OFF : ON;
        end
        OFF: begin
          out = 0;
          next_state <= j ? ON : OFF;
        end
      endcase
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
      if (reset) begin
        state <= OFF;
      end
      else begin
        state <= next_state;
      end
    end

endmodule
