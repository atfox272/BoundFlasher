// Name: Kickback Match generator
// Description: Generate kickback match's signal
module kickback_match_generator(
        // Input
        input           flick,
        input [4:0]     counter,
        // Output
        output  logic   kickback_match
);
        always_comb begin
                kickback_match = flick & ((counter == 5'd0) | (counter == 5'd5));
        end
endmodule

