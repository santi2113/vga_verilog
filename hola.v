`timescale 1ns / 1ps

module vga_controller(
    input wire clk,         // Reloj de entrada, se espera 25MHz para VGA 640x480@60Hz
    input wire reset,       // Señal de reset
    output wire h_sync,     // Señal de sincronización horizontal
    output wire v_sync,     // Señal de sincronización vertical
    output wire display_enable, // Señal de habilitación de display
    output wire [9:0] x_count, // Contador horizontal (posicion X)
    output wire [9:0] y_count  // Contador vertical (posicion Y)
);

    // Constantes de sincronización VGA 640x480@60Hz
    localparam H_DISPLAY       = 640;
    localparam H_FRONT_PORCH   = 16;
    localparam H_SYNC_PULSE    = 96;
    localparam H_BACK_PORCH    = 48;
    localparam H_TOTAL         = H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

    localparam V_DISPLAY       = 480;
    localparam V_FRONT_PORCH   = 10;
    localparam V_SYNC_PULSE    = 2;
    localparam V_BACK_PORCH    = 33;
    localparam V_TOTAL         = V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

    // Contadores
    reg [9:0] h_counter;
    reg [9:0] v_counter;

    // Señales de sincronización
    assign h_sync = (h_counter >= (H_DISPLAY + H_FRONT_PORCH)) && (h_counter < (H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE));
    assign v_sync = (v_counter >= (V_DISPLAY + V_FRONT_PORCH)) && (v_counter < (V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE));
    assign display_enable = (h_counter < H_DISPLAY) && (v_counter < V_DISPLAY);
    assign x_count = (display_enable) ? h_counter : 10'b0;
    assign y_count = (display_enable) ? v_counter : 10'b0;

    // Contador horizontal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            h_counter <= 0;
        end else begin
            if (h_counter == (H_TOTAL - 1)) begin
                h_counter <= 0;
            end else begin
                h_counter <= h_counter + 1;
            end
        end
    end

    // Contador vertical
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            v_counter <= 0;
        end else if (h_counter == (H_TOTAL - 1)) begin
            if (v_counter == (V_TOTAL - 1)) begin
                v_counter <= 0;
            end else begin
                v_counter <= v_counter + 1;
            end
        end
    end

endmodule
