module PC_MUX (PCSrc, Src1, Src2, Signal);

// input 
	input [31:0] Src1, Src2;
	input Signal;
	//clk;
	
// output 
	output reg [31:0] PCSrc;
		
	initial
		begin
			PCSrc <= Src1;
		end
		
	always @(*)
		begin
			if(Signal == 1) 
				PCSrc <= Src2;
		   else
				PCSrc <= Src1;
		end
		
endmodule
