module jitype_ctrl(jitype, opcode);

	input[4:0] opcode;
	output jitype;
	wire j, jal, bex, setx;
	
	and jand(j, ~opcode[4], ~opcode[3],~opcode[2], ~opcode[1], opcode[0]);
	and jaland(jal, ~opcode[4], ~opcode[3], ~opcode[2], opcode[1], opcode[0]);
	and bexand(bex, opcode[4], ~opcode[3], opcode[2], opcode[1], ~opcode[0]);
	and setxand(setx, opcode[4], ~opcode[3], opcode[2], ~opcode[1], opcode[0]);
	
	or jior(jitype, j, jal, bex, setx);
	
endmodule
