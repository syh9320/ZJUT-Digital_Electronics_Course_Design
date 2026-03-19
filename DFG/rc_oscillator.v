// 模块名：rc_oscillator
// 功能：提供 RC 振荡器所需的 FPGA 内部反相与缓冲逻辑
module rc_oscillator (
    input  IN1,   // 输入引脚：连接外部保护电阻 Ry
    output OUT1,  // 输出引脚：连接外部电容 Cx
    output OUT2,  // 输出引脚：连接外部反馈电阻 Rx
    output CLK    // 内部输出：供给 FPGA 内部其他模块的 1MHz 基准时钟
);

    // 1. OUT1 直接输出 IN1 的状态 (对应图左侧的红色缓冲器)
    assign OUT1 = IN1;

    // 2. IN1 经过反相器 G1，产生内部基准时钟 CLK
    assign CLK = ~IN1;

    // 3. 反相后的时钟信号输出到 OUT2，驱动外部电路充放电
    assign OUT2 = CLK;

endmodule