`timescale 1us / 1ns  // 时间单位 1us，精度 1ns

module tb_top();

    // 1. 定义测试台内部信号
    reg  clk_reg;  // 内部时钟寄存器
    reg  kin_reg;  // 内部按键寄存器
    
    wire [6:0] out_AA;
    wire [6:0] out_BB;
    wire [6:0] out_CC;
    wire [7:0] out_wave;    

    // 2. 实例化你的顶层模块 (UUT)
    // 【关键对齐】：左侧括号外面的名字（例如 .CLK），必须和你的 changable 严格一致！
    changable uut (
        .CLK (clk_reg),   // 大写的 CLK 接入测试台的时钟信号
        .KIN (kin_reg),   // 大写的 KIN 接入测试台的按键信号
        .AA  (out_AA),
        .BB  (out_BB),
        .CC  (out_CC),
        .out (out_wave)
    );

    // 3. 生成 1MHz 系统主时钟 (周期 1us)
    always #0.5 clk_reg = ~clk_reg;

    // 4. 编写物理级连续激励信号 (模拟连续按键变频)
    initial begin
        // --- 系统上电初始化 ---
        clk_reg = 0;
        kin_reg = 1'b1;   // 默认高电平 (未按下)
        
        // 观察初始状态 (100Hz 波形，跑 20ms)
        #20000; 

        // --- 核心动作：连续按键 4 次 ---
        repeat(4) begin
            // 动作 1：稳定按下按键 (维持 15ms，超过消抖需要的 10ms)
            kin_reg = 1'b0;
            #15000; 
            
            // 动作 2：松开按键
            kin_reg = 1'b1;
            
            // 动作 3：留出 20ms 的空白时间，欣赏切换档位后“变密”的正弦波
            #20000; 
        end

        // 结束仿真
        $stop;
    end

endmodule