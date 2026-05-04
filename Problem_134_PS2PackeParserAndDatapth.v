/*
Now that you have a state machine that will identify three-byte messages in a PS/2 byte stream, 
add a datapath that will also output the 24-bit (3 byte) message whenever a packet is received (out_bytes[23:16] is the first byte, 
out_bytes[15:8] is the second byte, etc.).

out_bytes needs to be valid whenever the done signal is asserted. 
You may output anything at other times (i.e., don't-care).
*/

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

  // FSM from fsm_ps2
  
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

    // New: Datapath to store incoming bytes.

  // creating a 3 byte register
  reg [23:0] data;
  
  // writing bytes into a 3 byte reigster
  always @ (posedge clk) begin
    if (reset) begin
      data <= 0;
    end
    else if ((state == BYTE1) | (state == DONE)) begin
      data[23:16] <= in;
    end
    else if (state == BYTE2) begin
      data[15:8] <= in;
    end
    else if (state == BYTE3) begin
      data[7:0] <= in;
    end
  end

  // combo logic
  assign out_bytes = (done) ? data : 0;

endmodule
