`timescale 1ms / 1us  // 时间单位为 1ms，精度为 1us

module tb_debounce_counter();

    // 1. 定义测试台信号
    reg  KEYCLK;
    reg  KIN;
    wire KOUT;

    // 2. 实例化被测模块 (UUT - Unit Under Test)
    debounce_counter uut (
        .KEYCLK (KEYCLK),
        .KIN    (KIN),
        .KOUT   (KOUT)
    );

    // 3. 生成 1.6kHz 的采样时钟
    // 1.6kHz 对应的周期约为 0.625ms，半个周期为 0.3125ms
    always #0.3125 KEYCLK = ~KEYCLK;

    // 4. 编写激励信号（模拟真实的按键动作）
    initial begin
        // --- 初始化状态 ---
        KEYCLK = 0;
        KIN = 1'b1;  // 按键初始未按下（高电平）
        #5.0;        // 稳定等待 5ms

        // --- 动作 1：模拟按键按下时的机械抖动 ---
        // 手指刚接触弹片，电平在 0 和 1 之间快速跳变
        KIN = 1'b0; #0.5; // 变低 0.5ms
        KIN = 1'b1; #0.8; // 弹开 0.8ms
        KIN = 1'b0; #0.4; // 变低 0.4ms
        KIN = 1'b1; #1.2; // 弹开 1.2ms
        
        // --- 动作 2：按键稳定按下 ---
        // 抖动结束，手指稳定发力，闭合时间远大于 10ms (16个时钟周期)
        KIN = 1'b0; 
        #20.0; // 稳定保持低电平 20ms

        // --- 动作 3：模拟按键松开时的机械抖动 ---
        // 手指离开弹片，再次发生短暂跳变
        KIN = 1'b1; #0.6;
        KIN = 1'b0; #0.5;
        KIN = 1'b1; #0.8;
        KIN = 1'b0; #1.0;
        
        // --- 动作 4：按键稳定松开 ---
        // 彻底松开，恢复高电平
        KIN = 1'b1;
        #10.0; // 观察 10ms

        // 结束仿真
        $stop;
    end

endmodule