module pc_ctrl_sel(pc_sel, opcode);

	input[4:0] opcode;
	output pc_sel;
	
	wire lw, sw, alu, addi, setx;
	wire not4,not3,not2,not1,not0;
	
	not not_0(not0, opcode[0]);
	not not_1(not1, opcode[1]);
	not not_2(not2, opcode[2]);
	not not_3(not3, opcode[3]);
	not not_4(not4, opcode[4]);
	
	and lw_and(lw, not4, opcode[3], not2, not1, not0);
	and sw_and(sw, not4, not3, opcode[1], opcode[2], opcode[0]);
	and alu_and(alu, not4,not3,not2,not1,not0);
	and addi_and(addi, not4,not3,opcode[2],not1,opcode[0]);
	and setx_and(setx, opcode[4], opcode[3], opcode[2], opcode[1], opcode[0]);
	
	nor out(pc_sel, setx, lw, sw, alu, addi);
endmodule
