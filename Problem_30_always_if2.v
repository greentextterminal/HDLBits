module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); 

    always @(*) begin
        if (cpu_overheated)
           shut_off_computer = 1;
        else
           shut_off_computer = 0;
    end

    always @(*) begin
        if (~arrived & ~gas_tank_empty)
           keep_driving = 1'b1; // keep driving
        else
           keep_driving = 1'b0; // dont keep driving
    end
    
    // arrived=0, gas_empty=0, drive = 1
    // arrived=0, gas_empty=1, drive = 0
    // arrived=1, gas_empty=0, drive = 0
    // arrived=1, gas_empty=1, drive = 0

endmodule
