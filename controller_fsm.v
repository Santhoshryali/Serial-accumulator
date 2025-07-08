module controller_fsm #(parameter N = 8)(
    input clk, reset,
    input load_btn, stop_btn, done_in,
    output reg load_input,
    output reg clear_acc, ready_led, done_led
);
    localparam IDLE = 3'd0, LOAD = 3'd1, ADD = 3'd2, READY_STATE = 3'd3, DONE_OVERALL = 3'd4;

    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            clear_acc <= 1;
        end else begin
            state <= next_state;
            clear_acc <= 0;
        end
    end

    always @(*) begin
        load_input = 0;
        ready_led = 0;
        done_led = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (load_btn) next_state = LOAD;
            end
            LOAD: begin
                load_input = 1;
                next_state = ADD;
            end
            ADD: begin
                if (done_in) next_state = READY_STATE;
            end
            READY_STATE: begin
                ready_led = 1;
                if (load_btn) next_state = LOAD;
                else if (stop_btn) next_state = DONE_OVERALL;
            end
            DONE_OVERALL: begin
                done_led = 1;
                if (!stop_btn) next_state = IDLE;
            end
        endcase
    end
endmodule