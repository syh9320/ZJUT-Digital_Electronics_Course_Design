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
// CREATED		"Sun Mar 08 15:25:51 2026"

module sinGen(
	system_clk,
	CLK_out,
	out
);


input wire	system_clk;
output wire	CLK_out;
output wire	[7:0] out;

wire	[7:0] SYNTHESIZED_WIRE_0;

assign	CLK_out = system_clk;




sine_rom	b2v_inst(
	.clock(system_clk),
	.address(SYNTHESIZED_WIRE_0),
	.q(out));


sawtooth_gen	b2v_inst3(
	.clk(system_clk),
	.dac_data(SYNTHESIZED_WIRE_0));


endmodule
