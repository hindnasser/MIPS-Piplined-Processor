module RegisterFile(ReadData1, ReadData2, clk, IF_ID_Rs, IF_ID_Rt, WB_DstReg, WB_Data, RegWrite);
//input
	input [4:0] IF_ID_Rs, IF_ID_Rt, WB_DstReg;
	input clk, RegWrite;
	input [31:0] WB_Data;
//output	
	output reg [31:0] ReadData1, ReadData2;
	
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
			if(RegWrite && WB_DstReg!=0)
				begin
					registers_i[WB_DstReg] <= WB_Data;
				end
		end
						
//reading the data
	always @(negedge clk)
		begin
			ReadData1 = registers_i[IF_ID_Rs];
			ReadData2 = registers_i[IF_ID_Rt];
		end
			
endmodule
