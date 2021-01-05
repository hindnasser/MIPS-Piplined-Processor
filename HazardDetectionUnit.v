module HazardDetectionUnit (Stall, PC_Write, IF_ID_Write, IF_ID_Rs, IF_ID_Rt, ID_EXE_MemRead, ID_EXE_RtReg);

// input
	input [4:0] IF_ID_Rs, IF_ID_Rt, ID_EXE_RtReg;
	input ID_EXE_MemRead;
	
// output
	output reg Stall, PC_Write, IF_ID_Write;
	
	initial 
		begin
			Stall <= 0;
			PC_Write <= 1;
			IF_ID_Write <= 1;
		end
		
	always @(*)
		begin
			if(ID_EXE_MemRead && ((ID_EXE_RtReg == IF_ID_Rs)|| (ID_EXE_RtReg == IF_ID_Rt)))
				begin
					Stall <= 1;
					PC_Write <= 0;
					IF_ID_Write <= 0;
				end
				
			else 
				begin
					Stall <= 0;
					PC_Write <= 1;
					IF_ID_Write <= 1;
				end
		end	

endmodule
