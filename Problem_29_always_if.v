// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 
    
    // using an assign statement
    assign out_assign = (sel_b1 & sel_b2) ? b : a; // if sel_b1 and sel_b2 are true then select b else select a
    
    // using procedural blocking statement
    always @ (*) begin
        if (sel_b1 & sel_b2) begin
           out_always = b; // select b if sel_b1 and sel_b2 are true 
        end
        else begin
            out_always = a; // else select a
        end
    end 

endmodule
