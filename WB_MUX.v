module WB_MUX (WB_Data, MEM_WB_MemData, MEM_WB_ALUData, MemtoReg);

// input 
	input [31:0] MEM_WB_ALUData, MEM_WB_MemData;
	input MemtoReg;
	//clk;
	
// output
	output reg [31:0] WB_Data;
	
	always @(*)
		begin
			if(MemtoReg == 0)
				WB_Data <= MEM_WB_MemData;
			else if(MemtoReg == 1)
				WB_Data <= MEM_WB_ALUData;
		end
		
endmodule
