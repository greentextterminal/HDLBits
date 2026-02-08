/*
Sim/circuit3
This is a combinational circuit. 
Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
From the waveforms the pattern that emerges is that q is asserted for any combination of input a or b and any other or any other number of inputs:
input a combinations:
ax   -> ex: ad, ab
axx  -> ex: abc, acd
axxx -> ex: abcd

input b combinations:
bx   -> ex: ba, bd
bxx  -> ex: bca, bcd
bxxx -> ex: bacd
*/

/*
Given what we know about a or b needing to be asserted alongside any other or any other number of inputs we can create the following:
a and b will be mandatory prequalifiers
since we need at least 1 other input to be asserted alongside a or b we can create wire bundles of the other inputs and check for their assertion via a reduction OR
a and b will be be ANDed with their corresponding reduction ORd wire bundle of remaining inputs:

a & |{b,c,d} 
b & |{a,c,d}

*/

module top_module (
    input a,
    input b,
    input c,
    input d,
    output q 
);
  // creating wire bundles to test for all remainng input assertion
  wire [2:0] a_input_check, b_input_check;

  // creating wire bundle to test for only a & b case (q must deassert if only a and b are asserted)
  wire [1:0] ab_input_check;

  // assigning the bundles with the inputs that remain (non overlapping inputs relative to the a or b input that is being tested for)
  assign a_input_check = {b,c,d};
  assign b_input_check = {a,c,d};
  assign ab_input_check = {c,d}; // edge case hanlding, deassert q if only a and b are asserted
  

  // creating conditional logic which consists of a or b assertion of prequalification followed by testing for if any of the remaining inputs were asserted
  always @ (*) begin
    if (a & b & ~|ab_input_check) begin
      q = 0;
    end
    else if (a & |a_input_check) begin // testing for a and any other remaining input being asserted
      q = 1;
    end
    else if (b & |b_input_check) begin // testing for b and other remaning inputs being asserted
      q = 1;
    end
    else begin
      q = 0;
    end
  end

endmodule
