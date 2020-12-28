module EXE_MEM_Register (EXE_MEM_Result, EXE_MEM_BranchAddress, EXE_MEM_DstReg, EXE_MEM_Rd, EXE_MEM_Zero, EXE_MEM_Rt, EXE_MEM_BranchEqual, EXE_MEM_BranchnotEqual,
								 EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_BranchAddress, EXE_Result, EXE_DstReg, ID_EXE_Rd, ID_EXE_Rt,
								 EXE_Zero, BranchEqualIn, BranchnotEqualIn, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, clk);

// input
	input [31:0] EXE_BranchAddress, EXE_Result, ID_EXE_Rt;
	input [4:0] EXE_DstReg, ID_EXE_Rd;
	input EXE_Zero, BranchEqualIn, BranchnotEqualIn, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, clk;
//	clk;
	
// output
	output reg [31:0] EXE_MEM_Result, EXE_MEM_BranchAddress, EXE_MEM_Rt;
	output reg [4:0] EXE_MEM_DstReg, EXE_MEM_Rd;
	output reg EXE_MEM_Zero, EXE_MEM_BranchEqual, EXE_MEM_BranchnotEqual, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite;
	
	always @(posedge clk)
		begin
			EXE_MEM_Result <= EXE_Result;
			EXE_MEM_BranchAddress <= EXE_BranchAddress;
			EXE_MEM_DstReg <= EXE_DstReg;
			EXE_MEM_Rd <= ID_EXE_Rd;
			EXE_MEM_Zero <= EXE_Zero;
			EXE_MEM_BranchEqual <= BranchEqualIn;
			EXE_MEM_BranchnotEqual <= BranchnotEqualIn;
			EXE_MEM_MemRead <= MemReadIn;
			EXE_MEM_MemWrite <= MemWriteIn;
			EXE_MEM_MemtoReg <= MemtoRegIn;
			EXE_MEM_RegWrite <= RegWriteIn;
			EXE_MEM_Rt <= ID_EXE_Rt;			
		end
endmodule
