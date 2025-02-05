module top_module ( input [1:0] A, 
                    input [1:0] B, 
                    output z 
); 

    // output 1 if A==B, else output 0
    always @ (*) begin
        if (A == B) begin
            z = 1'b1; 
        end
        else begin
            z = 1'b0;
        end
    end 
endmodule
