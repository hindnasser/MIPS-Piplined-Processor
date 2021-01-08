module IsJr (isJr, IF_ID_Func, IF_ID_Opcode);

// input
	input [5:0] IF_ID_Func, IF_ID_Opcode;
	
	
// output 
	output reg isJr;
	
	initial 
		begin
		isJr <= 0;
		end
		
	always @(*)
		begin
			if(IF_ID_Func == 6'h8 && IF_ID_Opcode == 6'h3)
				isJr <= 1;
			
			else 
				isJr <= 0;
		end
		
endmodule
