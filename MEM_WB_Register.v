module MEM_WB_Register (MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_Rd, MEM_WB_DstReg, MemtoRegOut, RegWriteOut, MEM_Result, EXE_MEM_Result,
		 EXE_MEM_Rd, EXE_MEM_DstReg, MemtoRegIn, RegWriteIn, clk);

// input
	input [31:0] MEM_Result, EXE_MEM_Result;
	input [4:0] EXE_MEM_Rd, EXE_MEM_DstReg;
	input MemtoRegIn, RegWriteIn, clk;

// output
	output reg [31:0] MEM_WB_MemData, MEM_WB_ALUData;
	output reg [4:0] MEM_WB_Rd, MEM_WB_DstReg;
	output reg MemtoRegOut, RegWriteOut;
	
	always @(negedge clk)
		begin
			MEM_WB_MemData = MEM_Result;
			MEM_WB_ALUData = EXE_MEM_Result;
			MEM_WB_Rd = EXE_MEM_Rd;
			MEM_WB_DstReg = EXE_MEM_DstReg;
			MemtoRegOut = MemtoRegIn;
			RegWriteOut = RegWriteIn;
		end

endmodule
