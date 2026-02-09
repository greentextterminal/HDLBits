/*
Sim/circuit9
This is a sequential circuit. 
Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
Based on the waveforms circuit appears to be a counter that count from 0 to 6 and repeats until being reset.
There is an input 'a' which when asserted loads the counter with a value of 4 and is held until the reset is released.
Upon release, the counter continues to count up but from 4 until 6 is reached.
*/

module top_module (
    input clk,
    input a,
    output [3:0] q 
);

  // count reg
  reg [3:0] count;

  // creating the counter
  always @ (posedge clk) begin
    if (a) begin // a acts as a reset that loads the register with a value of 4
      count <= 4;
    end
    else if (count == 6) begin // if the count hits 6 then the counter rolls over to 0
      count <= 0;
    end
    else begin
      count <= count + 1;
    end
  end

  // assigning out with the counters contents
  assign q = count;
  
endmodule
