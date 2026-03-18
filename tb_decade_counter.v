`timescale 1us / 1ns  // 时间单位为 1us，精度为 1ns (适配 1MHz 主时钟)

module tb_decade_counter();

    // 1. 定义测试台信号
    reg  clk;
    reg  kout;
    wire [3:0] cnt_val;

    // 2. 实例化被测模块 (UUT)
    decade_counter uut (
        .clk     (clk),
        .kout    (kout),
        .cnt_val (cnt_val)
    );

    // 3. 生成系统主时钟 (1MHz)
    // 1MHz 的周期是 1us，因此每隔 0.5us 翻转一次
    always #0.5 clk = ~clk;

    // 4. 编写激励信号
    initial begin
        // --- 初始化 ---
        clk = 0;
        kout = 1'b1;  // 初始状态：按键未按下 (经过消抖后的信号，高电平有效)
        #10;          // 等待系统稳定

        // --- 测试场景 1：长按测试 (验证边沿检测功能) ---
        // 模拟手指按下按键，kout 变为 0
        kout = 1'b0;  
        // 保持低电平 100us。
        // 注意：在这 100us 内，1MHz 的时钟会经过 100 个周期。
        // 如果边沿检测失败，cnt_val 会在这 100us 内疯狂累加。
        // 预期的正确现象是：cnt_val 仅在 kout 刚变成 0 的瞬间加到 1，之后一直保持为 1。
        #100;         
        // 松开按键
        kout = 1'b1;  
        #50;

        // --- 测试场景 2：连续按键测试 (验证 0~9 循环计数功能) ---
        // 此时 cnt_val 已经是 1 了，我们再连续按 10 次
        // 预期 cnt_val 会从 1 一直加到 9，然后再按时归 0，最后停在 1。
        repeat(10) begin
            kout = 1'b0; // 按下
            #20;         // 保持 20us
            kout = 1'b1; // 松开
            #30;         // 间隔 30us
        end

        // --- 测试结束 ---
        #50;
        $stop;
    end

endmodule