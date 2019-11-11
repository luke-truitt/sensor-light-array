module setxjal_ctrl(setx, jal, opcode);

	input[4:0] opcode;
	output jal, setx;
	
	and jaland(jal, ~opcode[31], ~opcode[30], ~opcode[29], opcode[28], opcode[27]);
	and setxand(setx, opcode[31], ~opcode[30], opcode[29], ~opcode[28], opcode[27]);
	

endmodule
