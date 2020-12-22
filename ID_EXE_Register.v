module ID_EXE_Register (ID_EXE_Func, ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_Rd, ID_EXE_ExtendedImm, ID_EXE_Shamt, RegDstOut, RegWriteOut, MemtoRegOut, 
                        JmpandLinkOut, MemReadOut, MemWriteOut, BranchEqualOut, BranchnotEqualOut, ALUopOut, ALUSrcOut, IF_ID_Shamt, IF_ID_Func, IF_ID_PCplus4, 
								ID_Rs, ID_Rt, IF_ID_Rd, ExtendedImm, RegDstIn, RegWriteIn, MemtoRegIn, JmpandLinkIn, MemReadIn, 
								MemWriteIn, BranchEqualIn, BranchnotEqualIn, ALUopIn, ALUSrcIn, clk);
//input
	input RegDstIn, RegWriteIn, MemtoRegIn, JmpandLinkIn, MemReadIn, MemWriteIn, BranchEqualIn, BranchnotEqualIn, ALUSrcIn, clk;
	input [3:0] ALUopIn;
	input [31:0] ID_Rs, ID_Rt,IF_ID_Rd, ExtendedImm, IF_ID_PCplus4;
	input [5:0] IF_ID_Func;
	input [4:0] IF_ID_Shamt;
	
//output
	output reg RegDstOut, RegWriteOut, MemtoRegOut, JmpandLinkOut, MemReadOut, MemWriteOut, BranchEqualOut, BranchnotEqualOut, ALUSrcOut;
	output reg [3:0] ALUopOut;
	output reg [31:0] ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_Rd, ID_EXE_ExtendedImm;
	output reg [5:0] ID_EXE_Func;
	output reg [4:0] ID_EXE_Shamt;
	
	
	always @(posedge clk) 
		begin
			RegDstOut = RegDstIn;
			RegWriteOut = RegWriteIn;
			MemtoRegOut = MemtoRegIn;
			JmpandLinkOut = JmpandLinkIn;
			MemReadOut = MemReadIn;
			MemWriteOut = MemWriteIn;
			BranchEqualOut = BranchEqualIn;
			BranchnotEqualOut = BranchEqualIn;
			ALUSrcOut = ALUSrcIn;
			ALUopOut = ALUopIn;
			ID_EXE_PCplus4 = IF_ID_PCplus4;
			ID_EXE_Rs = ID_Rs;
			ID_EXE_Rt = ID_Rt;
			ID_EXE_ExtendedImm = ExtendedImm;
			ID_EXE_Rd = IF_ID_Rd;
			ID_EXE_Func = IF_ID_Func;
			ID_EXE_Shamt = IF_ID_Shamt;
		end
		
endmodule
