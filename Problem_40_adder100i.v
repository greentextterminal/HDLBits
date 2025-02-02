module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    // Creating a 100 bit binary ripple carry adder via 100 full adder instantiations
    // We are adding two 100 bit numbers, therfore there are 200 bits in total and
    // since our full adder deals with 2 bits at a time (200 bits / (2 bits / 1 FA))) we need 100 full adder instantiations
    // 2BFA : 2 Bit Full Adder
    // Below is a visualization of the 100 bit ripple carry adder chain we are implementing
    //         ___________                  ___________	                                ___________	
    //         |2BFA_0   |                  |2BFA_1   |                  .....          |2BFA_99  |	
    // cin  -> |cin  cout|--cout[0]------->	|cin  cout|--cout[1]-------> ..... -------> |cin  cout|--cout[99]-------> 
    // a[0] -> |a    sum |->sum[0]	a[1] -> |a    sum |->sum[1]          ..... a[98] -> |a    sum |->sum[99]
    // b[0] -> |b        |          b[1] ->	|b        |	                 ..... b[98] -> |b        |		
    //         |_________|                  |_________|                  .....          |_________|	
    //
    // In order to create the above configuration in a neatly packaged for loop we need to think about how we handle our cin and couts.
    // Our for loop can create as many copies of our 2 bit full adder as we'd like but how can we handle the initial cin into
    // our first FA, followed by the cout[i] feeding into the next FA's cin (cin[i+1]), ending with the final cout?
    // Every cout of every FA is 1 bit, so 100 FA's * 1 bit = 100 bits. We also need to take into account the initial cin which is 1 bit.
    // 1 bit (cin) + 100 bits (cout bits from each FA) = 101 bits 
    // With this in mind can create a 101 wire vector to stagger the vector by an index of 1.
    // @ i = 0 the wire vector has our cin value and is the cin for our first FA
    // The first FAs cout is assigned to the idx 0 of the 100bit cout vector, which is the 1st idx (2nd position) of the carry vector
    // @ i = 1, the second FAs cout drives idx 1 of the 100bit cout vector, which is idx 2 (3rd position) of the carry vector
    // and so on...
    // 
    // Implementing our design below
    //
    // carry wire vector consists of: [cout[99], cout[98], ..., cout[0], cin]
    //
  // carry = [cin,             cout[0],                      cout[1],..........., cout[98],              cout[99] ]
    //           |               ^    |                      ^    |				        ^     |				         ^     |
    //	         |  ___________  |    |  		    ___________	 |	  |			          |     |   ___________	 |     |
    //           |  |2BFA_0   |  |    |     	  |2BFA_1   |	 |	  |			     .... |     |   |2BFA_99  |	 |	   |
    //           -> |cin  cout|---    --------->|cin  cout|---    ---------> ....-      --> |cin  cout|--- 	   --------->
    //      a[0] -> |a	  sum |->sum[0]	a[1] -> |a    sum |->sum[1]          ..... a[98] -> |a    sum |->sum[99]
    //      b[0] -> |b        |		      b[1] ->	|b        |					         ..... b[98] -> |b        |		
    //              |_________|					        |_________|					         .....          |_________|	
    //
    
    // creating a 100 + 1 bit wide in order to accodomate the final carry out bit from the 100th full adder 
    wire [100:0] carry; 
    assign carry = {cout, cin}; // creating a 100 + 1 bit wire via concatenation
    
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : rip_carr_addr100 // the gen blocks name
        	full_adder2 fa2(.a(a[i]),
                            .b(b[i]),
                            .cin(carry[i]),
                            .sum(sum[i]),
                            .cout(cout[i]));    
        end
    endgenerate 

endmodule


// this is a 2 bit full adder
//		    ___________
//        |2BFA     | 
// cin -> |cin	cout|->
// a   -> |a	  sum |->
// b   -> |b        |	
//        |_________|	
module full_adder2(
    input a,
    input b,
    input cin,
    output [1:0] sum,
    output cout);
    
    // sum is calculated by adding all the inputs and assigning it to our 2 bit wide sum output
    assign sum = a + b + cin; 
    
    // the carry out (cout) can be found by indexing the MSB of the sum (sum[1])
    assign cout = sum[1];
    
endmodule
