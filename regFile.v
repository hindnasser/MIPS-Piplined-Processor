module regFile(ReadData1, ReadData2, clk, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite);
//input
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input clk, RegWrite;
	input [31:0] WriteData;
//output	
	output reg [31:0] ReadData1, ReadData2;
	
//initializing registers
	reg [31:0] registers_i[31:0];	
	integer i;
	
	initial
		begin
			registers_i[0]=0;
			
			for(i=0;i<32;i=i+1) 
				begin
					registers_i[i]=i;
				end
				registers_i[3]=0;
		end
//writing data to the register
			always @(posedge clk)
				begin
					if(RegWrite && WriteRegister!=0)
						begin
							registers_i[WriteRegister] <= WriteData;
						end
				end
						
//reading the data
	always @(negedge clk)
		begin
			ReadData1 <= registers_i[ReadRegister1];
			ReadData2 <= registers_i[ReadRegister2];
		end
			
endmodule