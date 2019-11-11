module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

	wire [31:0] not_out, or_out, and_out, shift_out, andor, adder_out;
	wire c_out, eql, both_zero, eq_inA, eq_inB, signout, overflowseq, aout, ab;
	wire a_notb, na_nb_s, a_b_ns, not_s, not_a, not_b;
	wire add_sub, ovfcheck, not_sub, sneq_out, sseq_out, nota_out, notb_out, povf, overflowsub, overflowadd, signbout;
	wire [1:0] select;
	wire [31:0] mux_out, dummy_out, lftshft, rghtshft;
	
	assign add_sub = ctrl_ALUopcode[0];
	assign select = ctrl_ALUopcode[2:1];
	
	thirtytwo_bit_cla adder(adder_out, c_out, data_operandA, mux_out, add_sub);
	
	not_32 not_gate(not_out, data_operandB);
	
	mux_2 add_sub_mux(mux_out, data_operandB, not_out, add_sub);
   
	and_32 and_gate(and_out, data_operandA, data_operandB);
	
	or_32 or_gate(or_out, data_operandA, data_operandB);
	
	sll_32 shft_left(lftshft, data_operandA, ctrl_shiftamt);
	sra_32 shft_right(rghtshft, data_operandA, ctrl_shiftamt);
	
	mux_2 shft_mux(shift_out, lftshft, rghtshft, add_sub);
	mux_2 and_or(andor, and_out, or_out, add_sub);
	
	eqz eq(eql, adder_out);
	
	not neq(isNotEqual, eql);
	
	mux_4 sel(data_result, adder_out, andor, shift_out, dummy_out, select);

	assign signout = adder_out[31];
	
	xor so(isLessThan, signout, overflow);
	
	not ns(not_sub, add_sub);
	
	xnor checkab(ab, data_operandA[31], data_operandB[31]);
	xor checkaout(aout, data_operandA[31], adder_out[31]);
	and ovf(overflowadd, ab, aout, not_sub);
	xnor signb(signbout, adder_out[31], data_operandB[31]);
	and ovf3(overflowsub, aout, signbout, add_sub);
	or ovffinal(overflow, overflowsub, overflowadd);
	
endmodule
