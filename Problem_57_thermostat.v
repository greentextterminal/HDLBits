module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
   // heating: mode = 1
   // cooling: mode = 0
    
    assign heater = mode & too_cold; // heater asserts if mode and too_cold asserted
    assign aircon = ~mode & too_hot; // cooler asserts if mode deasserted and too_cold asserted
    assign fan    = heater | aircon | fan_on; // fan asserts if heater or aircon or fan_on asserted

endmodule
