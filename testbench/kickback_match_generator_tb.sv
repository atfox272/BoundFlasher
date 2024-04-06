module kickback_match_generator_tb;

reg             flick;
reg             [4:0] counter;

wire     kickback_match;

kickback_match_generator kickback(
    // Input
    .flick(flick),
    .counter(counter),
    // Output
    .kickback_match(kickback_match)
);

initial begin
    #20
    flick <= 1'b0;
    counter <= 5'd0;

    #20
    counter <= 5'd5;

    #20
    counter <= 5'd0;

    #20
    flick <= 1'b1;

    #20
    counter <= 5'd5;
    #1000;
    $finish;
end

always @(*) begin
    $monitor ("time = %t, flick = %b, counter = %b, kickback_match = %b", $time, flick, counter, kickback_match);
end

endmodule

