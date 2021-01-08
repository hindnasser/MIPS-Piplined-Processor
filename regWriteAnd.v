module regWriteAnd (RW, MEM_WB_LoHiWrite, MEM_WB_RegWrite);

// input 
	input MEM_WB_LoHiWrite, MEM_WB_RegWrite;
	
// output
	output reg RW;
	
	always @(*)
		RW <= (~(MEM_WB_LoHiWrite)) && MEM_WB_RegWrite;
	
endmodule
