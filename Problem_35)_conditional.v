module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);
    
    // Solution 1)
    // this checks each input value against every other input value
    // this works but its not pretty
    // assign min = (a < b & a < c & a < d) ? a :
    //              (b < a & b < c & b < d) ? b :
    //              (c < a & c < b & c < d) ? c :
    //     		      (d < a & d < b & d < c) ? d : 0;
    
    // Solution 2)    
    // since we just want to get the min value, we can create a 2 input min comparison.
    // these 2 input comparison outputs can drive intermediate wire vectors then similarly be compared again.
    // for a 4 input scenario we can compare inputs 1 and 2, inputs 3 and 4, and then compare their respective outputs
    // the final comparison will yield the min value since we are comparing the min val of (input 1,2) and (input 3,4)
    // Visualization below:
    // ab = min(input a, b)
    //                     \
    //						          min = min(ab, cd)
    //					           /
    // cd = min(input c, d)
    
    // intermediate wire vectors
    wire [7:0] ab, cd;
    
    // first 2 input comparison 
    assign ab = (a < b) ? a : b;
    
    // second 2 input comparison
    assign cd = (c < d) ? c : d;
    
    // final comarison of first two comparisons
    assign min = (ab < cd) ? ab : cd;

    // example test case
    // a : 4
    // b : 2
    // c : 1
    // d : 0

endmodule
