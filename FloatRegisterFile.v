module FloatRegisterFile (FPReadData1, FPReadData2, clk, FPReadRegister1, FPReadRegister2, FPWriteRegister, FPWriteData, FPRegWrite);
//input
	input [4:0] FPReadRegister1, FPReadRegister2, FPWriteRegister;
	input clk, FPRegWrite;
	input [31:0] FPWriteData;
//output	
	output reg [31:0] FPReadData1, FPReadData2;
	
//initializing registers
	reg [31:0] registers_f[31:0];
	integer i;
	
	initial
		begin
			registers_f[0]=0;
			for(i=0;i<32;i=i+1) 
				begin
					registers_f[i]=i;
				end
				
		end
//writing data to the register
			always @(posedge clk)
				begin
					if(FPRegWrite && FPWriteRegister!=0)
						begin
							registers_f[FPWriteRegister] <= FPWriteData;
						end
				end
						
//reading the data
	always @(negedge clk)
		begin
			FPReadData1 <= registers_f[FPReadRegister1];
			FPReadData2 <= registers_f[FPReadRegister2];
		end
			
endmodule
