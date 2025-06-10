module servo #(
    parameter CLK_FREQ = 25_000_000,
    parameter PERIOD = 40              // período de 40 ciclos
)(
    input wire clk,
    input wire rst_n,
    output wire servo_out
);

    // Pulso de 2 ciclos (5%) e 4 ciclos (10%)
    localparam DUTY_MIN = 2;
    localparam DUTY_MAX = 4;
    localparam TIME_5S = CLK_FREQ * 5;

    reg [31:0] current_duty = DUTY_MIN;
    reg [31:0] counter = 0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
            current_duty <= DUTY_MIN;
        end else begin
            if (counter >= TIME_5S) begin
                counter <= 0;
                current_duty <= (current_duty == DUTY_MIN) ? DUTY_MAX : DUTY_MIN;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    PWM pwm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .duty_cycle(current_duty),
        .period(PERIOD),
        .pwm_out(servo_out)
    );

endmodule
