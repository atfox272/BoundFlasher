// Name: Bound Flasher FSM
// Description: Contain Main state register
module bound_flasher_fsm(
  // Input
  input                   clk,
  input                   rst_n,
  input           [2:0]   main_state_n,
  // Output
  output  reg     [2:0]   main_state
);
`include "constants.h"

always @(posedge clk, negedge rst_n) begin
  if(!rst_n) main_state <= `INIT_STATE;
  else main_state <= main_state_n;
end

endmodule

