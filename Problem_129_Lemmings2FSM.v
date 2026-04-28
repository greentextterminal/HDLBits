/*
In addition to walking left and right, Lemmings will fall (and presumably go "aaah!") if the ground disappears underneath them.
In addition to walking left and right and changing direction when bumped, when ground=0, the Lemming will fall and say "aaah!". 
When the ground reappears (ground=1), the Lemming will resume walking in the same direction as before the fall. 
Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), 
or when the ground reappears while still falling, also does not affect the walking direction.

Moore State Machine: only depends on state
state transition logic -> next state -> present state
       ^____________________________________|
*/

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah 
); 

  // registers
  reg [1:0] state, next_state;

  // direction encoding
  localparam LEFT   = 2'b00,
             RIGHT  = 2'b01,
             FALL_L = 2'b10,
             FALL_R = 2'b11;

  // state always block
  always @ (posedge clk or posedge areset) begin
    if (areset) begin
      state <= LEFT;
    end
    else begin
      state <= next_state;
    end
  end

  // next state combo logic
  always @ (*) begin
    next_state = state;
    case (state)
      LEFT: begin
        if (!ground) // higher priority
          next_state = FALL_L;
        else if (bump_left)    
          next_state = RIGHT;
      end
      RIGHT: begin
        if (!ground) // higher priority
          next_state = FALL_R;
        else if (bump_right) 
          next_state = LEFT;
      end
      FALL_L: begin
        if (ground) 
          next_state = LEFT;
      end
      FALL_R: begin
        if (ground) 
          next_state = RIGHT;
      end
      default: next_state = LEFT;
    endcase
  end

  // output assignment
  assign walk_left  = (state == LEFT);
  assign walk_right = (state == RIGHT);
  assign aaah       = ((state == FALL_L) || (state == FALL_R));
  
endmodule
