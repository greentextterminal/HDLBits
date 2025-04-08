module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    
    // case statement for the 9 cases, handle the remaining cases with a default
    always @ (*) begin
        case (sel) 
            16'd0 : out = a;
            16'd1 : out = b;
            16'd2 : out = c;
            16'd3 : out = d;
            16'd4 : out = e;
            16'd5 : out = f;
            16'd6 : out = g;
            16'd7 : out = h;
            16'd8 : out = i;
            default : out = {16{1'b1}};
        endcase
    end

endmodule
