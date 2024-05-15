`timescale 1ns / 1ps 
`include "v_counter.v"
`include "h_counter.v"
 
module vga_tb(
    input clk,
    input Hsync,
    input Vsync,
    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue
);

    wire clk_25MHz;
    wire enable_V_counter;
    wire [15:0] H_count_value;
    wire [15:0] V_count_value;

    // Instantiation de los módulos v_counter y h_counter
    v_counter v_counter_inst (
        .clk_25MHz(clk_25MHz),
        .enable_V_counter(enable_V_counter),
        .V_count_value(V_count_value)
    );

    h_counter h_counter_inst (
        .clk_25MHz(clk_25MHz),
        .enable_V_counter(enable_V_counter),
        .H_count_value(H_count_value)
    );

    // Asignaciones para Hsync y Vsync
    assign Hsync = (H_count_value < 96) ? 1'b1 : 1'b0;
    assign Vsync = (V_count_value < 2) ? 1'b1 : 1'b0;

    assign Red = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 && V_count_value > 34) ? 4'hf: 4'h0;
    assign Green = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 && V_count_value > 34) ? 4'hf: 4'h0;
    assign Blue = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 && V_count_value > 34) ? 4'hf: 4'h0;



endmodule
