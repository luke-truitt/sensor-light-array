module counter(count, clock, clear);

	input clock, clear;
// T flip flop water fall
	output[5:0] count;
	
	wire tff_out0;
	wire tff_out1;
	wire tff_out2;
	wire tff_out3;
	wire tff_out4;
	wire tff_out5;
	wire ntff0,ntff1,ntff2,ntff3,ntff4;
	
	not out0not(ntff0, tff_out0);
	not out1not(ntff1, tff_out1);
	not out2not(ntff2, tff_out2);
	not out3not(ntff3, tff_out3);
	not out4not(ntff4, tff_out4);
	
	tflipflop tff0(tff_out0, clock, clear);
	tflipflop tff1(tff_out1, ntff0, clear);
	tflipflop tff2(tff_out2, ntff1, clear);
	tflipflop tff3(tff_out3, ntff2, clear);
	tflipflop tff4(tff_out4, ntff3, clear);
	tflipflop tff5(tff_out5, ntff4, clear);
	
	assign count[5] = tff_out5;
	assign count[4] = tff_out4;
	assign count[3] = tff_out3;
	assign count[2] = tff_out2;
	assign count[1] = tff_out1;
	assign count[0] = tff_out0;
	
endmodule
