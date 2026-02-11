/*
Sim/circuit10
This is a sequential circuit. 
The circuit consists of combinational logic and one bit of memory (i.e., one flip-flop). 
The output of the flip-flop has been made observable through the output state.
Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
From the waveforms:

*/

module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  
);

  // state parameters
  localparam SO=0, S1=1;

  // state register
  reg current_state;

  // cominatorial block for determining output and next_state
  
  
  always @ (posedge clk) begin
    current_state <= ;
  end
  
endmodule
