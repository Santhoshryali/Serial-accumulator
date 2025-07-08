module top_module #(
  parameter SIM = 0
  )(
    input clk,
    input reset,
    input load_btn,
    input stop_btn,
    output [7:0] sum_out,
    output ready_led,
    output done_led
);

    wire slow_clk;
    wire load_input, clear_acc;
    wire [7:0] data_from_rom;
    wire done;
    wire [7:0] addr;
    reg [7:0] rom_addr;
    wire used_clk = SIM ? clk : slow_clk;

    clock_divider #(.DIV_FACTOR(1000000)) clk_div_inst (
    .clk_in(clk),
    .reset(reset),
    .clk_out(slow_clk)
   );

    controller_fsm fsm_inst (
        .clk(used_clk),
        .reset(reset),
        .load_btn(load_btn),
        .stop_btn(stop_btn),
        .done_in(done),
        .load_input(load_input),
        .clear_acc(clear_acc),
        .ready_led(ready_led),
        .done_led(done_led)
    );

    always @(posedge used_clk or posedge reset) begin
        if (reset)
            rom_addr <= 0;
        else if (load_input)
            rom_addr <= rom_addr + 1;
    end

    assign addr = rom_addr;

    input_rom rom_inst (
        .clk(used_clk),
        .addr(addr),
        .data_out(data_from_rom)
    );

    accumulator acc_inst (
        .clk(used_clk),
        .reset(reset),
        .load_input(load_input),
        .input_data(data_from_rom),
        .clear_acc(clear_acc),
        .sum_out(sum_out),
        .done(done)
    );

endmodule
