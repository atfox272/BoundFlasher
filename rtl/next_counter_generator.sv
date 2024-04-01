// Name: Next counter generator
// Description: Generate next counter
module next_counter_generator(
	// Input
	input rst_n,
	input 		[4:0] 	counter,
	input 		[4:0] 	counter_load,
	input 			counter_load_en,
	input 		[1:0]	counter_state,
	// Output
	output logic	[4:0] 	counter_n
);
// Counter init value
localparam COUNTER_INIT =       5'd0;

logic [4:0] counter_inc;	// counter increasing
logic [4:0] counter_dec;	// counter decreasing

// Next counter generator
always_comb begin
        counter_inc = counter + 1'b1;
        counter_dec = counter - 1'b1;
        counter_n = counter;

        // Counter generator
        if (!rst_n) counter_n = COUNTER_INIT;
        else begin
                if (counter_load_en) counter_n = counter_load;
                else begin
                        case(count_en)
                                COUNT_DIS:      counter_n = COUNTER_INIT;
                                COUNT_UP_EN:    counter_n = counter_inc;
                                COUNT_DOWN_EN:  counter_n = counter_dec;
                                default:        counter_n = counter;
                        endcase
                end
        end
end

endmodule
