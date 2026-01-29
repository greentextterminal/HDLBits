module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
  // describing the muxes
  wire mux_out1, mux_out2;
  // mux 1
  assign mux_out1 = E ? w : Q;
  // mux 2
  assign mux_out2 = L ? R : mux_out1;

  // describing the DFF
  always @ (posedge clk) begin
    Q <= mux_out2;
  end

endmodule
