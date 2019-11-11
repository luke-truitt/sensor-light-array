module slq(q, q_old, q_bit);

	input [31:0] q_old;
	input q_bit;
	output [31:0] q;
	
	assign q[0] = q_bit;
	
	assign q[1] = q_old[0];
	assign q[2] = q_old[1];
	assign q[3] = q_old[2];
	assign q[4] = q_old[3];
	assign q[5] = q_old[4];
	assign q[6] = q_old[5];
	assign q[7] = q_old[6];
	assign q[8] = q_old[7];
	assign q[9] = q_old[8];
	assign q[10] = q_old[9];
	assign q[11] = q_old[10];
	assign q[12] = q_old[11];
	assign q[13] = q_old[12];
	assign q[14] = q_old[13];
	assign q[15] = q_old[14];
	assign q[16] = q_old[15];
	assign q[17] = q_old[16];
	assign q[18] = q_old[17];
	assign q[19] = q_old[18];
	assign q[20] = q_old[19];
	assign q[21] = q_old[20];
	assign q[22] = q_old[21];
	assign q[23] = q_old[22];
	assign q[24] = q_old[23];
	assign q[25] = q_old[24];
	assign q[26] = q_old[25];
	assign q[27] = q_old[26];
	assign q[28] = q_old[27];
	assign q[29] = q_old[28];
	assign q[30] = q_old[29];
	assign q[31] = q_old[30];

endmodule
