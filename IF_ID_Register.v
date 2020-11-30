module IF_ID_Register(OpCode, PCplus4Out, instruction, IF_Flush, clk, PCplus4);
//input
	input [31:0] instruction, PCplus4;
	input IF_Flush, clk;
		
//output
	output reg [5:0] OpCode;
	inout [31:0] PCplus4Out;
	
	always @(posedge clk) 
		begin
//To make a nop
			if(IF_Flush == 1)
				begin
					OpCode = 6'h0;
					PCplus4Out = PCplus4;
				end
//To fetch the next instruction		
			else 
				begin
					OpCode = instruction [31:26];
					PCplus4Out = PCplus4;
				end
		end
	
endmodule

