module EXE_MEM_Register (EXE_MEM_FPTregData, EXE_MEM_FPLoadStore, EXE_MEM_LoHiWrite, EXE_MEM_LoRead, EXE_MEM_HiRead, EXE_MEM_R_memtoReg, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_Result, 
								 EXE_MEM_DstReg, EXE_MEM_FP_DstReg, EXE_MEM_Treg,EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_MEM_Byte, 
								 EXE_MEM_JmpandLink, EXE_MEM_double, EXE_MEM_CompareOp, EXE_MEM_floatop, ID_EXE_floatop, ID_EXE_double, ID_EXE_JmpandLink, ID_EXE_Byte, CompareOp, EXE_Result, 
								 EXE_DstReg, EXE_FP_DstReg, ID_EXE_Treg, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg,
								 EXE_LoHiWrite, EXE_LoRead, EXE_HiRead,ID_EXE_FPLoadStore, ID_EXE_FPReadData1, clk);

// input
	input [63:0] EXE_Result, ID_EXE_Treg, ID_EXE_FPReadData1;
	input [4:0] EXE_DstReg, EXE_FP_DstReg;
	input ID_EXE_FPLoadStore, ID_EXE_Byte, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, ID_EXE_JmpandLink, EXE_LoHiWrite, EXE_LoRead,
			EXE_HiRead, ID_EXE_double, CompareOp, ID_EXE_floatop, clk;
	
// output
	output reg [63:0] EXE_MEM_Result, EXE_MEM_Treg, EXE_MEM_FPTregData;
	output reg [4:0] EXE_MEM_DstReg, EXE_MEM_FP_DstReg;
	output reg EXE_MEM_FPLoadStore, EXE_MEM_Byte, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_JmpandLink,
				  EXE_MEM_R_memtoReg, EXE_MEM_LoHiWrite, EXE_MEM_LoRead, EXE_MEM_HiRead, EXE_MEM_double, EXE_MEM_CompareOp, EXE_MEM_floatop;
	
	always @(posedge clk)
		begin
			EXE_MEM_Result <= EXE_Result;
			EXE_MEM_DstReg <= EXE_DstReg;
			EXE_MEM_MemtoReg <= MemtoRegIn;
			EXE_MEM_Treg <= ID_EXE_Treg;		
			EXE_MEM_RegWrite <= RegWriteIn;
			EXE_MEM_MemRead <= MemReadIn;
			EXE_MEM_MemWrite <= MemWriteIn;
			EXE_MEM_ReadfromMem <= EXE_ReadfromMem;
			EXE_MEM_WritetoMem <= EXE_WritetoMem;
			EXE_MEM_R_memtoReg <= EXE_R_memtoReg;
			EXE_MEM_Byte <= ID_EXE_Byte;
			EXE_MEM_JmpandLink <= ID_EXE_JmpandLink;
			EXE_MEM_FP_DstReg <= EXE_FP_DstReg;
			EXE_MEM_LoHiWrite <= EXE_LoHiWrite;
			EXE_MEM_LoRead <= EXE_LoRead;
			EXE_MEM_HiRead <= EXE_HiRead;
			EXE_MEM_double <= ID_EXE_double;
			EXE_MEM_CompareOp <= CompareOp;
			EXE_MEM_floatop <= ID_EXE_floatop;
			EXE_MEM_FPLoadStore <= ID_EXE_FPLoadStore;
			EXE_MEM_FPTregData <= ID_EXE_FPReadData1;
				
		end
endmodule
