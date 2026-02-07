/*
Bugs nand3
This three-input NAND gate doesn't work. Fix the bug(s).
You must use the provided 5-input AND gate:
module andgate ( output out, input a, input b, input c, input d, input e );
*/

module top_module (
    input a, 
    input b, 
    input c, 
    output out
);
    /* 3 input NAND gate from a 5 input AND
       drive d and e with any one of the three input a,b,c signals to fill in values for the undriven d and e inputs
       this logic cleanly replicates 3 input behavior while working with a 5 input NAND gate
    */

  // three input AND
  andgate inst1 (.a(a), // a ----->a
                 .b(b), // b ----->b
                 .c(c), // c -| 
                 .d(c), // c -|--->c 
                 .e(c), // c _| 
                 .out(nand_out)  
                ); 

  // three input NAND
  wire nand_out;
  assign out = ~nand_out;

endmodule
