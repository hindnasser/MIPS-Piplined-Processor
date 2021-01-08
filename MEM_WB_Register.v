module MEM_WB_Register (MEM_WB_R_memtoReg, MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_DstReg, MEM_WB_FP_DstReg, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_JmpandLink, EXE_MEM_JmpandLink,
								MEM_Result, EXE_MEM_Result, EXE_MEM_DstReg, EXE_MEM_FP_DstReg, MemtoRegIn, RegWriteIn, MEM_R_memtoReg, clk);

// input
	input [63:0] MEM_Result, EXE_MEM_Result;
	input [4:0] EXE_MEM_DstReg, EXE_MEM_FP_DstReg;
	input EXE_MEM_JmpandLink, MemtoRegIn, RegWriteIn, MEM_R_memtoReg, clk;

// output
	output reg [63:0] MEM_WB_MemData, MEM_WB_ALUData;
	output reg [4:0] MEM_WB_DstReg, MEM_WB_FP_DstReg;
	output reg MEM_WB_JmpandLink, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_R_memtoReg;
	
	always @(posedge clk)
		begin
			MEM_WB_MemData <= MEM_Result;
			MEM_WB_ALUData <= EXE_MEM_Result;
			MEM_WB_DstReg <= EXE_MEM_DstReg;
			MEM_WB_MemtoReg <= MemtoRegIn;
			MEM_WB_RegWrite <= RegWriteIn;
			MEM_WB_R_memtoReg <= MEM_R_memtoReg;
			MEM_WB_JmpandLink <= EXE_MEM_JmpandLink;
			MEM_WB_FP_DstReg <= EXE_MEM_FP_DstReg;
		end

endmodule
