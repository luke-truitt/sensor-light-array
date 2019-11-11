module alu_data_ctrl(alu_d, opcode);

	input[4:0] opcode;
	output alu_d;
	
	assign alu_d = opcode[3];

endmodule
