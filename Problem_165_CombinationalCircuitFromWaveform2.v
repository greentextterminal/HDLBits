/*
Sim/circuit2
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Division requires a lot of hardware resources. 
Instead of performing modulo division we can simply add up the total inputs with an adder and then use a comparator to check if the sum is 0, 2, or 4
The adder is being used to determine the number of inputs being asserted.
The comparison is being done to replicate the conditional behavior in the waveforms of the unknown circuit
By using compare operations we can use less resources. 
This is a good situation for a case statement
A computationally less expensive approach is proposed below:
*/
module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  // sum all the inputs (invoking an adder)
  wire [3:0] sum;
  assign sum = a + b + c + d;

  // capturing target number of inputs to check against as parameters
  localparam zero=0, two=2, four=4;
  
  always @ (*) begin
    case (sum)
      zero: q = 1;    // 0 inputs are asserted case
      two:  q = 1;    // 2 inputs are asserted case
      four: q = 1;    // 4 inputs are asserted case
      default: q = 0; // the default catches all other cases and drives q with 0
    endcase
  end 
  
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
Another approach if we would like to optimize further and drop the adder entirely:
The adder was being used to determine the number of inputs being asserted but it can be replaced by the following:
  - 0 input case
     - checking for all 0s directly (
  - 2 input case
    - check for 2 inputs by 
  - 4 input case
     - a 4 input AND gate, reduction AND the inputs, or directly check for all 1s (simple since the total input width is 4 bits)
By capturing the 0, 2, and 4 input logic as as gate level operations we can use less resources. This is a good situation for a case statement
A computationally less expensive approach is proposed below:
*/
module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  // concatenate all the inputs into a wire bundle
  wire [3:0] wire_bundle;
  assign wire_bundle = {a,b,c,d};

  // capturing number of inputs to check against as parameters
  localparam zero=0, two=2, four=4;
  
  always @ (*) begin
    if (~|wire_bundle) begin     // all inputs 0 case (0 case)
      q = 1;
    end
    else if (&wire_bundle) begin // all inputs 1 case (4 case)
      q = 1;
    end
    else if ( ((a^b) & (c^d)) | ((a&b) & (~(a^b))) | ((c&d) & (~(a&b))) ) begin // 2 input case
      q = 1;
    end
    else begin // if none of the above case, output is 0
      q = 0; 
    end
  end 
  
endmodule
