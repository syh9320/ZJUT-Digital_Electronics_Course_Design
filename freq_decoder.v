// 模块名：freq_decoder (译码电路)
// 功能：4输入45输出的组合逻辑电路 
// 作用：将 0~9 的计数值翻译成三位数码管段选码和 24 位频率控制字 M
module freq_decoder (
    input  wire [3:0]  cnt_val,  // 4输入：来自十进制计数器的输出值 (0~9)
    
    output reg  [6:0]  seg_AA,   // 输出：百位数码管 7 段显示码 [cite: 236]
    output reg  [6:0]  seg_BB,   // 输出：十位数码管 7 段显示码 [cite: 237]
    output reg  [6:0]  seg_CC,   // 输出：个位数码管 7 段显示码 [cite: 238]
    output reg  [23:0] freq_M    // 输出：24 位频率控制字 M [cite: 240]
);

    // 段码字典 (共阴极逻辑：1亮0灭)
    // 0:3F, 1:06, 2:5B, 3:4F, 4:66, 5:6D, 6:7D, 7:07, 8:7F, 9:6F

    // 频率控制字 M 严格参照指导书 P11 Excel 表格数据计算 
    // 乘法系数约为 16.888749
    
    always @(*) begin
        case(cnt_val)
            4'd0: begin // 100Hz
                seg_AA = 7'b0000110; // '1'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd1689;   // Excel 对应值 
            end
            
            4'd1: begin // 200Hz
                seg_AA = 7'b1011011; // '2'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd3378;   // 
            end

            4'd2: begin // 300Hz
                seg_AA = 7'b1001111; // '3'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd5067;   // 
            end

            4'd3: begin // 400Hz
                seg_AA = 7'b1100110; // '4'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd6755;   // 
            end

            4'd4: begin // 500Hz
                seg_AA = 7'b1101101; // '5'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd8444;   // 
            end

            4'd5: begin // 600Hz
                seg_AA = 7'b1111101; // '6'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd10133;  // 
            end

            4'd6: begin // 700Hz
                seg_AA = 7'b0000111; // '7'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd11822;  // 
            end

            4'd7: begin // 800Hz
                seg_AA = 7'b1111111; // '8'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd13511;  // 
            end

            4'd8: begin // 900Hz
                seg_AA = 7'b1101111; // '9'
                seg_BB = 7'b0111111; // '0'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd15200;  // 
            end

            4'd9: begin // 990Hz
                seg_AA = 7'b1101111; // '9'
                seg_BB = 7'b1101111; // '9'
                seg_CC = 7'b0111111; // '0'
                freq_M = 24'd16720;  // 
            end

            default: begin
                seg_AA = 7'b0000000; 
                seg_BB = 7'b0000000;
                seg_CC = 7'b0000000;
                freq_M = 24'd0;      
            end
        endcase
    end
endmodule