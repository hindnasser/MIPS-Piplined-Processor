module EXE_MEM_Register (EXE_MEM_R_memtoReg, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_Result, EXE_MEM_DstReg, EXE_MEM_Rt,EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite,
								 EXE_Result, EXE_DstReg, ID_EXE_Rt, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, clk);

// input
	input [31:0] EXE_Result, ID_EXE_Rt;
	input [4:0] EXE_DstReg;
	input MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, clk;
//	clk;
	
// output
	output reg [31:0] EXE_MEM_Result, EXE_MEM_Rt;
	output reg [4:0] EXE_MEM_DstReg;
	output reg EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_R_memtoReg;
	
	always @(posedge clk)
		begin
			EXE_MEM_Result <= EXE_Result;
			EXE_MEM_DstReg <= EXE_DstReg;
			EXE_MEM_MemtoReg <= MemtoRegIn;
			EXE_MEM_Rt <= ID_EXE_Rt;		
			EXE_MEM_RegWrite <= RegWriteIn;
			EXE_MEM_MemRead <= MemReadIn;
			EXE_MEM_MemWrite <= MemWriteIn;
			EXE_MEM_ReadfromMem <= EXE_ReadfromMem;
			EXE_MEM_WritetoMem <= EXE_WritetoMem;
			EXE_MEM_R_memtoReg <= EXE_R_memtoReg;
				
		end
endmodule
