// 模块名：clk_divider (时钟分频器)
// 功能：将 1MHz 主时钟分频至约 1.6kHz，供给消抖电路使用
module clk_divider (
    input  wire clk,      // 系统主时钟 (由 RC 振荡器产生，约 1MHz)
    output reg  keyclk    // 输出给消抖模块的低频时钟 (约 1.6kHz)
);

    // 定义计数器
    // 最大计数值为 311 (即 0~311)，需要 9 位宽的寄存器 (2^9 = 512 > 311)
    reg [8:0] cnt = 9'd0;

    // 初始状态 keyclk 设为低电平
    initial begin
        keyclk = 1'b0;
    end

    always @(posedge clk) begin
        if (cnt == 9'd311) begin
            cnt <= 9'd0;           // 计满归零
            keyclk <= ~keyclk;     // 翻转时钟电平
        end else begin
            cnt <= cnt + 1'b1;     // 正常累加
        end
    end

endmodule