module Forward_Mux (Op, ID_EXE_Reg, WB_Data, EXE_MEM_Result, forwardOp);

// input 
	input [63:0] ID_EXE_Reg, WB_Data, EXE_MEM_Result;
	input [1:0] forwardOp;
	
	
// output
	output reg [63:0] Op;
	
	always @(*)
		begin
			if (forwardOp == 0)
				Op <= ID_EXE_Reg;
			else if(forwardOp == 2'h1)
				Op <= WB_Data;
			else if(forwardOp == 2'h2)
				Op <= EXE_MEM_Result;
		end
		
endmodule

		
	