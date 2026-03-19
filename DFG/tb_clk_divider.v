`timescale 1us / 1ns  // 时间单位 1us，精度 1ns

module tb_clk_divider();

    // 1. 定义测试台信号
    reg  clk;
    wire keyclk;

    // 2. 实例化被测模块 (UUT)
    clk_divider uut (
        .clk    (clk),
        .keyclk (keyclk)
    );

    // 3. 生成 1MHz 系统主时钟
    // 1MHz 频率对应的周期是 1us。
    // 所以每隔 0.5us 翻转一次，就能产生完美的 1MHz 方波
    always #0.5 clk = ~clk;

    // 4. 仿真过程控制
    initial begin
        // 初始化时钟
        clk = 0;
        
        // 运行仿真 2000 us (即 2 ms)
        // 因为 keyclk 的预期周期大约是 624 us，
        // 跑 2000 us 足够我们观察到至少 3 个完整的 keyclk 波形周期了。
        #2000; 
        
        // 结束仿真
        $stop;
    end

endmodule