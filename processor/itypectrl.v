module itypectrl(itype, opcode);

	input[4:0] opcode;
	wire addi, sw, lw, bne, blt;
	wire not4,not3,not2,not1,not0;
	output itype;
	not not_0(not0, opcode[0]);
	not not_1(not1, opcode[1]);
	not not_2(not2, opcode[2]);
	not not_3(not3, opcode[3]);
	not not_4(not4, opcode[4]);
	and outaddi(addi, not4,not3,opcode[2],not1,opcode[0]);
	and outsw(sw, not4,not3,opcode[2],opcode[1],opcode[0]);
	and outlw(lw, not4, opcode[3], not2, not1,not0);
	and outbne(bne, not4, not3, not2, opcode[1], not0);
	and outblt(blt, not4, not3, opcode[2], opcode[1], not0);
	
	or it(itype, addi, sw, lw, bne, blt);

endmodule
