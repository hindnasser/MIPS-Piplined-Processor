module EXE_MEM_Register (EXE_MEM_Result, EXE_MEM_BranchAddress, EXE_MEM_DstReg, EXE_MEM_Rd, EXE_MEM_Zero, BranchEqualOut, BranchnotEqualOut, MemReadOut,
		 MemWriteOut, MemtoRegOut, RegWriteOut, EXE_BranchAddress, EXE_Result, EXE_DstReg, ID_EXE_Rd, EXE_Zero, BranchEqualIn, BranchnotEqualIn, 
		 MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, clk);

// input
	input [31:0] EXE_BranchAddress, EXE_Result;
	input [4:0] EXE_DstReg, ID_EXE_Rd;
	input EXE_Zero, BranchEqualIn, BranchnotEqualIn, MemReadIn, MemWriteIn, MemtoRegIn, RegWriteIn, clk;
	
// output
	output reg [31:0] EXE_MEM_Result, EXE_MEM_BranchAddress;
	output reg [4:0] EXE_MEM_DstReg, EXE_MEM_Rd;
	output reg EXE_MEM_Zero, BranchEqualOut, BranchnotEqualOut, MemReadOut, MemWriteOut, MemtoRegOut, RegWriteOut;
	
	always @(posedge clk)
		begin
			EXE_MEM_Result = EXE_Result;
			EXE_MEM_BranchAddress = EXE_BranchAddress;
			EXE_MEM_DstReg = EXE_DstReg;
			EXE_MEM_Rd = ID_EXE_Rd;
			EXE_MEM_Zero = EXE_Zero;
			BranchEqualOut = BranchEqualIn;
			BranchnotEqualOut = BranchnotEqualIn;
			MemReadOut = MemReadIn;
			MemWriteOut = MemWriteIn;
			MemtoRegOut = MemtoRegIn;
			RegWriteOut = RegWriteIn;
		end
endmodule
