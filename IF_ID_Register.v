module IF_ID_Register(instructionOut, PCplus4Out, instructionIn, IF_Flush, clk, PCplus4);
//input
	input [31:0] instructionIn, PCplus4;
	input IF_Flush, clk;
		
//output
	output reg [31:0] instructionOut;
	output reg [31:0] PCplus4Out;
	
	always @(posedge clk) 
		begin
//To make a nop
			if(IF_Flush == 1)
				begin
					instructionOut = 32'b0 ;
					PCplus4Out = PCplus4;
				end
//To fetch the next instruction		
			else 
				begin
					instructionOut = instructionIn;
					PCplus4Out = PCplus4;
				end
		end
	
endmodule
