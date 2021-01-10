module regWriteAnd (RW, MEM_WB_LoHiWrite, MEM_WB_RegWrite, MEM_memWrite);

// input 
	input MEM_WB_LoHiWrite, MEM_WB_RegWrite, MEM_memWrite;
	
// output
	output reg RW;
	
	always @(*)
		RW <= (~(MEM_WB_LoHiWrite)) && MEM_WB_RegWrite && (~(MEM_memWrite));
	
endmodule
