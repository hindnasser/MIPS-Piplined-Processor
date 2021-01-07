module ID_EXE_Register (ID_EXE_Func, ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg, ID_EXE_ExtendedImm, ID_EXE_Shamt, ID_EXE_RegDst, ID_EXE_RegWrite, 
                        ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual, ID_EXE_ALUop,
								ID_EXE_ALUSrc, IF_ID_Shamt, IF_ID_Func, IF_ID_PCplus4, IF_ID_Rs, IF_ID_Rt, ID_Rs, ID_Rt, IF_ID_Rd, ExtendedImm, RegDstIn, RegWriteIn, MemtoRegIn, 
								JmpandLinkIn, MemReadIn, MemWriteIn, BranchEqualIn, BranchnotEqualIn, ALUopIn, ALUSrcIn, clk);
//input
	input RegDstIn, RegWriteIn, MemtoRegIn, JmpandLinkIn, MemReadIn, MemWriteIn, BranchEqualIn, BranchnotEqualIn, ALUSrcIn,	clk;
	input [3:0] ALUopIn;
	input [31:0] ID_Rs, ID_Rt, ExtendedImm, IF_ID_PCplus4;
	input [5:0] IF_ID_Func;
	input [4:0] IF_ID_Shamt, IF_ID_Rd, IF_ID_Rs, IF_ID_Rt;
	
//output
	output reg ID_EXE_RegDst, ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual,
              ID_EXE_ALUSrc;
	output reg [3:0] ID_EXE_ALUop;
	output reg [31:0] ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_ExtendedImm;
	output reg [5:0] ID_EXE_Func;
	output reg [4:0] ID_EXE_Shamt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg;
	
	
	always @(posedge clk) 
		begin
			ID_EXE_RegDst <= RegDstIn;
			ID_EXE_MemtoReg <= MemtoRegIn;
			ID_EXE_JmpandLink <= JmpandLinkIn;
			ID_EXE_BranchEqual <= BranchEqualIn;
			ID_EXE_BranchnotEqual <= BranchnotEqualIn;
			ID_EXE_ALUSrc <= ALUSrcIn;
			ID_EXE_ALUop <= ALUopIn;
			ID_EXE_PCplus4 <= IF_ID_PCplus4;
			ID_EXE_Rs <= ID_Rs;
			ID_EXE_Rt <= ID_Rt;
			ID_EXE_ExtendedImm <= ExtendedImm;
			ID_EXE_Rd <= IF_ID_Rd;
			ID_EXE_Func <= IF_ID_Func;
			ID_EXE_Shamt <= IF_ID_Shamt;
			ID_EXE_RtReg <= IF_ID_Rt;
			ID_EXE_RsReg <= IF_ID_Rs;
			ID_EXE_MemRead <= MemReadIn;
			ID_EXE_MemWrite <= MemWriteIn;
			ID_EXE_RegWrite <= RegWriteIn;
			
				

		end
		
endmodule
