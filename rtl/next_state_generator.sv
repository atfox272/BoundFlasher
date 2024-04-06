// Name: Next state generator
// Description: Generate next state and some states of counter
module next_state_generator(
        // Input
        input           [2:0]   main_state,
        input           [4:0]   counter,
        input                   flick,
        input                   kickback_match,
        // Output
        output  logic   [2:0]   main_state_n,   // wire - next main state
        output  logic   [4:0]   counter_load,   // wire - immediate load
        output  logic           counter_load_en,// wire - enable immediate load
        output  logic   [1:0]   count_state     // wire - count freeze-up-down
);

always_comb begin
        // State generator
        main_state_n = main_state;
        counter_load = counter;
        counter_load_en = 1'b0;
        count_state = COUNT_DIS;

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
                        if (counter == 5'd11) begin
                                main_state_n = OFFLED10_0_STATE;
                        end
                end
                OFFLED10_0_STATE: begin
                        if (kickback_match) begin
                                counter_load = 5'd11;
                                counter_load_en = 1'b1;
                        end
                        else if (counter == 5'd0) begin
                                main_state_n = ONLED0_5_STATE;
                        end
                end
                ONLED0_5_STATE: begin
                        if (counter == 5'd6) begin
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

        // Decoder for counting enable
        case (main_state_n)
                INIT_STATE:                                             count_state = COUNT_DIS;
                ONLED0_15_STATE, ONLED5_10_STATE, ONLED0_5_STATE:       count_state = COUNT_UP_EN;
                OFFLED15_5_STATE, OFFLED10_0_STATE, OFFLED5_0_STATE:    count_state = COUNT_DOWN_EN;
                default:                                                count_state = COUNT_DIS;
        endcase

end


endmodule

