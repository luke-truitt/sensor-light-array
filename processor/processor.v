 /**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                   // I: Data from port B of regfile
);

    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 
	 
    /* YOUR CODE STARTS HERE */
	 // Register for PC (12bit)
	 // Adder to inc. PC by 4
	 // Mux to choose btwn PC+4 and RA
	 // Output of PC Reg goes to Address_imem
	 // Input of Imem goes into the FD Register
	 // Register for FD (44 bit?)
	 // Bottom 32-bits into bottom 32-bits of DX Reg
	 // Top 32-bits into top 32-bits of DX Reg
	 // Reg File in A into Top Mid 32 bits of DX Reg
	 // Reg File in B into Bottom Mid 32 bits of DX Reg
	 // Data read A to regfile from Bottom 32 of FD Reg
	 // Data read B to regfile from Bottom 32 of FD Reg
	 // Register for DX (108-bit?)
	 // Top 32-bits from DX to PC adder 
	 // Top Mid 32-Bits of DX to alu A
	 // Bottom Mid 32-Bits of DX to mux B and XM Reg Middle
	 // Bottom 32-bits into XM Reg and SignExtender for Immediate
	 // Output of sign extension into left shifter into PC Adder and Mux B
	 // Out of mux b into alu B
	 // NEQ output of alu into an and that controls a mux for the PC
	 // Output of alu into top of XM Reg (96 bit?)
	 // Top 32 of XM into DMEM output a and top 32 of MW
	 // DMEM input to mid 32 of MW
	 // DMEM Data output from Mid 32 of XM
	 // MW Reg (96 bit?) bottom 32 from bottom 32 of XM
	 // MW bottom 32 to Register file write data  	
	 // Top 32 and mid 32 of MW into mux with output to write data in Reg File
	 // ___________________
	 // REGISTER STUFF
	 // ___________________
	 wire[4:0] ra, rstatus, rzero; //r31, r30, r0
	 assign ra[4:0] = 5'b11111;
	 assign rstatus[4:0] = 5'b11110;
	 assign rzero[4:0] = 5'b00000;
	 // ___________________
	 // BYPASS CTRL STUFF
	 // ___________________
	 wire mxa, mxb; // CTRL Bits for MX bypassing on either a or b
	 wire wxa, wxb; // CTRL Bits for WX bypassing on either a or b
	 wire wm; // CTRL Bits for WM bypassing on either a or b
	 mx_bypass mxbypassctrl(mxa, mxb, dx_ir_out, xm_ir_out);
	 wx_bypass wxbypassctrl(wxa, wxb, dx_ir_out, mw_ir_out);
	 wm_bypass wmbypassctrl(wm, xm_ir_out, mw_ir_out);
	 // ___________________
	 // DATA HAZARD CTRL STUFF
	 // ___________________
	 wire data_stall; // 1:DATA HAZARD (Insert NOP into fd_ir_in) 0: All good
	 data_hazard dh(data_stall, fd_ir_out, dx_ir_out, xm_ir_out, mw_ir_out);
	 wire md_stall;// 1:MULT HAZARD (Insert NOP into fd_ir_in) 0: All good
	 multdivstall mdsctrl(md_stall, ctrl_MULT, ctrl_DIV, data_resultRDY);
	 wire stall; // 1:HAZARD (Insert NOP into fd_ir_in) 0: All good
	 assign stall = data_stall || md_stall;
	 wire[31:0] nop;
	 assign nop[31:0] = 32'b00000000000000000000000000000000;
	 // ___________________
	 // CONTROL HAZARD CTRL STUFF
	 // ___________________
	 wire control_hazard; //1: CTRL HAZARD (Insert NOPS into IR registers), 0: All good
	 assign control_hazard = pc_sel; //Use the whether or not we should branch control
	 // ___________________
	 // PC STUFF
	 // ___________________
	 wire[31:0] branch_pc; // PC of place to jump to if we are supposed to jump
	 wire [31:0] pc_in; // The actual PC that matters, this is what's going into the PC Reg
	 wire [31:0] p_one; // Constant 1
	 wire [31:0] pc_out; // Output of the PC Reg, set one clock cycle before by PC_IN
	 wire [31:0] next_pc; // PC + 1
	 wire pc_cout; // Not used
	 assign p_one[31:0] = 32'b00000000000000000000000000000001; // Plus one constant
	 wire pc_sel; // Whether or not we should branch, also used for ctrl hazard\
	 assign pc_in[31:0] = stall ? pc_out[31:0] : pc_normal[31:0];// Use stall to either move pc forward or stall it out
	 pc_reg my_pc(pc_in, pc_out, clock, reset);
	 adder_wrapper pc_adder(next_pc, pc_cout, p_one, pc_out, 1'b0); // Increments pc by one
	 wire[31:0] pc_normal; // The pc that would normally be next if there wasn't a hazard
	 assign pc_normal[31:0] = pc_sel ? branch_pc[31:0] : next_pc[31:0]; // Use branch select to pick either what would be next or branch
	 assign address_imem[11:0] = pc_out[11:0]; // Address to imem
	 
	 // ___________________
	 // ___________________
	 // FD STUFF
	 // ___________________
	 wire [31:0] fd_ir_in; //Decide between NOP and qimem if needed to stall or ctrl hazard
	 assign fd_ir_in[31:0] = control_hazard ? nop[31:0] : stall ? fd_ir_out[31:0] : q_imem[31:0];
	 wire[31:0] fd_pc_in;
	 assign fd_pc_in[31:0] = stall ? fd_pc_out[31:0] : next_pc[31:0];
	 wire [31:0] fd_pc_out;
	 wire[31:0] fd_ir_out; 
	 fd_reg my_fd(fd_pc_in, fd_ir_in, fd_pc_out, fd_ir_out, clock, reset);
	 reg_read_ctrl rrc(ctrl_readRegA, ctrl_readRegB, fd_ir_out);
	 // ___________________
	 // ___________________
	 // DX STUFF
	 // ___________________
	 
	 wire[31:0] sign_extend_i;
	 wire[31:0] dx_a_out;
	 wire[31:0] dx_ir_out;
	 wire[31:0] dx_b_out;
	 wire [31:0] alu_out;
	 wire[31:0] dx_ir_in; //Used for inserting NOP if necessary
	 assign dx_ir_in[31:0] = (control_hazard||stall) ? nop[31:0] : fd_ir_out[31:0];
	 
	 wire[31:0] dx_pc_out;
	 dx_reg my_dx(fd_pc_out, data_readRegA, data_readRegB, dx_ir_in, dx_pc_out, dx_a_out, dx_b_out, dx_ir_out, clock, reset);
	 immediate_extender my_sx(sign_extend_i, dx_ir_out);
	 // ___________________
	 // ___________________
	 // ALU STUFF
	 // ___________________
	 
	 wire alu_ne, alu_le;
	 wire [4:0] alu_op; // Op into ALU to determine 
	 alu_opcode_ctrl aluctrlop(alu_op, dx_ir_out[31:27], dx_ir_out[6:2]);
	 wire [4:0] shft_amt; // Input to ALU
	 assign shft_amt[4:0] = dx_ir_out[11:7];
	 
	 wire b_sel;
	 b_ctrl bctrl(b_sel, dx_ir_out[31:27]);
	 
	 wire[31:0] wxb_data; //either imm_datab or mxb bypass
	 assign wxb_data = wxb ? data_writeReg[31:0] : dx_b_out[31:0];
	 
	 wire [31:0] b_in; // Either Bypassed MXB or WXB, DataReg_B, Sign Extended Immidiate
	 assign b_in[31:0] = mxb ? xm_o_out[31:0] : wxb_data[31:0];
	 
	 wire[31:0] calc_b_in; //either B from Regfile or Extended Immediate;
	 assign calc_b_in = b_sel ? sign_extend_i : b_in;
	 
	 wire[31:0] calc_a_in; // Either DataReg_A, Bypassed MXA or WXA
	 wire[31:0] wxa_data; //either dataa or mxa bypass
	 
	 assign wxa_data[31:0] = wxa ? data_writeReg[31:0] : dx_a_out[31:0];
	 assign calc_a_in[31:0] = mxa ? xm_o_out[31:0] : wxa_data[31:0];
	 
	 wire alu_ovf;
	 alu my_alu(calc_a_in, calc_b_in, alu_op, shft_amt, alu_out, alu_ne, alu_le, alu_ovf);
	 
	 // ___________________
	 // ___________________
	 // MULTDIV STUFF
	 // ___________________
	 
	 wire ctrl_MULT, ctrl_DIV; //Inputs
	 muldivctrlbloc mdctrl(ctrl_DIV, ctrl_MULT, dx_ir_out);
	 wire is_md;
	 assign is_md = ctrl_DIV || ctrl_MULT;
	 
	 register mult_reg(multdiv_ins, dx_ir_out, is_md, 1'b0);
	 
	 wire[31:0] data_result;
	 wire[31:0] multdiv_ins;
	 wire data_exception;
	 wire data_resultRDY; //Ouputs
	 multdiv my_multdiv(calc_a_in, calc_b_in, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
	 
	 // ___________________
	 // ___________________
	 // BRANCH STUFF
	 // ___________________
	 
	 branch_ctrl bc(branch_pc, pc_sel, dx_pc_out, dx_a_out, dx_ir_out, alu_ne, alu_le);
	 
	 //____________________
	 // SELECT FROM DATA OUTPUTS -- MULT/ALU/PC
	 // ___________________
	 // Select PC if JAL
	 // Select MULT if MULT RDY
	 // Select ALU Else
	 wire jal_dx;
	 assign jal_dx = dx_ir_out[31:27] == 5'b00011;
	 wire[31:0] alu_mult; //Either the alu or mult output
	 assign alu_mult[31:0] =  data_resultRDY ? data_result[31:0] : alu_out[31:0];
	 wire[31:0] data_out; // Either pc_mult or ALU
	 assign data_out[31:0] = jal_dx ? dx_pc_out[31:0] : alu_mult[31:0];
	 
	 // ___________________
	 // RSTATUS STUFF
	 // ___________________
	 ex_ctrl exctrl(xm_ir_in, xm_ir_pre_ex, alu_ovf, data_exception);
	 
	 // ___________________
	 // ___________________
	 // XM STUFF
	 // ___________________
	 // XM
	 wire [31:0] xm_o_out;
	 wire[31:0] xm_b_out;
	 wire[31:0] xm_ir_pre_ex, xm_ir_in;
	 assign xm_ir_pre_ex[31:0] = md_stall ? nop[31:0] : data_resultRDY ? multdiv_ins[31:0] : dx_ir_out[31:0];
	 wire [31:0] xm_ir_out;
	 xm_reg my_xm(data_out, dx_b_out, xm_ir_in, xm_o_out, xm_b_out, xm_ir_out, clock, reset);
	 assign data[31:0] = wm ? data_writeReg[31:0] : xm_b_out[31:0];
	 assign address_dmem[11:0] = xm_o_out[11:0];
	 wren_ctrl wrenctrl(wren, xm_ir_out[31:27]);                                                                                                                                 
	 // __________________
	 // __________________
	 // MW STUFF
	 // __________________
	 // MW
	 wire[31:0] mw_o_out, mw_d_out;
	 wire[31:0] mw_ir_out;
	 wire write_data_ctrl; // Select between Data or ALU out
	 mw_reg my_mw(xm_o_out, q_dmem, xm_ir_out, mw_o_out, mw_d_out, mw_ir_out, clock, reset);
	 
	 wire jal; // JAL Command
	 assign jal = mw_ir_out[31:27] == 5'b00011;
	 
	 wire setx; // SETX Command
	 assign setx = mw_ir_out[31:27] == 5'b10101;
	 
	 wire[31:0] dmem_data_out; // Data out of the DMEM
	 assign dmem_data_out[31:0] = write_data_ctrl ? mw_d_out[31:0] : mw_o_out[31:0];
	 
	 wire[31:0] tdata; // Setx bottom 27 bits
	 assign tdata[31:27] = 5'b00000;
	 assign tdata[26:0] = mw_ir_out[26:0];
	 
	 // NEXT_PC is probably wrong here
	 assign ctrl_writeReg[4:0] = jal ? ra : setx ? rstatus : mw_ir_out[26:22];
	 assign data_writeReg[31:0] = setx ? tdata[31:0] : dmem_data_out[31:0];
	 
	 reg_write_ctrl regwritectrl(ctrl_writeEnable, mw_ir_out[31:27], mw_ir_out[26:22]);
	 alu_data_ctrl aludatactrl(write_data_ctrl, mw_ir_out[31:27]);
	 
endmodule
