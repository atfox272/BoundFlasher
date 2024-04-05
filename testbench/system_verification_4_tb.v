module script_tb;

parameter CYCLE = 2;

reg             clk;
reg             rst_n;
reg             flick;

wire [15:0]     led_state;

bound_flasher uut(
  // Input
  .clk(clk),
  .rst_n(rst_n),
  .flick(flick),
  // Output
  .led_state(led_state)
  );

initial begin
  clk = 1'b0;
  forever #(CYCLE/2) clk = ~clk;
end


initial begin
  #(CYCLE * 20);
  $display ("--------------------------------------");
  rst_n = 1'b0;
  #(CYCLE * 3) rst_n = 1'b1;
  #(CYCLE * 3) flick = 1'b1;
  #(CYCLE * 3) flick = 1'b0;
  #(CYCLE * 100) $finish;
end

initial begin
  #(CYCLE * 66) flick = 1'b1;
  #(CYCLE * 5) flick = 1'b0;
  #(CYCLE * 7) flick = 1'b1;
  #(CYCLE * 5) flick = 1'b0;
  #(CYCLE * 7) flick = 1'b1;
  #(CYCLE * 5) flick = 1'b0;
  #(CYCLE * 7) flick = 1'b1;
  #(CYCLE * 5) flick = 1'b0;
  #(CYCLE * 7) flick = 1'b1;
  #(CYCLE * 5) flick = 1'b0;
  #(CYCLE * 7) flick = 1'b1;
end

initial begin
  $recordfile ("waves");
  $recordvars ("depth=0", script_tb);
end

initial begin
  forever  #(CYCLE) $display ("Time slot:%0t\tLED_STATE:\t%16b,Flick:%0b", $time, led_state, flick);
end

endmodule

