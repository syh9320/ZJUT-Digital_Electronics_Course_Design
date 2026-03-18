module debounce_counter (
    input  wire KEYCLK, // 低频采样时钟 (建议频率约 1.6 kHz)
    input  wire KIN,    // 外部物理按键输入 (未按下为高电平'1'，按下为低电平'0')
    output wire KOUT    // 消抖后的稳定输出 (低电平有效，即稳妥按下后输出'0')
);

    // 定义一个 5 位的寄存器，用于实现 17 进制计数 (范围: 00000 ~ 10000)
    reg [4:0] cnt;

    // 采用异步清零的敏感列表：当时钟上升沿或按键出现高电平时触发
    always @(posedge KEYCLK or posedge KIN) begin
        if (KIN == 1'b1) begin
            // 只要按键未按下，或者发生抖动弹跳回高电平，计数器立刻清零
            cnt <= 5'b00000;
        end 
        else begin
            // 当按键保持低电平时，开始在 KEYCLK 的驱动下累加
            if (cnt == 5'b10000) begin
                // 当计数值达到 16 (即 10000) 时，保持该状态不再增加
                cnt <= 5'b10000;
            end 
            else begin
                // 还没有数到 16，继续加 1
                cnt <= cnt + 1'b1;
            end
        end
    end

    // 直接提取最高位 cnt[4] 并取反，作为最终的消抖输出
    assign KOUT = ~cnt[4];

endmodule