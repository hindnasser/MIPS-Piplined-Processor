module Op2Src_MUX (Op2Src, ID_EXE_Rt, ID_EXE_ExtendedImm, ID_EXE_ALUSrc, clk);

// input 
	input [31:0] ID_EXE_ExtendedImm, ID_EXE_Rt;
	input ID_EXE_ALUSrc, clk;
	
// output 
	output reg [31:0] Op2Src;
	
	
	always @(posedge clk)
		begin
			if(ID_EXE_ALUSrc == 0)
				Op2Src = ID_EXE_Rt;
			if (ID_EXE_ALUSrc == 1)
				Op2Src = ID_EXE_ExtendedImm;
		end
		
endmodule
