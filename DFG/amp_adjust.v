module amp_adjust (
    input  wire [7:0] data_in,   // 接收来自 ROM 的原始波形数据
    input  wire [1:0] amp_sel,   // 接收拨码开关 SW3, SW2 的控制信号
    output reg  [7:0] data_out   // 输出给最终引脚 out 的数据
);

    always @(*) begin
        case (amp_sel)
            // 档位 00：满幅度 (原样输出)
            2'b00: data_out = data_in; 
            
            // 档位 01：1/2 幅度 (右移 1 位，即除以 2，并补偿 64 的直流偏置保持中心在 128)
            2'b01: data_out = {1'b0, data_in[7:1]} + 8'd64;
            
            // 档位 10：1/4 幅度 (右移 2 位，即除以 4，并补偿 96 的直流偏置)
            2'b10: data_out = {2'b00, data_in[7:2]} + 8'd96;
            
            // 档位 11：1/8 幅度 (右移 3 位，即除以 8，并补偿 112 的直流偏置)
            2'b11: data_out = {3'b000, data_in[7:3]} + 8'd112;
            
            default: data_out = data_in;
        endcase
    end

endmodule