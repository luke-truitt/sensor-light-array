module branch_ctrl(branch_pc, pc_sel, pc, a, ir, alu_ne, alu_lessthan);

	 input[31:0] pc, a, ir;
	 input alu_ne, alu_lessthan;
	 
	 wire[31:0] branch_immediate; // Sign Extended Immediate to branch to
	 immediate_extender my_sx(branch_immediate, ir);
	 
	 wire[31:0] branchadd; // PC + 1 + N
	 adder_wrapper branch_adder(branchadd, branch_cout, pc, branch_immediate, 1'b0);
	 
	 wire[31:0] taddy; // Address specified by a j1 type instruction (27bits) 0 padded
	 assign taddy[31:27] = 5'b00000;
	 assign taddy[26:0] = ir[26:0];
	 
	 wire jitype; // If the current instruction is j1
	 jitype_ctrl jictrl(jitype, ir[31:27]); 
	
	 wire jr; // If the current instruction is a jr, aka j2 instruction
	 and jrand(jr, ~ir[31], ~ir[30], ir[29], ~ir[28], ~ir[27]);
	 
	 wire j; // If the current instruction is a j
	 and jand(j, ~ir[31], ~ir[30], ~ir[29], ~ir[28], ir[27]);
	 
	 wire jal; // If the current instruction is a jal
	 and jaland(jal, ~ir[31], ~ir[30], ~ir[29], ir[28], ir[27]);
	 
	 wire bex; // If the current instruction is a bex
	 and bexand(bex, ir[31], ~ir[30], ir[29], ir[28], ~ir[27]);
	 
	 wire bne;// If Current Instruction is BNE
	 and bneand(bne, ~ir[31], ~ir[30], ~ir[29], ir[28], ~ir[27]);
	 
	 wire blt;// If Current Instruction is BNE
	 and bltand(blt, ~ir[31], ~ir[30], ir[29], ir[28], ~ir[27]);
	 
	 output[31:0] branch_pc; // Location to branch to (if necessary)
	 assign branch_pc[31:0] = jitype ? taddy[31:0] : jr ? a[31:0] : branchadd[31:0];
	 
	 
	 output pc_sel; // **Determine If Necessary**
	 wire qualifies;//
	 // If it is JR,JAL, or J it should always branch
	 // If it's a NE command (BNE or BEX) then check if it's not equal
	 // If it's LT command (BLT) then check if it's less than and not equal;
	 assign qualifies = (jr || j || jal) ? 1'b1 : (bne || bex) ? alu_ne : blt ? (alu_lessthan) : 1'b0;
	 assign pc_sel = qualifies;
	 
//	 branch_disection bd(bne, blt, opcode[31:27]);
//	 and branch_and(pc_sel, branch_ctrl_wire, leq);
//	 pc_ctrl_sel pcctrl(branch_ctrl_wire, dx_ir_out[31:27]);
	
	 
//	input[4:0] opcode;
//	output branch;
//	wire bne, blt;
//	wire not4,not3,not2,not1,not0;
//	not not_0(not0, opcode[0]);
//	not not_1(not1, opcode[1]);
//	not not_2(not2, opcode[2]);
//	not not_3(not3, opcode[3]);
//	not not_4(not4, opcode[4]);
//	
//	and outbne(bne, not4, not3, not2, opcode[1], not0);
//	and outblt(blt, not4, not3, opcode[2], opcode[1], not0);
//	
//	or b(branch, bne, blt);
	
endmodule
