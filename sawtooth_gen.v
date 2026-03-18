module sawtooth_gen(
    input clk,            // 只需要时钟输入
    output reg [7:0] dac_data = 8'd0 // 关键：直接在这里赋初值0！Quartus会把它作为上电状态
);

    // 只需要检测时钟上升沿，不需要检测复位信号了
    always @(posedge clk) begin
        dac_data <= dac_data + 1'b1; // 永远无脑加 1，自动溢出
    end

endmodule