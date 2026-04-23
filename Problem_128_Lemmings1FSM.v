/*
The game Lemmings involves critters with fairly simple brains. So simple that we are going to model it using a finite state machine.
In the Lemmings' 2D world, Lemmings can be in one of two states: walking left or walking right. It will switch directions if it hits an obstacle. 
In particular, if a Lemming is bumped on the left, it will walk right. If it's bumped on the right, it will walk left. 
If it's bumped on both sides at the same time, it will still switch directions.

Implement a Moore state machine with two states, two inputs, and one output that models this behaviour.
Moore State Machine: only depends on state
state transition logic -> next state -> present state
       ^____________________________________|
*/


module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right);

    // localparams
    localparam [0:0] LEFT=0, 
                     RIGHT=1;
    
    reg state, next_state;

    wire both_directions = bump_left & bump_right; // if bump left and right triggered at the same time

    always @ (*) begin
      // default
      next_state = state; // set next_state with current state (in lieu of an else statement in the cases
      // State transition logic
      case (state)
        LEFT: begin
          if (bump_left || both_directions) 
            next_state = RIGHT;
        end
        RIGHT: begin
          if (bump_right || both_directions) 
            next_state = LEFT;
        end
        default: begin
          next_state = LEFT;
        end
      endcase
    end

    always @(posedge clk, posedge areset) begin
      // State flip-flops with asynchronous reset
      if (areset) begin
        state <= LEFT;
      end
      else begin
        state <= next_state;
      end
    end

  // Output logic
  assign walk_left = (state == LEFT);
  assign walk_right = (state == RIGHT);

endmodule
