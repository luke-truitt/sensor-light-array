module mw_reg(o_in, d_in, ir_in, o_out, d_out, ir_out, clk, clear);

	input [31:0] o_in, d_in, ir_in;
	input clk, clear;
	output [31:0] o_out, d_out, ir_out;
	
	flip_floppity_flop ir_0(ir_out[0], ir_in[0], clk, clear);
	flip_floppity_flop ir_1(ir_out[1], ir_in[1], clk, clear);
	flip_floppity_flop ir_2(ir_out[2], ir_in[2], clk, clear);
	flip_floppity_flop ir_3(ir_out[3], ir_in[3], clk, clear);
	flip_floppity_flop ir_4(ir_out[4], ir_in[4], clk, clear);
	flip_floppity_flop ir_5(ir_out[5], ir_in[5], clk, clear);
	flip_floppity_flop ir_6(ir_out[6], ir_in[6], clk, clear);
	flip_floppity_flop ir_7(ir_out[7], ir_in[7], clk, clear);
	flip_floppity_flop ir_8(ir_out[8], ir_in[8], clk, clear);
	flip_floppity_flop ir_9(ir_out[9], ir_in[9], clk, clear);
	flip_floppity_flop ir_10(ir_out[10], ir_in[10], clk, clear);
	flip_floppity_flop ir_11(ir_out[11], ir_in[11], clk, clear);
	flip_floppity_flop ir_12(ir_out[12], ir_in[12], clk, clear);
	flip_floppity_flop ir_13(ir_out[13], ir_in[13], clk, clear);
	flip_floppity_flop ir_14(ir_out[14], ir_in[14], clk, clear);
	flip_floppity_flop ir_15(ir_out[15], ir_in[15], clk, clear);
	flip_floppity_flop ir_16(ir_out[16], ir_in[16], clk, clear);
	flip_floppity_flop ir_17(ir_out[17], ir_in[17], clk, clear);
	flip_floppity_flop ir_18(ir_out[18], ir_in[18], clk, clear);
	flip_floppity_flop ir_19(ir_out[19], ir_in[19], clk, clear);
	flip_floppity_flop ir_20(ir_out[20], ir_in[20], clk, clear);
	flip_floppity_flop ir_21(ir_out[21], ir_in[21], clk, clear);
	flip_floppity_flop ir_22(ir_out[22], ir_in[22], clk, clear);
	flip_floppity_flop ir_23(ir_out[23], ir_in[23], clk, clear);
	flip_floppity_flop ir_24(ir_out[24], ir_in[24], clk, clear);
	flip_floppity_flop ir_25(ir_out[25], ir_in[25], clk, clear);
	flip_floppity_flop ir_26(ir_out[26], ir_in[26], clk, clear);
	flip_floppity_flop ir_27(ir_out[27], ir_in[27], clk, clear);
	flip_floppity_flop ir_28(ir_out[28], ir_in[28], clk, clear);
	flip_floppity_flop ir_29(ir_out[29], ir_in[29], clk, clear);
	flip_floppity_flop ir_30(ir_out[30], ir_in[30], clk, clear);
	flip_floppity_flop ir_31(ir_out[31], ir_in[31], clk, clear);

	
	flip_floppity_flop a_0(o_out[0], o_in[0], clk, clear);
	flip_floppity_flop o_1(o_out[1], o_in[1], clk, clear);
	flip_floppity_flop o_2(o_out[2], o_in[2], clk, clear);
	flip_floppity_flop o_3(o_out[3], o_in[3], clk, clear);
	flip_floppity_flop o_4(o_out[4], o_in[4], clk, clear);
	flip_floppity_flop o_5(o_out[5], o_in[5], clk, clear);
	flip_floppity_flop o_6(o_out[6], o_in[6], clk, clear);
	flip_floppity_flop o_7(o_out[7], o_in[7], clk, clear);
	flip_floppity_flop o_8(o_out[8], o_in[8], clk, clear);
	flip_floppity_flop o_9(o_out[9], o_in[9], clk, clear);
	flip_floppity_flop o_10(o_out[10], o_in[10], clk, clear);
	flip_floppity_flop o_11(o_out[11], o_in[11], clk, clear);
	flip_floppity_flop o_12(o_out[12], o_in[12], clk, clear);
	flip_floppity_flop o_13(o_out[13], o_in[13], clk, clear);
	flip_floppity_flop o_14(o_out[14], o_in[14], clk, clear);
	flip_floppity_flop o_15(o_out[15], o_in[15], clk, clear);
	flip_floppity_flop o_16(o_out[16], o_in[16], clk, clear);
	flip_floppity_flop o_17(o_out[17], o_in[17], clk, clear);
	flip_floppity_flop o_18(o_out[18], o_in[18], clk, clear);
	flip_floppity_flop o_19(o_out[19], o_in[19], clk, clear);
	flip_floppity_flop o_20(o_out[20], o_in[20], clk, clear);
	flip_floppity_flop o_21(o_out[21], o_in[21], clk, clear);
	flip_floppity_flop o_22(o_out[22], o_in[22], clk, clear);
	flip_floppity_flop o_23(o_out[23], o_in[23], clk, clear);
	flip_floppity_flop o_24(o_out[24], o_in[24], clk, clear);
	flip_floppity_flop o_25(o_out[25], o_in[25], clk, clear);
	flip_floppity_flop o_26(o_out[26], o_in[26], clk, clear);
	flip_floppity_flop o_27(o_out[27], o_in[27], clk, clear);
	flip_floppity_flop o_28(o_out[28], o_in[28], clk, clear);
	flip_floppity_flop o_29(o_out[29], o_in[29], clk, clear);
	flip_floppity_flop o_30(o_out[30], o_in[30], clk, clear);
	flip_floppity_flop o_31(o_out[31], o_in[31], clk, clear);
	
	flip_floppity_flop d_0(d_out[0], d_in[0], clk, clear);
	flip_floppity_flop d_1(d_out[1], d_in[1], clk, clear);
	flip_floppity_flop d_2(d_out[2], d_in[2], clk, clear);
	flip_floppity_flop d_3(d_out[3], d_in[3], clk, clear);
	flip_floppity_flop d_4(d_out[4], d_in[4], clk, clear);
	flip_floppity_flop d_5(d_out[5], d_in[5], clk, clear);
	flip_floppity_flop d_6(d_out[6], d_in[6], clk, clear);
	flip_floppity_flop d_7(d_out[7], d_in[7], clk, clear);
	flip_floppity_flop d_8(d_out[8], d_in[8], clk, clear);
	flip_floppity_flop d_9(d_out[9], d_in[9], clk, clear);
	flip_floppity_flop d_10(d_out[10], d_in[10], clk, clear);
	flip_floppity_flop d_11(d_out[11], d_in[11], clk, clear);
	flip_floppity_flop d_12(d_out[12], d_in[12], clk, clear);
	flip_floppity_flop d_13(d_out[13], d_in[13], clk, clear);
	flip_floppity_flop d_14(d_out[14], d_in[14], clk, clear);
	flip_floppity_flop d_15(d_out[15], d_in[15], clk, clear);
	flip_floppity_flop d_16(d_out[16], d_in[16], clk, clear);
	flip_floppity_flop d_17(d_out[17], d_in[17], clk, clear);
	flip_floppity_flop d_18(d_out[18], d_in[18], clk, clear);
	flip_floppity_flop d_19(d_out[19], d_in[19], clk, clear);
	flip_floppity_flop d_20(d_out[20], d_in[20], clk, clear);
	flip_floppity_flop d_21(d_out[21], d_in[21], clk, clear);
	flip_floppity_flop d_22(d_out[22], d_in[22], clk, clear);
	flip_floppity_flop d_23(d_out[23], d_in[23], clk, clear);
	flip_floppity_flop d_24(d_out[24], d_in[24], clk, clear);
	flip_floppity_flop d_25(d_out[25], d_in[25], clk, clear);
	flip_floppity_flop d_26(d_out[26], d_in[26], clk, clear);
	flip_floppity_flop d_27(d_out[27], d_in[27], clk, clear);
	flip_floppity_flop d_28(d_out[28], d_in[28], clk, clear);
	flip_floppity_flop d_29(d_out[29], d_in[29], clk, clear);
	flip_floppity_flop d_30(d_out[30], d_in[30], clk, clear);
	flip_floppity_flop d_31(d_out[31], d_in[31], clk, clear);

endmodule