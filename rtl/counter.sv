// Name: counter
// Description: Contains counter register
module counter(
  // Input
  input                   clk,
  input                   rst_n,
  input           [4:0]   counter_n,
  // Output
  output  reg     [4:0]   counter
);

`include "constants.h"

always @(posedge clk, negedge rst_n) begin
  if (!rst_n) counter <= `COUNTER_INIT;
  else counter <= counter_n;
end
endmodule

