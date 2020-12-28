module Rs_MUX (ID_Rs, ReadData1, FPReadData1, floatop);

// input 
	input [31:0] ReadData1, FPReadData1;
	input floatop;
	
// output 
	output reg [31:0] ID_Rs;
	
	always @(*)
		begin
			if(floatop == 0)
				ID_Rs <= ReadData1;
			else if (floatop == 1)
				ID_Rs <= FPReadData1;
		end
		
endmodule

		