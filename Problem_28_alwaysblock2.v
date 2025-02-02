// synthesis verilog_input_version verilog_2001
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );
    
    // continuous assignments
    assign out_assign = a ^ b;
    
    // procedural blocking assignments for combinational logic
    always @ (*)
        begin
           out_always_comb = a ^ b;
        end
    
    // procedural non blocking assignmetns for clocked 
    always @ (posedge clk)
		begin
           out_always_ff <= a ^b; 
        end
endmodule
