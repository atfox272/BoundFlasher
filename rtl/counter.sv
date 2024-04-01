// Name: counter 
// Description: Contains counter register 
module counter(
	// Input 
	input clk,
	input [4:0] counter_n,
	// Output
	output [4:0] counter
);
	always @(posedge clk) begin
		counter <= counter_n;
	end
endmodule
