/*
The PS/2 mouse protocol sends messages that are three bytes long. 
However, within a continuous byte stream, it's not obvious where messages start and end. 
The only indication is that the first byte of each three byte message always has bit[3]=1 (but bit[3] of the other two bytes may be 1 or 0 depending on data).

We want a finite state machine that will search for message boundaries when given an input byte stream. 
The algorithm we'll use is to discard bytes until we see one with bit[3]=1. 
We then assume that this is byte 1 of a message, and signal the receipt of a message once all 3 bytes have been received (done).

The FSM should signal done in the cycle immediately after the third byte of each message was successfully received.
*/

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
);
  /*
  combo logic -> next_state -> state
        ^________________________|

  4 states: BYTE1 -> BYTE2 -> BYTE3 -> DONE
  */

  // state encodings
  localparam [1:0] BYTE1 = 2'd0,
                   BYTE2 = 2'd1,
                   BYTE3 = 2'd2,
                   DONE  = 2'd3;
  
  // registers
  reg [7:0] state, next_state;

  // State flip-flops (sequential)
  always @ (posedge clk) begin
    if (reset)
      state <= BYTE1;
    else
      state <= next_state;
  end

  // State transition logic (combinational)
  always @ (*) begin
    // assign next_state with current state to prevent latches
    next_state = state;
    
    case (state)
      BYTE1: begin
        if (in[3])
          next_state = BYTE2;
      end
      BYTE2: begin
        next_state = BYTE3;
      end
      BYTE3: begin
        next_state = DONE;
      end
      DONE: begin
        if (in[3]) // checks for in[3] of byte 1 before moving to state byte 2
          next_state = BYTE2;
        else
          next_state = BYTE1;
      end
      default: begin
        next_state = BYTE1; // handles the illegal cases
      end
    endcase
  end
 
  // Output logic
  assign done = (state == DONE);

endmodule
