module IF_ID_Register(OpCode, PCplus4, instruction, IF_Flush, clk);
//input
	input [31:0] instruction;
	input IF_Flush, clk;
	
//output
	output reg [5:0] OpCode;

//input/output
	inout [31:0] PCplus4;
	
	always @(posedge clk) 
		begin
//To make a nop
			if(IF_Flush == 1)
				begin
					OpCode = 6'h0;
				end
//To fetch the next instruction		
			else 
				begin
					OpCode = instruction [31:26];
				end
		end
	
endmodule

