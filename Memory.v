module DataMemory (MEM_Result, EXE_MEM_Result, EXE_MEM_TReg, MemRead, MemWrite, EXE_MEM_Byte, double, clk);

//input
	input [63:0] EXE_MEM_Result, EXE_MEM_TReg;
	input MemRead, MemWrite, EXE_MEM_Byte, double, clk;
	
//output
	output reg [63:0] MEM_Result;
	
	
//Intitialization for the memory 
	reg [7:0] mem [1023:0]; // building a 1k memory //
	integer i;
	// mem[3] 	= 4
	// mem[7] 	= 8
	// mem[11] 	= 12
	// mem[15] 	= 16
	// mem[19] 	= 20
	// mem[23] 	= 24
	// mem[27] 	= 28
	// mem[31] 	= 32
	initial
		begin
			for(i = 0; i <1024; i = i + 1)
				begin
					mem[i] <=  0;
					if((i+1)%4 == 0)
					mem[i] <= i+1;
				end
		end
	
// assigning a value to actual address
	wire [9:0] address;
	assign address = EXE_MEM_Result [9:0];
	
// Write to the memory
	always @ (*) begin
		if(MemWrite == 1)
			begin
				if(EXE_MEM_Byte)
					mem[address+3] <= EXE_MEM_TReg[7:0];
				
				else if (double)
					begin
						mem[address+3] <= EXE_MEM_TReg[7:0];
						mem[address+2] <= EXE_MEM_TReg[15:8];
						mem[address+1] <= EXE_MEM_TReg [23:16];
						mem[address] <= EXE_MEM_TReg [31:24];
						mem[address+7] <= EXE_MEM_TReg[39:32];
						mem[address+6] <= EXE_MEM_TReg[47:40];
						mem[address+5] <= EXE_MEM_TReg[55:48];
						mem[address+4] <= EXE_MEM_TReg[63:56];
					end
					
				else
					begin
						mem[address+3] <= EXE_MEM_TReg[7:0];
						mem[address+2] <= EXE_MEM_TReg[15:8];
						mem[address+1] <= EXE_MEM_TReg [23:16];
						mem[address] <= EXE_MEM_TReg [31:24];
					end
			end 
end
		
// Read from the memory
	always @(negedge clk)begin
		if(MemRead == 1) 
			begin
				if(EXE_MEM_Byte)
					MEM_Result <= {56'b0, mem[address+3]};
				else if(double)
					MEM_Result <= {mem[address+4], mem[address+5],mem[address+6], mem[address+7], mem[address], mem[address+1], mem[address+2], mem[address+3]};
				else
					MEM_Result <= {32'b0, mem[address], mem[address+1], mem[address+2], mem[address+3]};
			end 
end
	
endmodule



