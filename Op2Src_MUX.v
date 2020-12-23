module Op2Src_MUX (Op2Src, ID_EXE_Rt, ID_EXE_ExtendedImm, ALUSrc, clk);

// input 
	input [31:0] ID_EXE_ExtendedImm, ID_EXE_Rt;
	input ALUSrc, clk;
	
// output 
	output reg [31:0] Op2Src;
	
	
	always @(posedge clk)
		begin
			if(ALUSrc == 0)
				Op2Src = ID_EXE_Rt;
			if (ALUSrc == 1)
				Op2Src = ID_EXE_ExtendedImm;
		end
		
endmodule
