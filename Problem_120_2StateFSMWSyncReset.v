/*
Fsm1s
This is a Moore state machine with two states, one input, and one output. 
Implement this state machine. Notice that the reset state is B.
This exercise is the same as fsm1, but using synchronous reset.
*/

/* 
state transition logic -> next state -> present state
       ^____________________________________|
*/

module top_module(
    input clk,
    input reset, // Synchronous reset to state B
    input in,
    output reg out
);

    // Fill in state name declarations
    parameter A=1'b0, B=1'b1;

    reg present_state, next_state;

    always @ (posedge clk) begin
      if (reset) begin   
          present_state <= B; // reset to state B
          out = 1;
        end else begin
            case (present_state)
              // state transition logic (combination logic that determines next state)
              A: begin
                next_state = in ? A : B;
              end
              B: begin
                next_state = in ? B : A;
              end
              default: begin
                // match the reset case
                next_state = B;
              end
            endcase

          // State flip-flops (this drives the [PS DFF] with the output of the [NS DFF])
            present_state = next_state;   

            // output logic
            case (present_state)
              A: begin
                out = 0; // A state always outputs a 0
              end
              B: begin
                out = 1; // B state always outputs a 1
              end
              default: begin
                // match reset case (B state)
                out = 1;
              end
            endcase
        end
    end

endmodule

// ------------ A version not following the template ------------
module top_module(
    input clk,
    input reset, // Synchronous reset to state B
    input in,
    output out
);

    // Fill in state name declarations
    parameter A=1'b0, B=1'b1;

    reg present_state, next_state;

    always @ (posedge clk) begin
      if (reset) begin   
          present_state <= B; // reset to state B
      end
      else begin
          present_state <= next_state; 
      end
    end

      always @ (*) begin
        // state transition logic (combination logic that determines next state)
        // output logic based on state
        case (present_state)
          A: begin
            next_state = in ? A : B;
            out = 0; // A state always outputs a 0
          end
          B: begin
            next_state = in ? B : A;
            out = 1; // B state always outputs a 1
          end
          default: begin
            // match the reset case (B state)
            next_state = B;
            out = 1;
          end
        endcase
      end

endmodule

