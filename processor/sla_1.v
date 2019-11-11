module sla_1(out, in);

	input [31:0] in;
	output [31:0] out;
	
	assign out[0] = 0;
	generate
		genvar i;
		for(i = 0; i < 31; i = i + 1) 
			begin: gen1
				assign out[i+1] = in[i];
			end
	endgenerate
	
endmodule
