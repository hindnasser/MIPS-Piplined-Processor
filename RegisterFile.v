module RegisterFile(ReadData1, ReadData2, clk, IF_ID_Rs, IF_ID_Rt, WB_DstReg, WB_Data, RegWrite, MEM_WB_JmpandLink);
//input
	input [4:0] IF_ID_Rs, IF_ID_Rt, WB_DstReg;
	input clk, RegWrite, MEM_WB_JmpandLink;
	input [63:0] WB_Data;
//output	
	output reg [63:0] ReadData1, ReadData2;
	
//initializing registers
	reg [31:0] registers_i[31:0];	
	integer i;
	
	initial
		begin
			for(i=0;i<32;i=i+1) 
				begin
					registers_i[i]=i;
				end
		end
		
//writing data to the register
	always @(*)
		begin
		
			if(RegWrite && MEM_WB_JmpandLink)
				registers_i[31] <= WB_Data[31:0];
				
			else if(RegWrite && WB_DstReg!=0)
				begin
					registers_i[WB_DstReg] <= WB_Data[31:0];
				end
		end
						
//reading the data
	always @(negedge clk)
		begin
			ReadData1 <= registers_i[IF_ID_Rs];
			ReadData1[63:32] <= 32'b0;
			ReadData2 <= registers_i[IF_ID_Rt];
		   ReadData2[63:32] <= 32'b0;
		end
			
endmodule
