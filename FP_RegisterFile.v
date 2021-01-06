module FP_RegisterFile (FPReadData1, FPReadData2, clk, fmt, FPReadRegister1, FPReadRegister2, FPWriteRegister, FPWriteData, FPRegWrite);
//input
	input [4:0] fmt;
	input [4:0] FPReadRegister1, FPReadRegister2, FPWriteRegister;
	input clk, FPRegWrite;
	input [63:0] FPWriteData;
//output	
	output reg [63:0] FPReadData1, FPReadData2;
	
//initializing registers
	reg [31:0] registers_f[31:0];
	integer i;
	
	initial
		begin
			registers_f[0]=0;
			for(i=0;i<32;i=i+1) 
				begin
                  registers_f[i]<=i;
				end
				
		end

//writing data to the register
	always @(*)
		begin
			if(FPRegWrite && FPWriteRegister!=0)
				begin
					if(fmt == 5'h10)
						registers_f[FPWriteRegister] <= FPWriteData[31:0];
					else if(fmt == 5'h11)
					begin
						registers_f[FPWriteRegister] <= FPWriteData[31:0];
						registers_f[FPWriteRegister+1] <= FPWriteData[63:32];
					end
				end
		end
						
//reading the data
	always @(negedge clk)
		begin
			if(fmt == 5'h10)
				begin
                    FPReadData1[31:0] <= registers_f[FPReadRegister1];
                 	FPReadData1[63:32] <= 0;
                    FPReadData2[31:0] <= registers_f[FPReadRegister2];
                  	FPReadData2[63:32] <= 0;
				end
			else if(fmt == 5'h11)
				begin
					FPReadData1[31:0]  <= registers_f[FPReadRegister1];
					FPReadData1[63:32] <= registers_f[FPReadRegister1+1];
					FPReadData2[31:0]  <= registers_f[FPReadRegister2];
					FPReadData2[63:32] <= registers_f[FPReadRegister2+1];
				end
		end
			
endmodule
