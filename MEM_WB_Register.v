module MEM_WB_Register (MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_Rd, MEM_WB_DstReg, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_Result, EXE_MEM_Result,
								EXE_MEM_Rd, EXE_MEM_DstReg, MemtoRegIn, RegWriteIn, clk);

// input
	input [31:0] MEM_Result, EXE_MEM_Result;
	input [4:0] EXE_MEM_Rd, EXE_MEM_DstReg;
	input MemtoRegIn, RegWriteIn, clk;
	//clk;

// output
	output reg [31:0] MEM_WB_MemData, MEM_WB_ALUData;
	output reg [4:0] MEM_WB_Rd, MEM_WB_DstReg;
	output reg MEM_WB_MemtoReg, MEM_WB_RegWrite;
	
	always @(posedge clk)
		begin
			MEM_WB_MemData <= MEM_Result;
			MEM_WB_ALUData <= EXE_MEM_Result;
			MEM_WB_Rd <= EXE_MEM_Rd;
			MEM_WB_DstReg <= EXE_MEM_DstReg;
			MEM_WB_MemtoReg <= MemtoRegIn;
			MEM_WB_RegWrite <= RegWriteIn;
		end

endmodule
