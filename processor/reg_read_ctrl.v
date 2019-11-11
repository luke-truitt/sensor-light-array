module reg_read_ctrl(read_a, read_b, ir);

	input[31:0] ir;
	output[4:0] read_a, read_b;
	
	wire[4:0] ra, rstatus, rzero; //r31, r30, r0
	assign rzero[4:0] = 5'b00000;
	assign ra[4:0] = 5'b11111;
	assign rstatus[4:0] = 5'b11110;
	
	wire[4:0] blt, bne, bex, sw, opcode,jr;
	assign blt[4:0] = 5'b00110;
	assign bne[4:0] = 5'b00010;
	assign bex[4:0] = 5'b10110;
	assign jr[4:0] = 5'b00100;
	assign sw[4:0] = 5'b00111;
	assign opcode[4:0] = ir[31:27];
	wire isblt, isbne, isbex,issw, isjr;
	assign isblt = blt[4:0] == opcode[4:0];
	assign isbne = bne[4:0] == opcode[4:0];
	assign isbex = bex[4:0] == opcode[4:0];
	assign isjr = jr[4:0] == opcode[4:0];
	assign issw = sw[4:0] == opcode[4:0];
	assign read_a[4:0] = isbex ? rstatus : (isblt || isbne || isjr) ? ir[26:22] : ir[21:17];
	assign read_b[4:0] = isbex ? rzero : (isblt || isbne) ? ir[21:17] : issw ? ir[26:22] : ir[16:12];

endmodule
