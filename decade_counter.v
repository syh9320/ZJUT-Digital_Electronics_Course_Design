// 模块名：decade_counter (十进制计数器)
// 功能：提取按键下降沿，并在 0~9 之间循环计数
module decade_counter (
    input  wire clk,      // 系统主时钟 (由 RC 振荡器产生，约 1MHz)
    input  wire kout,     // 来自消抖模块的按键信号 (低电平有效)
    output reg  [3:0] cnt_val = 4'd0 // 输出给译码电路的计数值 (0~9)
);

    // 1. 跨时钟域与边沿检测寄存器
    // 消抖模块的时钟是 1.6kHz，这里的主时钟是 1MHz，属于跨时钟域
    // 采用两级寄存器打拍，既能消除潜在的亚稳态，又能用于边沿检测
    reg kout_d0 = 1'b1; 
    reg kout_d1 = 1'b1;

    always @(posedge clk) begin
        kout_d0 <= kout;      // 第一拍：同步信号
        kout_d1 <= kout_d0;   // 第二拍：延迟一个时钟周期
    end

    // 2. 提取下降沿单脉冲
    // 当上一拍(d1)为高电平，且当前拍(d0)为低电平时，说明按键刚好被按下
    // 这个信号 kout_falling_edge 只会维持一个 clk 时钟周期的高电平
    wire kout_falling_edge = (~kout_d0) & kout_d1;

    // 3. 核心计数逻辑
    always @(posedge clk) begin
        if (kout_falling_edge) begin
            // 只有在检测到按键按下的瞬间，才进行状态切换
            if (cnt_val == 4'd9) begin
                cnt_val <= 4'd0; // 逢 9 归 0
            end else begin
                cnt_val <= cnt_val + 1'b1; // 正常累加
            end
        end
    end

endmodule