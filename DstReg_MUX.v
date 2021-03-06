module DstRegMUX (EXE_DstReg, ID_EXE_Treg, ID_EXE_Dreg, ID_EXE_RegDst, MemNew);

// input 
	input [4:0] ID_EXE_Dreg, ID_EXE_Treg;
	input ID_EXE_RegDst, MemNew;
	
// output
	output reg [4:0] EXE_DstReg;
	
	always @(*)
		begin
			if(MemNew == 1 || ID_EXE_RegDst == 0)
				EXE_DstReg <= ID_EXE_Treg;
			else  
				EXE_DstReg <= ID_EXE_Dreg;
		end
		
endmodule
