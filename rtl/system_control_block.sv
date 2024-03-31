module system_control_block(
	// Input
	input clk,
	input flick,
	input rst_n,
	// Output 
	output [4:0] counter
);
// Main state coding
localparam INIT_STATE = 	3'd0;
localparam ONLED0_15_STATE = 	3'd1;
localparam OFFLED15_5_STATE = 	3'd2;
localparam ONLED5_10_STATE = 	3'd3;
localparam OFFLED10_0_STATE = 	3'd4;
localparam ONLED0_5_STATE = 	3'd5;
localparam OFFLED5_0_STATE = 	3'd6;
// Counter init value
localparam COUNTER_INIT = 	5'd0;
// Counter encode
localparam COUNT_DIS = 		2'd0;
localparam COUNT_UP_EN = 	2'd1;
localparam COUNT_DOWN_EN = 	2'd2;

reg 	[2:0] 	main_state;
wire	[2:0]	main_state_n;
reg	[4:0]	counter;
wire	[4:0]	counter_n;
wire	[4:0]	counter_load;
wire		counter_load_en;


wire 	[4:0]	counter_inc;
wire 	[4:0]	counter_dec;
wire 	[1:0]	count_en;	// Count encode: 0-Disable || 1-Up || 2-Down
wire		kickback_match;

// Kickback Match generator
always_comb begin
	kickback_match = flick & ((counter == 5'd5) | (counter == 5'd0));
end


// Next state generator
always_comb begin
	main_state_n = main_state;
	counter_load = counter;
	counter_load_en = 1'b0;
	
	if(!rst_n) begin
		main_state_n = INIT_STATE;
		counter_load = 5'd0;
		counter_load_en = 1'b0;
	end 
	else begin
		case(main_state)
			INIT_STATE: begin
				if(flick) begin
					main_state_n = ONLED0_15_STATE;		
				end
			end
			ONLED0_15_STATE: begin
				if (counter == 5'd16) begin
					main_state_n = OFFLED15_5_STATE;
				end
			end
			OFFLED15_5_STATE: begin
				if (kichback_match) begin
					counter_load = 5'd16;
					counter_load_en = 1'b1;
				end
				else if (counter == 5'd5) begin
					main_state_n = ONLED5_10_STATE;
				end
			end
			ONLED5_10_STATE: begin
				if (counter == 5'd10) begin
					main_state_n = OFFLED10_0_STATE;
				end
			end
			OFFLED_10_0_STATE: begin
				if (kickback_match) begin
					counter_load = 5'd10;
					counter_load_en = 1'b1;
				end
				else if (counter == 5'd0) begin
					main_state_n = ONLED0_5_STATE;
				end
			end
			ONLED0_5_STATE: begin
				if (counter == 5'd5) begin
					main_state_n = OFFLED5_0_STATE;
				end
			end
			OFFLED5_0_STATE: begin
				if (counter == 5'd0) begin
					main_state_n = INIT_STATE;
					counter_load = 5'b0;
					counter_load_en = 1'b1;
				end
			end
			default: begin
				main_state = INIT_STATE;
				counter_load = 5'd0;
				counter_load_en = 1'b0;
			end
		endcase
	end
end

// Next counter generator
always_comb begin
	counter_inc = counter + 1'b1;
	counter_dec = counter - 1'b1;
	counter_en = main_state != INIT_STATE;
	counter_n = counter;
	counter_en = 	(main_state == INIT_STATE) ? COUNT_DIS :
			(main_state == ONLED0_15_STATE | main_state == ONLED5_10_STATE | main_state == ONLED0_5_STATE) ? COUNT_UP_EN : COUNT_DOWN_EN;	
	if (counter_load_en) counter_n = counter_load;
	else begin 
		case(count_en)
			COUNT_DIS: counter_n = COUNTER_INIT;
			COUNT_UP_EN: counter_n = counter_inc;
			COUNT_DOWN_EN: counter_n = counter_dec;
			default: counter_n = counter;
		endcase
	end
end

// Main State 
always @(posedge clk) begin
	main_state <= main_state_n;
end

// Counter 
always @(posedge clk) begin
	counter <= coutner_n;
end

endmodule
