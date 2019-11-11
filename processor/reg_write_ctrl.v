module reg_write_ctrl(write_en, opcode, write_reg);

	input[4:0] opcode, write_reg;
	output write_en;
	wire cmd;
	wire jal, alu, addi, lw, setx;
	wire not4,not3,not2,not1,not0;
	
	not not_0(not0, opcode[0]);
	not not_1(not1, opcode[1]);
	not not_2(not2, opcode[2]);
	not not_3(not3, opcode[3]);
	not not_4(not4, opcode[4]);
	
	and setx_and(setx, opcode[4], not3, opcode[2], not1, opcode[0]);
	and lw_and(lw, not4, opcode[3], not2, not1, not0);
	and jal_and(jal, opcode[1], opcode[0], not2, not3, not4);
	and alu_and(alu, not4,not3,not2,not1,not0);
	and addi_and(addi, not4,not3,opcode[2],not1, opcode[0]);

	or out(cmd, jal, alu, addi, lw, setx);
	
	assign write_en = cmd && ~(write_reg == 5'b00000 && (alu || addi || lw));
endmodule
