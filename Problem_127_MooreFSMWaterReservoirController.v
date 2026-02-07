/*
Exams/ece241 2013 q4
This is a combinational circuit. 
Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
The pattern in the unknown circuits waveform is that for 2n inputs the output q goes high.
This inclues 0, so the possible inputs for which q is asserted is if 0, 2, or 4 inputs are asserted
*/

module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  // add up all the inputs to determine their sum
  wire [3:0] sum;
  assign sum = a + b + c + d;
  
  always @ (*) begin
    // check the sum if its a multiple of 2 by doing module division 
    if (sum % 2 == 0) begin // the remainder should be 0 after mod div by 2 for any 2n number
      q = 1;
    end
    else begin
      q = 0;
    end
  end 
  
endmodule
