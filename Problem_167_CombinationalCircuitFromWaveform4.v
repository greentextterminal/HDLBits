/*
sim/circuit4
This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.
*/

/*
After selecting all of the combinations of a, b, c, and d for which q goes high a pattern emerged.
The a and d inputs could be ignored, leaving the b and c inputs. 
Looking at the b and c inputs the q is high for any combination of b and c being set high.
Therefore, the output q goes high if b OR c.
*/

module top_module (
    input a,
    input b,
    input c,
    input d,
    output q 
);

    assign q = b | c;

endmodule
