module alu_opcode_ctrl(out, opcode, alu_opcode);

	input[4:0] opcode,alu_opcode;
	output[4:0] out;
	wire[4:0] add_opcode, sub_opcode, tout;
	wire addi, sw, lw, bne, blt, itype, bex,comp;
	wire not4,not3,not2,not1,not0;
	
	assign add_opcode[4:0] = 5'b00000;
	assign sub_opcode[4:0] = 5'b00001;
	
	not not_0(not0, opcode[0]);
	not not_1(not1, opcode[1]);
	not not_2(not2, opcode[2]);
	not not_3(not3, opcode[3]);
	not not_4(not4, opcode[4]);

	and outaddi(addi, not4,not3,opcode[2],not1,opcode[0]);
	and outsw(sw, not4,not3,opcode[2],opcode[1],opcode[0]);
	and outlw(lw, not4, opcode[3], not2, not1,not0);
	and outbne(bne, not4, not3, not2, opcode[1], not0);
	and outblt(blt, not4, not3, opcode[2], opcode[1], not0);
	and outbex(bex, opcode[4], not3, opcode[2], opcode[1], not0);
	
	or it(itype, addi, sw, lw);
	or sub(comp, bne, blt, bex);
	mux_2 out_mux(tout, alu_opcode, add_opcode, itype);
	assign out[4:0] = comp ? sub_opcode[4:0] : tout[4:0];
endmodule
