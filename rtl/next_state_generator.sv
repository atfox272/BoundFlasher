// Name: Next state generator
// Description: Generate next state and some states of counter
module next_state_generator(
	// Input
	input 			rst_n,
	input 		[2:0]	main_state,
	input 		[4:0]	counter,
	input			kickback_match,
	// Output
	output 	logic 	[2:0]	main_state_n, 	// wire - next main state 
	output	logic	[4:0]	counter_load,	// wire - immediate load
	output	logic		counter_load_en,// wire - enable immediate load
	output 	logic 	[1:0]	count_state	// wire - count freeze-up-down 
);

// Main state coding
localparam INIT_STATE =         3'd0;
localparam ONLED0_15_STATE =    3'd1;
localparam OFFLED15_5_STATE =   3'd2;
localparam ONLED5_10_STATE =    3'd3;
localparam OFFLED10_0_STATE =   3'd4;
localparam ONLED0_5_STATE =     3'd5;
localparam OFFLED5_0_STATE =    3'd6;
// Counting encode
localparam COUNT_DIS =          2'd0;
localparam COUNT_UP_EN =        2'd1;
localparam COUNT_DOWN_EN =      2'd2;

always_comb begin
	// State generator
        main_state_n = main_state;
        counter_load = counter;
        counter_load_en = 1'b0;
        count_state = COUNT_DIS;

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
                                if (kickback_match) begin
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
                        OFFLED10_0_STATE: begin
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
                                main_state_n = INIT_STATE;
                                counter_load = 5'd0;
                                counter_load_en = 1'b0;
                        end
                endcase
        end
        // Decoder for counting enable
        case (main_state_n)
                INIT_STATE:             count_state = COUNT_DIS;
                ONLED0_15_STATE:        count_state = COUNT_UP_EN;
                ONLED5_10_STATE:        count_state = COUNT_UP_EN;
                ONLED0_5_STATE:         count_state = COUNT_UP_EN;
                OFFLED15_5_STATE:       count_state = COUNT_DOWN_EN;
                OFFLED10_0_STATE:       count_state = COUNT_DOWN_EN;
                OFFLED5_0_STATE:        count_state = COUNT_DOWN_EN;
                default:                count_state = COUNT_DIS;
        endcase


end

	

endmodule
