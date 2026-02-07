/*
Bugs addsubz
The following adder-subtractor with zero flag doesn't work. Fix the bug(s).

// synthesis verilog_input_version verilog_2001
module top_module ( 
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);//

    always @(*) begin
        case (do_sub)
          0: out = a+b;
          1: out = a-b;
        endcase

        if (~out)
            result_is_zero = 1;
    end

endmodule
*/

module top_module ( 
    input do_sub, // if 1 sub else add
    input [7:0] a,
    input [7:0] b,
    output [7:0] out,
    output result_is_zero
);

    always @(*) begin
        case (do_sub)
          0: out = a+b; // if do_sub is 0, add
          1: out = a-b; // if do_sub is 1, sub
        endcase

      if (!out) begin // checking for output to be 0 using logical not ! (all zero value becomes a logical True)
        result_is_zero = 1;
      end
      else begin
        result_is_zero = 0;
      end
    end

endmodule
