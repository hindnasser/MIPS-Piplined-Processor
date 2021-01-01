module ForOp1_MUX (Op1, ID_EXE_Rs, WB_Data, EXE_MEM_Result, forwardOp1);

// input 
	input [31:0] ID_EXE_Rs, WB_Data, EXE_MEM_Result;
	input [1:0] forwardOp1;
	
	
// output
	output reg [31:0] Op1;
	
	always @(*)
		begin
			if (forwardOp1 == 0)
				Op1 <= ID_EXE_Rs;
			else if(forwardOp1 == 2'h1)
				Op1 <= WB_Data;
			else if(forwardOp1 == 2'h2)
				Op1 <= EXE_MEM_Result;
		end
		
endmodule

		
	