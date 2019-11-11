module multdiv_Ctrl(multSig, divSig, opcode, alu_op);

	input[4:0] opcode, alu_op;
	output multSig, divSig;
	
	wire alu, mult, div;
	
	and aluand(alu, ~opcode[4], ~opcode[3], ~opcode[2], ~opcode[1], ~opcode[0]);
	and multand(mult, ~opcode[4], ~opcode[3], opcode[2], opcode[1], ~opcode[0]);
	and divand(div, ~opcode[4], ~opcode[3], opcode[2], opcode[1], opcode[0]);
	
	and multsigand(multSig, alu, mult);
	and divsigand(divSig, alu, div);
	
endmodule
