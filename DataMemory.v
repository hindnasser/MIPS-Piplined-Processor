module DataMemory (Mem_Result, EXE_MEM_Address, EXE_MEM_Rt, MemRead, MemWrite, clk);

//input
	input [31:0] EXE_MEM_Address, EXE_MEM_Rt;
	input MemRead, MemWrite, clk;
	
//output
	output reg [31:0] Mem_Result;
	
//actual address
	wire [9:0] address;
	
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
	assign address = EXE_MEM_Address [9:0];
	
// Write to the memory
	always @ (posedge clk && MemWrite) begin
//		if(MemWrite == 1)
//			begin
				mem[address] <= EXE_MEM_Rt[7:0];
				mem[address-1] <= EXE_MEM_Rt[15:8];
				mem[address-2] <= EXE_MEM_Rt [23:16];
				mem[address-3] <= EXE_MEM_Rt [31:17];
//			end 
end
		
// Read from the memory
	always @(negedge clk && MemRead)begin
//		if(MemRead == 1) 
//			begin
				Mem_Result = { mem[address-3], mem[address-2], mem[address-1], mem[address]};
//			end 
end
	
endmodule
