module register(out, in, clk, clear);

	input [31:0] in;
	input clk, clear;
	output [31:0] out;
	
	flip_floppity_flop dff_0(out[0], in[0], clk, clear);
	flip_floppity_flop dff_1(out[1], in[1], clk, clear);
	flip_floppity_flop dff_2(out[2], in[2], clk, clear);
	flip_floppity_flop dff_3(out[3], in[3], clk, clear);
	flip_floppity_flop dff_4(out[4], in[4], clk, clear);
	flip_floppity_flop dff_5(out[5], in[5], clk, clear);
	flip_floppity_flop dff_6(out[6], in[6], clk, clear);
	flip_floppity_flop dff_7(out[7], in[7], clk, clear);
	flip_floppity_flop dff_8(out[8], in[8], clk, clear);
	flip_floppity_flop dff_9(out[9], in[9], clk, clear);
	flip_floppity_flop dff_10(out[10], in[10], clk, clear);
	flip_floppity_flop dff_11(out[11], in[11], clk, clear);
	flip_floppity_flop dff_12(out[12], in[12], clk, clear);
	flip_floppity_flop dff_13(out[13], in[13], clk, clear);
	flip_floppity_flop dff_14(out[14], in[14], clk, clear);
	flip_floppity_flop dff_15(out[15], in[15], clk, clear);
	flip_floppity_flop dff_16(out[16], in[16], clk, clear);
	flip_floppity_flop dff_17(out[17], in[17], clk, clear);
	flip_floppity_flop dff_18(out[18], in[18], clk, clear);
	flip_floppity_flop dff_19(out[19], in[19], clk, clear);
	flip_floppity_flop dff_20(out[20], in[20], clk, clear);
	flip_floppity_flop dff_21(out[21], in[21], clk, clear);
	flip_floppity_flop dff_22(out[22], in[22], clk, clear);
	flip_floppity_flop dff_23(out[23], in[23], clk, clear);
	flip_floppity_flop dff_24(out[24], in[24], clk, clear);
	flip_floppity_flop dff_25(out[25], in[25], clk, clear);
	flip_floppity_flop dff_26(out[26], in[26], clk, clear);
	flip_floppity_flop dff_27(out[27], in[27], clk, clear);
	flip_floppity_flop dff_28(out[28], in[28], clk, clear);
	flip_floppity_flop dff_29(out[29], in[29], clk, clear);
	flip_floppity_flop dff_30(out[30], in[30], clk, clear);
	flip_floppity_flop dff_31(out[31], in[31], clk, clear);
	
	
endmodule
