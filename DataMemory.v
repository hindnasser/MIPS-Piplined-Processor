
module DataMemory (MemReadData, MemAddress, MemWriteData, MemRead, MemWrite, clk);

//input
	input [31:0] MemAddress, MemWriteData;
	input MemRead, MemWrite, clk;
	
//output
	output reg [31:0] MemReadData;
	
//actual address
	wire [9:0] address;
	
//Intitialization for the memory 
	reg [7:0] mem [1023:0]; // building a 1k memory //
	integer i;
	
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
	assign address = MemAddress [9:0];
	
// Write to the memory
	always @ (posedge clk && MemWrite) begin
//		if(MemWrite == 1)
//			begin
				mem[address] <= MemWriteData[7:0];
				mem[address-1] <= MemWriteData[15:8];
				mem[address-2] <= MemWriteData [23:16];
				mem[address-3] <= MemWriteData [31:17];
//			end 
end
		
// Read from the memory
	always @(negedge clk && MemRead)begin
//		if(MemRead == 1) 
//			begin
				MemReadData = { mem[address-3], mem[address-2], mem[address-1], mem[address]};
//			end 
end
	
endmodule

module clock(clk);
	output clk;
	reg clk;
	initial begin
		clk <= 0;
	end
	always
		begin
		#50 
		clk <= ~clk;	
	end
endmodule

module test;
reg [31:0] add , data;
wire [31:0] memread;
reg memreads,memwrite;
wire clk;


clock c1(clk);
DataMemory rf(memread, add, data, memreads, memwrite, clk);

initial
begin
add <= 30 ; data = 100 ; memreads = 1 ; memwrite = 0 ; 
#49 $display("ADD= %b ",add," Data = %b",data, " dataread = %b ",memread);

add <= 30 ; data = 6 ; memreads = 1 ; memwrite = 1 ; 
#50 $display("ADD= %b ",add," Data = %b",data, " dataread = %b ",memread);

add <= 7 ; data = 100 ; memreads = 1 ; memwrite = 1 ; 
#75 $display("ADD= %b ",add," Data = %b",data, " dataread = %b ",memread);

add <= 7 ; data = 200 ; memreads = 1 ; memwrite = 1 ; 
#150 $display("ADD= %b ",add," Data = %b",data, " dataread = %b ",memread);

add <= 7 ; data = 200 ; memreads = 1 ; memwrite = 1 ; 
#160 $display("ADD= %b ",add," Data = %b",data, " dataread = %b ",memread);

add <= 30 ; data = 200 ; memreads = 1 ; memwrite = 0 ; 
#250 $display("ADD= %b ",add," Data = %b",data, " dataread = %b ",memread);

add <= 30 ; data = 450 ; memreads = 1 ; memwrite = 1 ; 
#251 $display("ADD= %b ",add," Data = %b",data, " dataread = %b ",memread);

end
endmodule

