`timescale 1ns/1ps

module tb;

    reg clk;
    reg reset;

    wire led;

    blink udt(clk, reset, led);

    always #1 clk = ~clk;

    initial begin
        clk = 1'b0;
        #5 reset = 1'b1;
        #10 reset = 1'b0;
        #1000 $stop; 
    end

endmodule