module top_module (
    input  [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    
    // 16'he06b	left arrow
	  // 16'he072	down arrow
	  // 16'he074	right arrow
	  // 16'he075	up arrow
    // Anything else none (0)
    
    always @ (*) begin
      // equivalent to a prior default, makes default case redundant, and helps prevent creating latches
   		up = 1'b0; down = 1'b0; left = 1'b0; right = 1'b0; 
      case (scancode)
        16'he06b : left  = 1;
			  16'he072 : down  = 1;	
			  16'he074 : right = 1;
			  16'he075 : up    = 1;	
      endcase
    end

endmodule
