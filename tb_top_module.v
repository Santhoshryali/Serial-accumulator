`timescale 1ns / 1ps

module tb_top_module;

    reg clk = 0;
    reg reset = 1;
    reg load_btn = 0;
    reg stop_btn = 0;
    wire [7:0] sum_out;
    wire ready_led, done_led;

    top_module #(.SIM(1)) dut  (
        .clk(clk),
        .reset(reset),
        .load_btn(load_btn),
        .stop_btn(stop_btn),
        .sum_out(sum_out),
        .ready_led(ready_led),
        .done_led(done_led)
    );

    always #5 clk = ~clk; 

    initial begin
        $display("Time=%0t | Sum=%0d | Ready=%b | Done=%b", $time, sum_out, ready_led, done_led);

        #20 reset = 0;

        repeat (10) begin
            #50 load_btn = 1;
            #10 load_btn = 0;
            #100;  
        end

        #50 stop_btn = 1;
        #20 stop_btn = 0;

        #200;
        $stop;
    end

    always @(posedge clk)
        $display("Time=%0t | Sum=%0d | Ready=%b | Done=%b", $time, sum_out, ready_led, done_led);

endmodule
