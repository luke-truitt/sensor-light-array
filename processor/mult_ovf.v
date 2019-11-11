module mult_ovf(overflow, top_out, multiplicand_msb, multiplier_msb, answer_msb);
	input[31:0] top_out;
	input multiplicand_msb, multiplier_msb, answer_msb;
	output overflow;
	wire not_neg, not_pos, normal_ovf, sub_ovf, op, pos, neg, opposites, not_ans, both_pos, both_neg;
	not ch(not_ans, answer_msb);
	nand check_neg(not_neg, top_out[0], top_out[1], top_out[2], top_out[3], top_out[4], top_out[5], top_out[6], top_out[7], top_out[8], top_out[9], top_out[10], top_out[11], top_out[12], top_out[13], top_out[14], top_out[15], top_out[16], top_out[17], top_out[18], top_out[19], top_out[20], top_out[21], top_out[22], top_out[23], top_out[24], top_out[25], top_out[26], top_out[27], top_out[28], top_out[29], top_out[30], top_out[31]);

	or check_pos(not_pos, top_out[0], top_out[1], top_out[2], top_out[3], top_out[4], top_out[5], top_out[6], top_out[7], top_out[8], top_out[9], top_out[10], top_out[11], top_out[12], top_out[13], top_out[14], top_out[15], top_out[16], top_out[17], top_out[18], top_out[19], top_out[20], top_out[21], top_out[22], top_out[23], top_out[24], top_out[25], top_out[26], top_out[27], top_out[28], top_out[29], top_out[30], top_out[31]);

	and ovf(normal_ovf, not_neg, not_pos);
	
	nor posOvf(both_pos, multiplicand_msb, multiplier_msb);
	and negsOvf(both_neg, multiplicand_msb, multiplier_msb);
	xor negOvf(opposites, multiplicand_msb, multiplier_msb);
	
	and badNeg(op, opposites, not_ans);
	and badPos(pos, both_pos, answer_msb);
	and badNegs(neg, both_neg, answer_msb);
	
	or weirdOvf(sub_ovf, op, pos, neg);
	
	or ovf_ck(overflow, sub_ovf, normal_ovf);
endmodule
