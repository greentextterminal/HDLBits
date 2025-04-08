module top_module( 
    input [99:0] in,
    output [99:0] out
);
    // Reversing the bit ordering of a 100 bit input vector
    // In this solution we are reversing the bit order by using a for loop. 
    // Rather than writing 100 assign statements like below, we can use a for loop to do the repetitive work
    // assign out[0] = in[99] , assign out[1] = in[98], ... assign out[n] = in[99-n]
    // The idea of 100 bit reversal is captured via this statement (assign out[n] = in[99-n])
    // Using our formula, all we have to do is put it into a for loop that increments i and we get bit reversal
    // @ i = 0  -> out[0]  = in[99]
    // @ i = 1  -> out[1]  = in[98]
    // ...
    // @ i = 99 -> out[99] = in[0]
    // The iterations above show the logic, but since this code is synthesized into actual hardware I think it's worth visualizing
    // In this instance we are essentially creating wire connections, so you can imagine in hardware we have something that looks like this:
    // in[99] -> out[0]
    // in[98] -> out[1]
    // ..    
    // ..     
    // ..    
    // in[0]  -> out[99]  
    
    // Using a for loop to avoid 100 assign statements since for loops replicate circuitry 
    reg [6:0] i; // declare the incrementer (counting up to 100, therfore we need 7 bits (express up to 128))
    always @ (*) begin
        for (i=0 ; i < 100 ; i = i + 1) begin
            out[i] = in[99-i];
        end 
    end 
    
endmodule
