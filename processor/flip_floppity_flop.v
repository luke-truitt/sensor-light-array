module flip_floppity_flop(q, d, clk, aclr);
	input 	d, aclr, clk;
	output q;
	reg q;
			
	always @(posedge clk or 
		 posedge aclr) begin
  	  if(aclr) begin
	    q = 1'b0;
	  end else begin
	    q = d;
	  end
	end

endmodule
