`timescale 1ns/1ps

module blink (
    input clk,
    input reset,
    output led
);

    reg [3:0] count;

    always @(posedge clk) begin
        if (reset) count <= 'd0;
        else count <= count + 1'b1;
    end

    assign led = count < 4'd8;

endmodule