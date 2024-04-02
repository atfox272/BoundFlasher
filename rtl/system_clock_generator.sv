// Name: System Clock generator
// Description: Generate clock
module system_clock_generator
#(
	parameter PRESCALER_SELECT_W	= 2,	// Selector register's width
	parameter PRESCALER_0		= 1,	// smallest frequency * 64 - Forwading from source clock
	parameter PRESCALER_1		= 4,	// smallest frequency * 16
	parameter PRESCALER_2		= 16,	// smallest frequency * 4
	parameter PRESCALER_3		= 64	// smallest frequency * 1
)
(
        // Input
        input   clk,
        input   rst_n,
        input 	enable,
	input   [PRESCALER_SELECT_WDITH - 1:0] prescaler_sel,
        // Output
        output  clk_div
);
        // Prescaler selector encoding
	localparam PRES_0_ENC           = 0;
        localparam PRES_1_ENC           = 1;
        localparam PRES_2_ENC           = 2;
        localparam PRES_3_ENC           = 3;
        // Width of dividing counter
        localparam PRES_1_COUNTER_W     = $clog2(PRESCALER_1);
        localparam PRES_2_COUNTER_W     = $clog2(PRESCALER_2);
        localparam PRES_3_COUNTER_W     = $clog2(PRESCALER_3);
        localparam COUNTER_W            = $clog2(PRESCALER_3);
	
	reg 	[COUNTER_W - 1:0] 	div_counter;
	logic	[COUNTER_W - 1:0] 	div_counter_n;	// wire
	logic 	[COUNTER_W - 1:0]	div_counter_inc;// wire
	logic				clk_div_0;	// wire
	logic				clk_div_1;	// wire
	logic				clk_div_2;	// wire
	logic				clk_div_3;	// wire

	// Dividing counter generator
	always_comb begin
		div_counter_inc = div_counter + 1'b1;
		div_counter_n = div_counter;
		if(!rst_n) 		div_counter_n = {COUNTER_W{1'b0}};
		else if (!enable) 	div_counter_n = {COUNTER_W{1'b0}};
		else 			div_counter_n = div_counter_inc;
	end
	
	// Clock selector
	always_comb begin
		clk_div = clk_div_0;
		clk_div_0 = clk;
		clk_div_1 = div_counter[PRES_1_COUNTER - 1];
		clk_div_2 = div_counter[PRES_2_COUNTER - 1];
		clk_div_3 = div_counter[PRES_3_COUNTER - 1];
		case (prescaler_sel)
			PRES_0_ENC: clk_div = clk_div_0;
			PRES_1_ENC: clk_div = clk_div_1;
			PRES_2_ENC: clk_div = clk_div_2;
			PRES_3_ENC: clk_div = clk_div_3;
			default:    clk_div = clk_div_0;
		endcase 
	end
	
	// Counter memory
	always @(posedge clk) begin
		div_counter <= div_counter_n;
	end
endmodule
