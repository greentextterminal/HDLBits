/*
In many (older) serial communications protocols, each data byte is sent along with a start bit and a stop bit, to help the receiver delimit bytes from the stream of bits. 
One common scheme is to use one start bit (0), 8 data bits, and 1 stop bit (1). The line is also at logic 1 when nothing is being transmitted (idle).

Design a finite state machine that will identify when bytes have been correctly received when given a stream of bits. 
It needs to identify the start bit, wait for all 8 data bits, then verify that the stop bit was correct. 
If the stop bit does not appear when expected, the FSM must wait until it finds a stop bit before attempting to receive the next byte.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
  // params for counter
  localparam DATA_LENGTH = 8;

  // state encoding
  localparam [2:0] IDLE  = 3'd0,
                   START = 3'd1,
                   DATA  = 3'd2,
                   STOP  = 3'd3,
                   DONE  = 3'd4;

  // reg and wire for counter
  reg [$clog2(DATA_LENGTH+1)-1:0] count;
  wire count_hit;

  // registers for state
  reg [2:0] state, next_state;

  // counter cycles limit hit
  assign count_hit = (count == (DATA_LENGTH - 1));

  // counter
  /*
    @ CC 1 -> count = 0 
    @ CC 2 -> count = 1
    ...
    @ CC 7 -> count = 7
  */
  always @ (posedge clk) begin
    if (reset) begin
      count <= 0;
    end
    else if (count_hit) begin // counter 0 reset takes higher priority
      count <= 0;
    end
    else if (state == DATA) begin // enable the count if in DATA state
      count <= count + 1;
    end
    else begin
      count <= count;
    end
  end

  // state always block
  always @ (posedge clk) begin
    if (reset) begin
      state <= 0;
    end
    else begin
      state <= next_state;
    end
  end

  /*
      [IDLE] -(~in)-> [START] -(1 CC)-> [DATA] -(in & 8CC) -> [STOP] -(in)-> [DONE]
                                          ^____________________________________|
      If DONE state is reached it will act like the START state and check for the START bit of 0 (~in)
  */

  // next state transition logic
  always @ (*) begin
     // hold the current state to prevent latches
    next_state = state;
    
    case (state)
      IDLE: begin
        if (~in)
          next_state = START;
      end
      START: begin
        // 1 CC later
        next_state = DATA;
      end
      DATA: begin
        // wait for 8 CCs of data
        if (in & count_hit)
          next_state = STOP;
      end
      STOP: begin
        if (in)
          next_state = DONE;
      end
      DONE: begin
        // If 0 detected behave like START state from this state
        if (~in)
          next_state = DATA;
      end
    endcase
  end

  // driving output
  assign done = (state == DONE);
  
endmodule
