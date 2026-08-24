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

  // Bundling the train_valid and train_takan to create managable localparam states
  

  // FSM regs
  /* FSM Logic
      [combo logic] -> [state] -> [next_state]
            ^__________________________|
  */
  reg [1:0] curr_state, next_state;

  // next state logic
  always @ (posedge clk) begin
      next_state <= curr_state;
  end

  // combo logic that determines next_state based on current state
  // train_valid & train_taken  -> incrment
  // train_valid & ~train_taken -> decrement
  // ~train_valid               -> hold state
  always @ (*) begin
    // adding a default assign statement to prevent latches (assign state to itself to hold last state to handle SNT and ST cases)
      assign curr_state <= curr_state; // handles the train_valid = 0 case
    
      case (next_state)
          SNT: begin
              if (train_valid) begin
                  if (train_taken) begin
                      curr_state <= WNT;
                  end
              end
          end
          WNT: begin
              if (train_valid) begin
                  if (train_taken) begin
                      curr_state <= WT;
                  end
                  else begin
                      curr_state <= SNT;
                  end
              end
          end
          WT: begin
              if (train_valid) begin
                  if (train_taken) begin
                      curr_state <= ST;
                  end
                  else begin
                      curr_state <= WNT;
                  end
              end
          end
          ST: begin
              if (train_valid) begin
                  if (train_taken) begin
                      curr_state <= state;
                  end
                  else begin
                      curr_state <= WT;
                  end
              end
          end
          default: begin
              next_state <= WNT; // this is the reset value, therefore its the default
          end
      endcase 
    end

    // drive output with current state
    assign state = curr_state;
endmodule
