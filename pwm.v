module PWM (
    input wire clk,
    input wire rst_n,
    input wire [31:0] duty_cycle,
    input wire [31:0] period,
    output reg pwm_out
);

    reg [31:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            if (counter < period)
                counter <= counter + 1;
            else
                counter <= 0;

            pwm_out <= (counter < duty_cycle) ? 1'b1 : 1'b0;
        end
    end

endmodule
