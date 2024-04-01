// Name: Bound Flasher FSM
// Description: Contain Main state register
module bound_flasher_fsm(
	// Input
	input clk,
	input  [2:0] main_state_n,
	// Output
	output [2:0] main_state
);
	always @(posedge clk) begin
		main_state <= main_state_n;
	end

endmodule
