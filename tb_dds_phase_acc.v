`timescale 1ns/1ps  // 定义时间单位为 1ns，精度为 1ps

module tb_dds_phase_acc();

    // 1. 信号定义
    // 被测模块的输入定义为 reg（寄存器），输出定义为 wire（导线）
    reg         clk;
    reg  [23:0] freq_word;
    wire [7:0]  rom_addr;

    // 2. 实例化被测模块 (UUT: Unit Under Test)
    dds_phase_acc uut (
        .clk       (clk),
        .freq_word (freq_word),
        .rom_addr  (rom_addr)
    );

    // 3. 产生时钟信号
    // 模拟 50MHz 时钟：周期为 20ns，所以每 10ns 翻转一次
    initial begin
        clk = 0;
    end
    always #10 clk = ~clk; 

    // 4. 产生激励信号（测试逻辑）
    initial begin
        // 初始化：先给一个中等步长
        // 设 K = 65536，理想情况下地址每拍加 1
        freq_word = 24'd65536;
        
        #2000;  // 运行 2000ns

        // 改变步长：加速（步长翻倍）
        // 地址每拍应该加 2，锯齿波斜率会变陡
        freq_word = 24'd131072;
        
        #2000;

        // 改变步长：减速（极慢步长）
        // 地址要等很久才会跳变一次
        freq_word = 24'd100;
        
        #5000;

        $stop;  // 仿真结束
    end

endmodule