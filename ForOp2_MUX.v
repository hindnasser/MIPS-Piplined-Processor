module ForOp2_MUX (Op2, Op2Src, WB_Data, EXE_MEM_Result, forwardOp2);

// input 
	input [31:0] Op2Src, WB_Data, EXE_MEM_Result;
	input [1:0] forwardOp2;
	
// output
	output reg [31:0] Op2;
	
	always @(*)
		begin
			if (forwardOp2 == 00)
				Op2 <= Op2Src;
			else if(forwardOp2 == 01)
				Op2 <= WB_Data;
			else if(forwardOp2 == 10)
				Op2 <= EXE_MEM_Result;
		end
		
endmodule

		
	