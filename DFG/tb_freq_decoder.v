`timescale 1ns/1ps

module tb_freq_decoder();

    // 1. 定义信号
    reg  [3:0]  cnt_val;   // 给激励的输入，定义为 reg
    wire [6:0]  seg_AA;    // 观测的输出，定义为 wire
    wire [6:0]  seg_BB;
    wire [6:0]  seg_CC;
    wire [23:0] freq_M;

    // 2. 实例化被测模块 (UUT)
    freq_decoder uut (
        .cnt_val(cnt_val),
        .seg_AA(seg_AA),
        .seg_BB(seg_BB),
        .seg_CC(seg_CC),
        .freq_M(freq_M)
    );

    integer i; // 用于 for 循环的变量

    // 3. 产生测试激励
    initial begin
        // 这一行会在 ModelSim 的 Transcript（控制台）打印表头
        $display("=========================================================");
        $display("Time(ns) | cnt_val | freq_M(步长) | seg_AA | seg_BB | seg_CC");
        $display("=========================================================");
        
        // $monitor 是一个强大的系统任务：只要它监控的变量发生变化，就会自动打印一行数据
        $monitor("%4t     |    %d    |    %d     | %b| %b| %b", 
                 $time, cnt_val, freq_M, seg_AA, seg_BB, seg_CC);

        // 遍历 0 到 10 的状态
        for (i = 0; i <= 10; i = i + 1) begin
            cnt_val = i;
            #20; // 保持 20ns 后再切换下一个值
        end

        #50;
        $stop; // 仿真结束
    end

endmodule