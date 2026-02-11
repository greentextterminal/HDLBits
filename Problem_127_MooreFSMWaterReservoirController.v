/*
Exams/ece241 2013 q4
*/

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);

  reg  [1:0] state, next_state, old_state;

  // state encoding (ranked in descending order to introduce comparison logic by embedding level rank)
  localparam aboveS3        = 3;
  localparam betweenS3adnS2 = 2;
  localparam betweenS2andS1 = 1;
  localparam belowS1        = 0;

  // combinatorial block to determine next state logic
  always @ (*) begin
    case (s)
      4'b0000: next_state = belowS1;
      4'b0001: next_state = betweenS2andS1;
      4'b0011: next_state = betweenS3adnS2;
      4'b0111: next_state = aboveS3;
      default: next_state = belowS1;
    endcase
  end

  // combinatorial block to determine output logic
  reg fr1, fr2, fr3, dfr;
  always @ (*) begin
    case (state)
      aboveS3: begin
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0; // no state is higher than this one, always 0
      end
      betweenS3adnS2: begin
        fr1 = 1;
        fr2 = 0;
        fr3 = 0;
        dfr = (old_state > state) ? 1 : 0;
      end
      betweenS2andS1: begin
        fr1 = 1;
        fr2 = 1;
        fr3 = 0;
        dfr = (old_state > state) ? 1 : 0;
      end
      belowS1: begin
        fr1 = 1;
        fr2 = 1;
        fr3 = 1; 
        dfr = 1; // always asserted at this state
      end
    endcase
  end

  // next state and reset logic
  always @ (posedge clk) begin
    if (reset) begin
      state <= belowS1;
    end
    else begin
      state <= next_state;
      old_state <= state; // hold the previous value of state for comparison
    end
  end

endmodule
