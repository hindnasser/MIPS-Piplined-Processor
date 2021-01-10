module HazardDetectionUnit (Stall, PC_Write, IF_ID_Write, IF_ID_Rs, IF_ID_Rt, IF_ID_Func, IF_ID_Rd, ID_EXE_MemRead, EXE_ReadfromMem, ID_EXE_RtReg,
									 ID_EXE_Rd, PC_Src, Jump, JmpandLink, isJr);

// input
	input [4:0] IF_ID_Rs, IF_ID_Rt, ID_EXE_RtReg, ID_EXE_Rd;
	input ID_EXE_MemRead, PC_Src, Jump, JmpandLink, isJr, EXE_ReadfromMem, IF_ID_Rd;
	input [5:0] IF_ID_Func;
	
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
			if(PC_Src)
				begin
					Stall <= 1;
					PC_Write <= 1;
					IF_ID_Write <= 0;
				end
			else if(Jump || JmpandLink || isJr)
				begin
					Stall <= 0;
					PC_Write <= 1;
					IF_ID_Write <= 0;
				end
				
			else if(ID_EXE_MemRead && ((ID_EXE_RtReg == IF_ID_Rs)|| (ID_EXE_RtReg == IF_ID_Rt)))
				begin
					Stall <= 1;
					PC_Write <= 0;
					IF_ID_Write <= 0;
				end
				
			// if any instruction or store word new is after load word new
			else if((EXE_ReadfromMem && ((ID_EXE_RtReg == IF_ID_Rs)|| (ID_EXE_RtReg == IF_ID_Rt))) || (EXE_ReadfromMem &&((ID_EXE_RtReg == IF_ID_Rd) || ID_EXE_RtReg == IF_ID_Rs) && (IF_ID_Func == 6'h13)))
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
