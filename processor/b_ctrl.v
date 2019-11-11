module b_ctrl(b_imm, opcode);

	input[4:0] opcode;
	output b_imm;
	
	wire not4,not3,not2,not1,not0, branch, notbranch, notalu;
	
	not not_0(not0, opcode[0]);
	not not_1(not1, opcode[1]);
	not not_2(not2, opcode[2]);
	not not_3(not3, opcode[3]);
	not not_4(not4, opcode[4]);
	
	nand aluout(notalu, not4,not3,not2,not1,not0);
	wire bex; // If the current instruction is a bex
	and bexand(bex, opcode[4], ~opcode[3], opcode[2], opcode[1], ~opcode[0]);
	 
	wire bne;// If Current Instruction is BNE
	and bneand(bne, ~opcode[4], ~opcode[3], ~opcode[2], opcode[1], ~opcode[0]);
	
	wire blt;// If Current Instruction is BNE
	and bltand(blt, ~opcode[4], ~opcode[3], opcode[2], opcode[1], ~opcode[0]);
	assign notbranch = ~blt && ~bne && ~bex;
	
	and out(b_imm, notbranch, notalu);
	
endmodule
