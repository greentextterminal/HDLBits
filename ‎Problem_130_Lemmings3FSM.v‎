/*
In addition to walking and falling, Lemmings can sometimes be told to do useful things, like dig (it starts digging when dig=1). 
A Lemming can dig if it is currently walking on ground (ground=1 and not falling), and will continue digging until it reaches the other side (ground=0). 
At that point, since there is no ground, it will fall (aaah!), then continue walking in its original direction once it hits ground again. 
As with falling, being bumped while digging has no effect, and being told to dig when falling or when there is no ground is ignored.

(In other words, a walking Lemming can fall, dig, or switch directions. 
If more than one of these conditions are satisfied, fall has higher precedence than dig, which has higher precedence than switching directions.)
*/

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
); 
  // Priority order (highest to lowest): fall, dig, direction switching
  
  // encoding
  localparam [2:0] LEFT   = 3'd0,
                   RIGHT  = 3'd1,
                   FALL_L = 3'd2,
                   FALL_R = 3'd3,
                   DIG_L  = 3'd4,
                   DIG_R  = 3'd5;

  // registers
  reg [2:0] state, next_state;

  // next state always block
  always @ (posedge clk or posedge areset) begin
    if (areset) state <= LEFT;
    else state <= next_state;
  end

  // next state transition logic
  always @ (*) begin
    next_state = state; // hold the current state (prevent latches)
    case (state) 
      LEFT: begin
        if (!ground) next_state = FALL_L;
        else if (dig) next_state = DIG_L;
        else if (bump_left) next_state = RIGHT;
      end
      RIGHT: begin
        if (!ground) next_state = FALL_R;
        else if (dig) next_state = DIG_R;
        else if (bump_right) next_state = LEFT;
      end
      FALL_L:
        if (ground) next_state = LEFT;
      FALL_R:
        if (ground) next_state = RIGHT;
      DIG_L:
        if (!ground) next_state = FALL_L;
      DIG_R:
        if (!ground) next_state = FALL_R;
      // handles illegal cases
      default: next_state = LEFT;
    endcase
  end

   // output assignment
  assign walk_left  = (state == LEFT);
  assign walk_right = (state == RIGHT);
  assign aaah       = ((state == FALL_L) || (state == FALL_R));
  assign digging    = ((state == DIG_L) || (state == DIG_R));
endmodule
