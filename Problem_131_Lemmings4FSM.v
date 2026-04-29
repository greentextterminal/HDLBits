/*
Although Lemmings can walk, fall, and dig, Lemmings aren't invulnerable. 
If a Lemming falls for too long then hits the ground, it can splatter. 
In particular, if a Lemming falls for more than 20 clock cycles then hits the ground, it will splatter and cease walking, falling, or digging (all 4 outputs become 0), forever (Or until the FSM gets reset). 
There is no upper limit on how far a Lemming can fall before hitting the ground. Lemmings only splatter when hitting the ground; they do not splatter in mid-air.
Extend your finite state machine to model this behaviour.

Falling for 20 cycles is survivable.
Falling for more than 20 cycles is a splat.
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
                   DIG_R  = 3'd5,
                   SPLAT  = 3'd6;

  // registers
  reg [2:0] state, next_state;

  // next state always block
  always @ (posedge clk or posedge areset) begin
    if (areset) state <= LEFT;
    else state <= next_state;
  end

  // fall counter (down count to 0)
  localparam N = 20 + 1; 
  reg [$clog2(N)-1:0] count = 0;
  always @ (posedge clk or posedge areset) begin
    if (areset) begin
      count <= 0;
    end
    else if (ground) begin
      count <= 0;
    end
    else if ((state == FALL_L) || (state == FALL_R)) begin // fall states act as the enable signal (up counter starts when in any fall state)
      count <= count + 1;  
    end
    else begin
      count <= count;
    end
  end

  // fall time exceeded logic
  wire fall_time_exceeded;
  assign fall_time_exceeded = (count > N) ? 1'b1 : 1'b0;
  
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
      FALL_L: begin
        if (ground) next_state = LEFT;
        else if (fall_time_exceeded && ground) next_state = SPLAT;
      end
      FALL_R: begin
        if (ground) next_state = RIGHT;
        else if (fall_time_exceeded && ground) next_state = SPLAT;
      end
      DIG_L: begin
        if (!ground) next_state = FALL_L;
      end
      DIG_R: begin
        if (!ground) next_state = FALL_R;
      end
      SPLAT: begin
        // if SPLAT then no more walking, screaming, or digging
        next_state = state;
      end
      // handles illegal cases
      default: next_state = LEFT;
    endcase
  end

  // output assignment
  assign walk_left  = (state == SPLAT) ? 1'b0 : (state == LEFT);
  assign walk_right = (state == SPLAT) ? 1'b0 : (state == RIGHT);
  assign aaah       = (state == SPLAT) ? 1'b0 : ((state == FALL_L) || (state == FALL_R));
  assign digging    = (state == SPLAT) ? 1'b0 : ((state == DIG_L)  || (state == DIG_R));
endmodule
