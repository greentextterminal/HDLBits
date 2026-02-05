/*
Fsm1
This is a Moore state machine with two states, one input, and one output. 
Implement this state machine. Notice that the reset state is B.
This exercise is the same as fsm1s, but using asynchronous reset.
*/

/*
Moore state machines are a function of the current state

[state transition and output logic] -> [next_state reg] -> [state reg]
   ^____________________________________________________________|
   
*/

module top_module(
    input clk,
    input areset, // Asynchronous reset to state B
    input in,
    output out
);

    parameter A=1'b0, B=1'b1; 
    reg state, next_state;

    // This is a combinational always block
    // define the next state transition logic 
    always @ (*) begin
      // State transition logic
      case (state)
        A: begin
          out = 0; // State A outputs a 0
          if (in) begin
            next_state = A;
          end
          else begin
            next_state = B;
          end
        end
        B: begin
          out = 1; // State B outputs a 1
          if (in) begin
            next_state = B;
          end
          else begin
            next_state = A;
          end
        end
        default: begin
          next_state = B;
        end
      endcase
    end

    // This is a sequential always block
    // this block infers flops and keeps a memory of the states
    // the state reg is fed into the combination logic to make state transitions
    always @ (posedge clk or posedge areset) begin
      // State flip-flops with asynchronous reset
      if (areset) begin
        state <= B; // reset directly to state B
      end
      else begin
        state <= next_state;
      end
    end

endmodule


// ----------------- A slightly improved version of the code above -----------------
module top_module(
    input clk,
    input areset, // Asynchronous reset to state B
    input in,
    output out
);

    parameter A=1'b0, B=1'b1; 
    reg state, next_state;

    // This is a combinational always block
    // define the next state transition logic 
    always @ (*) begin
      // State transition logic
      case (state)
        A: begin
          out = 0; // State A outputs a 0
          next_state = in ? A : B; 
        end
        B: begin
          out = 1; // State B outputs a 1
          next_state = in ? B : A;
        end
        default: begin
          out = 1;
          next_state = B;
        end
      endcase
    end

    // This is a sequential always block
    // this block infers flops and keeps a memory of the states
    // the state reg is fed into the combination logic to make state transitions
    always @ (posedge clk or posedge areset) begin
      // State flip-flops with asynchronous reset
      if (areset) begin
        state <= B; // reset directly to state B
      end
      else begin
        state <= next_state;
      end
    end

endmodule
