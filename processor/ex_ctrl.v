module ex_ctrl(ir_out, ir, alu_ovf, data_exception);

	input alu_ovf, data_exception;
	input[31:0] ir;
	output[31:0] ir_out;
	
	wire[31:0] setx_add, setx_addi, setx_sub, setx_mult, setx_div;
	
	assign setx_add[31:0] = 32'b10101000000000000000000000000001;
	assign setx_addi[31:0] = 32'b10101000000000000000000000000010;
	assign setx_sub[31:0] = 32'b10101000000000000000000000000011;
	assign setx_mult[31:0] = 32'b10101000000000000000000000000100;
	assign setx_div[31:0] = 32'b10101000000000000000000000000101;
	
	wire is_mult_ovf, is_div_ovf, is_add_ovf, is_addi_ovf, is_sub_ovf;
	wire[4:0] add, sub, mult, div, alu, addi, opcode, alu_op;
	
	assign add[4:0] = 5'b00000;
	assign sub[4:0] = 5'b00001;
	assign mult[4:0] = 5'b00110;
	assign div[4:0] = 5'b00111;
	assign alu[4:0] = 5'b00000;
	assign addi[4:0] = 5'b00101;
	assign opcode[4:0] = ir[31:27];
	assign alu_op[4:0] = ir[6:2];
	
	assign is_mult_ovf = (opcode[4:0] == alu[4:0]) && (alu_op[4:0] == mult[4:0]) && data_exception;
	assign is_div_ovf = (opcode[4:0] == alu[4:0]) && (alu_op[4:0] == div[4:0]) && data_exception;
	assign is_add_ovf = (opcode[4:0] == alu[4:0]) && (alu_op[4:0] == add[4:0]) && alu_ovf;
	assign is_addi_ovf = (opcode[4:0] == addi[4:0]) && alu_ovf;
	assign is_sub_ovf = (opcode[4:0] == alu[4:0]) && (alu_op[4:0] == sub[4:0]) && alu_ovf;
	
	assign ir_out = is_add_ovf ? setx_add : is_addi_ovf ? setx_addi : is_sub_ovf ? setx_sub : is_mult_ovf ? setx_mult : is_div_ovf ? setx_div : ir;
	
endmodule
