module ID_EXE_Register (ID_EXE_Fd, ID_EXE_Ft, ID_EXE_fmt, ID_EXE_Func, ID_EXE_PCplus4, ID_EXE_SregData, ID_EXE_TregData, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg, 
								ID_EXE_ExtendedImm, ID_EXE_Shamt, ID_EXE_RegDst, ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite,
								ID_EXE_BranchEqual, ID_EXE_BranchnotEqual, ID_EXE_BranchFPTrue, ID_EXE_BranchFPFalse, ID_EXE_ALUop, ID_EXE_ALUSrc, ID_EXE_Byte, ID_EXE_double,
								doubleIn, Byte, IF_ID_Shamt, IF_ID_Func, IF_ID_PCplus4, IF_ID_Rs, IF_ID_Rt, ID_SregData, ID_TregData, IF_ID_Rd, IF_ID_Fd, IF_ID_Ft, IF_ID_fmt,
								ExtendedImm, RegDstIn, RegWriteIn, MemtoRegIn, JmpandLinkIn, MemReadIn, MemWriteIn, BranchEqualIn, BranchnotEqualIn, BranchFPTrueIn, 
								BranchFPFalseIn, ALUopIn, ALUSrcIn, clk);
								
//input
	input Byte, RegDstIn, RegWriteIn, MemtoRegIn, JmpandLinkIn, MemReadIn, MemWriteIn, BranchEqualIn, BranchnotEqualIn, ALUSrcIn, BranchFPTrueIn, BranchFPFalseIn,
			doubleIn, clk;
	input [3:0] ALUopIn;
	input [63:0] ID_SregData, ID_TregData, ExtendedImm;
	input [31:0] IF_ID_PCplus4;
	input [5:0] IF_ID_Func;
	input [4:0] IF_ID_Shamt, IF_ID_Rd, IF_ID_Rs, IF_ID_Rt, IF_ID_Fd, IF_ID_Ft, IF_ID_fmt;
	
//output
	output reg ID_EXE_Byte, ID_EXE_RegDst, ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual,
              ID_EXE_ALUSrc, ID_EXE_BranchFPFalse, ID_EXE_BranchFPTrue, ID_EXE_double;
	output reg [3:0] ID_EXE_ALUop;
	output reg [63:0] ID_EXE_SregData, ID_EXE_TregData, ID_EXE_ExtendedImm, ID_EXE_PCplus4;
	output reg [5:0] ID_EXE_Func;
	output reg [4:0] ID_EXE_Shamt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg, ID_EXE_Fd, ID_EXE_Ft, ID_EXE_fmt;
	
	
	always @(posedge clk) 
		begin
			ID_EXE_RegDst <= RegDstIn;
			ID_EXE_MemtoReg <= MemtoRegIn;
			ID_EXE_JmpandLink <= JmpandLinkIn;
			ID_EXE_BranchEqual <= BranchEqualIn;
			ID_EXE_BranchnotEqual <= BranchnotEqualIn;
			ID_EXE_ALUSrc <= ALUSrcIn;
			ID_EXE_ALUop <= ALUopIn;
			ID_EXE_PCplus4 <= {32'b0, IF_ID_PCplus4};
			ID_EXE_SregData <= ID_SregData;
			ID_EXE_TregData <= ID_TregData;
			ID_EXE_ExtendedImm <= ExtendedImm;
			ID_EXE_Rd <= IF_ID_Rd;
			ID_EXE_Func <= IF_ID_Func;
			ID_EXE_Shamt <= IF_ID_Shamt;
			ID_EXE_RtReg <= IF_ID_Rt;
			ID_EXE_RsReg <= IF_ID_Rs;
			ID_EXE_MemRead <= MemReadIn;
			ID_EXE_MemWrite <= MemWriteIn;
			ID_EXE_RegWrite <= RegWriteIn;
			ID_EXE_Byte <= Byte;
			ID_EXE_Fd <= IF_ID_Fd;
			ID_EXE_Ft <= IF_ID_Ft;
			ID_EXE_fmt <= IF_ID_fmt;
			ID_EXE_BranchFPFalse <= BranchFPFalseIn;
			ID_EXE_BranchFPTrue <= BranchFPTrueIn;
			ID_EXE_double <= doubleIn;

		end
		
endmodule
