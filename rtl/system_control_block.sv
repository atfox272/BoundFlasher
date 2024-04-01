odule system_control_block(
        // Input
        input                   clk,
        input                   flick,
        input                   rst_n,
        // Output 
        output logic    [4:0]   counter
);
// Main state coding
localparam INIT_STATE =         3'd0;
localparam ONLED0_15_STATE =    3'd1;
localparam OFFLED15_5_STATE =   3'd2;
localparam ONLED5_10_STATE =    3'd3;
localparam OFFLED10_0_STATE =   3'd4;
localparam ONLED0_5_STATE =     3'd5;
localparam OFFLED5_0_STATE =    3'd6;
// Counter init value
localparam COUNTER_INIT =       5'd0;
// Counting encode
localparam COUNT_DIS =          2'd0;
localparam COUNT_UP_EN =        2'd1;
localparam COUNT_DOWN_EN =      2'd2;

logic   [2:0]   main_state;     // reg
logic   [2:0]   main_state_n;   // wire
logic   [4:0]   counter_n;      // wire
logic   [4:0]   counter_load;   // wire
logic           counter_load_en;// wire


logic   [4:0]   counter_inc;    // wire
logic   [4:0]   counter_dec;    // wire
logic   [1:0]   count_en;       // Count encode: 0-Disable || 1-Up || 2-Down
logic           kickback_match; // wire

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
end

// Next counter generator
always_comb begin
        counter_inc = counter + 1'b1;
        counter_dec = counter - 1'b1;
        count_en = COUNT_DIS;
        counter_n = counter;

        // Decoder for counting enable
        case (main_state_n)
                INIT_STATE:             count_en = COUNT_DIS;
                ONLED0_15_STATE:        count_en = COUNT_UP_EN;
                ONLED5_10_STATE:        count_en = COUNT_UP_EN;
                ONLED0_5_STATE:         count_en = COUNT_UP_EN;
                OFFLED15_5_STATE:       count_en = COUNT_DOWN_EN;
                OFFLED10_0_STATE:       count_en = COUNT_DOWN_EN;
                OFFLED5_0_STATE:        count_en = COUNT_DOWN_EN;
                default:                count_en = COUNT_DIS;
        endcase

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

// Main State
always @(posedge clk) begin
        main_state <= main_state_n;
end

// Counter
always @(posedge clk) begin
        counter <= counter_n;
end

endmodule


