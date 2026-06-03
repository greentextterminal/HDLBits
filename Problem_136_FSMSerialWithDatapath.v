/*
Now that you have a finite state machine that can identify when bytes are correctly received in a serial bitstream, add a datapath that will output the correctly-received data byte. 
out_byte needs to be valid when done is 1, and is don't-care otherwise.

Note that the serial protocol sends the least significant bit first.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
  // params for counter
  localparam DATA_LENGTH = 8;

  // state encoding
  localparam [2:0] IDLE  = 0,
                   START = 1,
                   DATA  = 2,
                   STOP  = 3,
                   WAIT  = 4;

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
      state <= IDLE;
    end
    else begin
      state <= next_state;
    end
  end

  /*
      [IDLE] -(~in)-> [START] -(1 CC)-> [DATA] -(8CC) & (in)-> [STOP]
                                           |                    |  |__(~in)__>[START]
                                         (~in)                  |______(in)__>[IDLE]
                                           |
                                         [WAIT]--(in)-->[IDLE]

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
        if (count_hit) begin
          if (in)
            next_state = STOP;
          else
            next_state = WAIT;
        end
      end
      STOP: begin
        if (in)
          next_state = IDLE;
        else
          next_state = START;
      end
      WAIT: begin
        if (in)
          next_state = IDLE;
      end
      default: begin // illegal state handling
        next_state = IDLE;
      end
    endcase
  end

  // driving output (needs to be a pulse)
  assign done = (state == STOP);

  // 1 byte register for data shifting
  reg [7:0] output_byte;

  // always clocked block to shift in data
  always @ (posedge clk) begin
    if (reset)
      output_byte <= 0;
    // shift in data during the exact clock cycle we enter DATA state
    // check for !count_hit to stop shifting in data at the last bit of the payload (safety measure)
    else if ((next_state == DATA) && (!count_hit))
      output_byte <= {in, output_byte[7:1]};
    else
      output_byte <= output_byte; // hold the data
  end

  // send out the shifted in byte
  assign out_byte = (state == STOP) ? output_byte : (8'b0);
  
endmodule
