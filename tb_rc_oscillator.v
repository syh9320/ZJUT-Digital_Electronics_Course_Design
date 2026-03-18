`timescale 1ns / 1ps  // 时间单位1ns，精度1ps

module tb_rc_oscillator();

    // 定义连接线的变量
    wire out1_wire;
    wire out2_wire;
    wire clk_wire;
    
    // 用 reg 寄存器模拟 IN1 的输入，因为我们需要给它一个初始状态
    reg in1_sim; 

    // 实例化我们设计的 RC 振荡辅助逻辑模块
    rc_oscillator uut (
        .IN1(in1_sim),
        .OUT1(out1_wire),
        .OUT2(out2_wire),
        .CLK(clk_wire)
    );

    // 1. 模拟系统刚上电时的状态：电容 Cx 还没有充电，电压为 0 (逻辑低电平)
    initial begin
        in1_sim = 1'b0;
    end

    // 2. 核心：模拟外部 RC 充放电的物理延迟！
    // 当 OUT2 发生变化时，由于外部电阻和电容的存在，IN1 不会立刻变化。
    // 我们假设这个充放电过程需要 500ns（对应总周期 1000ns，即 1MHz 频率）。
    always @(out2_wire) begin
        #500 in1_sim = out2_wire;  // 延迟 500ns 后，把 OUT2 的状态反馈给 IN1
    end

endmodule