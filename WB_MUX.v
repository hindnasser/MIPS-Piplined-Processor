module WB_MUX (WB_Data, MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_MemtoReg);

// input 
	input [31:0] MEM_WB_ALUData, MEM_WB_MemData;
	input MEM_WB_MemtoReg;
	//clk;
	
// output
	output reg [31:0] WB_Data;
	
	always @(*)
		begin
			if(MEM_WB_MemtoReg == 0)
				WB_Data <= MEM_WB_ALUData;
			else if(MEM_WB_MemtoReg == 1)
				WB_Data <= MEM_WB_MemData;
		end
		
endmodule
