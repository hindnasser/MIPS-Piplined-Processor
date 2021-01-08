module EXE_MEM_Register (EXE_MEM_R_memtoReg, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_Result, EXE_MEM_DstReg, EXE_MEM_FP_DstReg, EXE_MEM_Treg,EXE_MEM_MemRead,
								 EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_MEM_Byte, EXE_MEM_JmpandLink, ID_EXE_JmpandLink, ID_EXE_Byte, EXE_Result, 
								 EXE_DstReg, EXE_FP_DstReg, ID_EXE_Treg, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, clk);

// input
	input [63:0] EXE_Result, ID_EXE_Treg;
	input [4:0] EXE_DstReg, EXE_FP_DstReg;
	input ID_EXE_Byte, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, ID_EXE_JmpandLink, clk;
	
// output
	output reg [63:0] EXE_MEM_Result, EXE_MEM_Treg;
	output reg [4:0] EXE_MEM_DstReg, EXE_MEM_FP_DstReg;
	output reg EXE_MEM_Byte, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_JmpandLink, EXE_MEM_R_memtoReg;
	
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
				
		end
endmodule
