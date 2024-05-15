`timescale 1ns / 1ps 

module clock_divider #(parameter div_value = 1)(
    input wire clk,
    output reg divide_clk = 0
);

    integer counter_value = 0;

    always @(posedge clk) begin
        if (counter_value == div_value)
            counter_value <= 0;
        else
            counter_value <= counter_value + 1;
        
        if (counter_value == div_value)
            divide_clk <= ~divide_clk ;
    end

endmodule
