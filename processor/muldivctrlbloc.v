module muldivctrlbloc(ctrl_Div, ctrl_Mult, ir);

	input[31:0] ir;
	output ctrl_Div, ctrl_Mult;
	
	wire[4:0] opcode, alu_op;
	wire[4:0] aluoperation, mult, div;
	wire is_alu, is_mult, is_div;
	
	assign opcode[4:0] = ir[31:27];
	assign alu_op[4:0] = ir[6:2];
	
	assign aluoperation[4:0] = 5'b00000;
	assign mult[4:0] = 5'b00110;
	assign div[4:0] = 5'b00111;
	
	assign is_alu = opcode[4:0] == aluoperation[4:0];
	assign is_mult = alu_op[4:0] == mult[4:0];
	assign is_div = alu_op[4:0] == div[4:0];
	
	assign ctrl_Div = is_alu && is_div;
	assign ctrl_Mult = is_alu && is_mult;
	
endmodule
