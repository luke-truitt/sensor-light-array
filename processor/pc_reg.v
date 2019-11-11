module pc_reg(pc_in, pc_out, clk, clear);

	input [31:0] pc_in;
	input clk, clear;
	output [31:0] pc_out;
	
	flip_floppity_flop dff_0(pc_out[0], pc_in[0], clk, clear);
	flip_floppity_flop dff_1(pc_out[1], pc_in[1], clk, clear);
	flip_floppity_flop dff_2(pc_out[2], pc_in[2], clk, clear);
	flip_floppity_flop dff_3(pc_out[3], pc_in[3], clk, clear);
	flip_floppity_flop dff_4(pc_out[4], pc_in[4], clk, clear);
	flip_floppity_flop dff_5(pc_out[5], pc_in[5], clk, clear);
	flip_floppity_flop dff_6(pc_out[6], pc_in[6], clk, clear);
	flip_floppity_flop dff_7(pc_out[7], pc_in[7], clk, clear);
	flip_floppity_flop dff_8(pc_out[8], pc_in[8], clk, clear);
	flip_floppity_flop dff_9(pc_out[9], pc_in[9], clk, clear);
	flip_floppity_flop dff_10(pc_out[10], pc_in[10], clk, clear);
	flip_floppity_flop dff_11(pc_out[11], pc_in[11], clk, clear);
	flip_floppity_flop dff_12(pc_out[12], pc_in[12], clk, clear);
	flip_floppity_flop dff_13(pc_out[13], pc_in[13], clk, clear);
	flip_floppity_flop dff_14(pc_out[14], pc_in[14], clk, clear);
	flip_floppity_flop dff_15(pc_out[15], pc_in[15], clk, clear);
	flip_floppity_flop dff_16(pc_out[16], pc_in[16], clk, clear);
	flip_floppity_flop dff_17(pc_out[17], pc_in[17], clk, clear);
	flip_floppity_flop dff_18(pc_out[18], pc_in[18], clk, clear);
	flip_floppity_flop dff_19(pc_out[19], pc_in[19], clk, clear);
	flip_floppity_flop dff_20(pc_out[20], pc_in[20], clk, clear);
	flip_floppity_flop dff_21(pc_out[21], pc_in[21], clk, clear);
	flip_floppity_flop dff_22(pc_out[22], pc_in[22], clk, clear);
	flip_floppity_flop dff_23(pc_out[23], pc_in[23], clk, clear);
	flip_floppity_flop dff_24(pc_out[24], pc_in[24], clk, clear);
	flip_floppity_flop dff_25(pc_out[25], pc_in[25], clk, clear);
	flip_floppity_flop dff_26(pc_out[26], pc_in[26], clk, clear);
	flip_floppity_flop dff_27(pc_out[27], pc_in[27], clk, clear);
	flip_floppity_flop dff_28(pc_out[28], pc_in[28], clk, clear);
	flip_floppity_flop dff_29(pc_out[29], pc_in[29], clk, clear);
	flip_floppity_flop dff_30(pc_out[30], pc_in[30], clk, clear);
	flip_floppity_flop dff_31(pc_out[31], pc_in[31], clk, clear);

endmodule
