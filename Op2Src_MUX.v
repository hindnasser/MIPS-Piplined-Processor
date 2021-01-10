module Op2Src_MUX(Op2Src, ID_EXE_TregData, ID_EXE_DregData, ID_EXE_ExtendedImm, ID_EXE_ALUSrc, MemNew);
	
	// input
		input [63:0] ID_EXE_DregData, ID_EXE_ExtendedImm, ID_EXE_TregData;
		input ID_EXE_ALUSrc, MemNew;
		
		
	// output
		output reg [63:0] Op2Src;
		
		always @(*)
			begin
				if(MemNew)
					Op2Src <= ID_EXE_DregData;
					
				else if(ID_EXE_ALUSrc)
					Op2Src <= ID_EXE_ExtendedImm;
					
				else 
					Op2Src <= ID_EXE_TregData;
			end
endmodule
			