`timescale 1ns / 1ps
`include "hola.v"

module vga_tb;

    // Registros para las entradas
    reg clk;
    reg reset;

    // Cables para las salidas
    wire h_sync;
    wire v_sync;
    wire display_enable;
    wire [9:0] x_count;
    wire [9:0] y_count;

    // Instancia del módulo vga_controller
    vga_controller dut (
        .clk(clk),
        .reset(reset),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .display_enable(display_enable),
        .x_count(x_count),
        .y_count(y_count)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #20 clk = ~clk; // Periodo de 40ns (25MHz)
    end

    // Procedimiento de prueba
    initial begin
        $dumpfile("vga_tb.vcd"); // Archivo de salida de la simulación
        $dumpvars(0, vga_tb); // Variables a volcar en el archivo

        // Inicialización
        reset = 1;
        #100; // Mantener reset alto por varios ciclos de reloj

        // Liberar el reset
        reset = 0;

        // Simulación durante un tiempo suficiente para observar varios ciclos de sincronización
        #2; // Simulación durante 200000ns (200us)
        
        // Finalizar simulación
        $stop;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Time=%0t : x_count=%d, y_count=%d, h_sync=%b, v_sync=%b, display_enable=%b",
                 $time, x_count, y_count, h_sync, v_sync, display_enable);
    end

endmodule
