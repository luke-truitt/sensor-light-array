module data_reg(wren, opcode);

	input[4:0] opcode;
	output wren;
	
	and wren_and(wren, opcode[1], opcode[2], opcode[0]);

endmodule
