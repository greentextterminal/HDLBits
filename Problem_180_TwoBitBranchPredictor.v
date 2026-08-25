/*
Cs450/counter 2bc
*/

module top_module(
    input clk,
    input areset,
    input train_valid, // trains branch predictor (keep state if not asserted)
    input train_taken, // branch was taken (decides whether to increment/decrement)
    output [1:0] state
);
  // FSM state localparams
  localparam [1:0] SNT = 2'd0,
                   WNT = 2'd1, // areset returns to WNT state
                   WT  = 2'd2,
                   ST  = 2'd3;

  // FSM regs
  /* FSM Logic
      [combo logic] -> [next_state] -> [state]
            ^_____________________________|
  */
  reg [1:0] current_state, next_state;

  // next state logic
  always @ (posedge clk or posedge areset) begin
      if (areset) begin
          current_state <= WNT; // areset returns to WNT state
      end
      else begin
          current_state <= next_state; // current state is fed by next state, which is determined by the combo logic case statements
      end
  end

  // --------combo logic that determines next_state based on current state--------
  // train_valid & train_taken  -> incrment
  // train_valid & ~train_taken -> decrement
  // ~train_valid               -> hold state
  always @ (*) begin
      // adding a default assign statement to prevent latches (assign state to itself to hold last state to handle SNT and ST cases)
      next_state = current_state; // handles the train_valid = 0 case (we are deliberately creating a latch)
    
      case (current_state)
          SNT: begin
              if (train_valid) begin
                  if (train_taken) begin
                      next_state = WNT; // increment to next state
                  end
                  else begin
                      next_state = current_state; // hold state since no other state to decrement to
                  end
              end
          end
          WNT: begin
              if (train_valid) begin
                  if (train_taken) begin
                      next_state = WT; // increment to next state
                  end
                  else begin
                      next_state = SNT; // decrement state
                  end
              end
          end
          WT: begin
              if (train_valid) begin
                  if (train_taken) begin
                      next_state = ST; // increment to next state
                  end
                  else begin
                      next_state = WNT; // decrement state
                  end
              end
          end
          ST: begin
              if (train_valid) begin
                  if (train_taken) begin
                      next_state = current_state; // hold state since no other state to increment to
                  end
                  else begin
                      next_state = WT; // decrement state
                  end
              end
          end
          default: begin
              next_state = WNT; // this is the reset value, therefore its the default
          end
      endcase 
    end
    
    // drive output with current state
    assign state = current_state;
endmodule
