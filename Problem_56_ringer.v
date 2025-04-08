module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    assign ringer = ring & ~vibrate_mode; // ring asserts if ring asserted and vibrate deasserted
    assign motor  = ring & vibrate_mode;  // motor asserts if ring and vibrate asserted

endmodule
