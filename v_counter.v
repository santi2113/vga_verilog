`timescale 1ns / 1ps 
 
module v_counter(
    input clk_25MHz,
    input enable_V_counter,
    output reg [15:0] V_count_value = 0
);

    always@(posedge clk_25MHz)begin
      if (enable_V_counter == 1'b1) begin
         if(V_count_value < 524)
            V_count_value <= V_count_value + 1;
         else V_count_value <= 0;
      end

    
    end

endmodule