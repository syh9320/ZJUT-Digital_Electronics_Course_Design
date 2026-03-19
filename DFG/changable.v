// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Thu Mar 12 17:36:13 2026"

module changable(
	CLK,
	KIN,
	AA,
	BB,
	CC,
	out
);


input wire	CLK;
input wire	KIN;
output wire	[6:0] AA;
output wire	[6:0] BB;
output wire	[6:0] CC;
output wire	[7:0] out;

wire	[23:0] SYNTHESIZED_WIRE_0;
wire	[3:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;





dds_phase_acc	b2v_inst(
	.clk(CLK),
	.freq_word(SYNTHESIZED_WIRE_0),
	.rom_addr(SYNTHESIZED_WIRE_2));


freq_decoder	b2v_inst1(
	.cnt_val(SYNTHESIZED_WIRE_1),
	.freq_M(SYNTHESIZED_WIRE_0),
	.seg_AA(AA),
	.seg_BB(BB),
	.seg_CC(CC));


sine_rom	b2v_inst2(
	.clock(CLK),
	.address(SYNTHESIZED_WIRE_2),
	.q(out));


decade_counter	b2v_inst3(
	.clk(CLK),
	.kout(SYNTHESIZED_WIRE_3),
	.cnt_val(SYNTHESIZED_WIRE_1));


debounce_counter	b2v_inst4(
	.KEYCLK(SYNTHESIZED_WIRE_4),
	.KIN(KIN),
	.KOUT(SYNTHESIZED_WIRE_3));


clk_divider	b2v_inst5(
	.clk(CLK),
	.keyclk(SYNTHESIZED_WIRE_4));


endmodule
