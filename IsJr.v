moodule IsJr (isJr, IF_ID_Func);

// input
	input [5:0] IF_ID_Func;
	
// output 
	output reg isJr;
	
	always @(*)
		begin
			if(IF_ID_Func == 6'h8)
				isJr <= 1;
			
			else 
				isJr <= 0;
		end
		
endmodule
