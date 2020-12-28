module Rt_MUX (ID_Rt, ReadData2, FPReadData2, floatop);

// input 
	input [31:0] ReadData2, FPReadData2;
	input floatop;
	
// output 
	output reg [31:0] ID_Rt;
	
	always @(*)
		begin
			if(floatop == 0)
				ID_Rt <= ReadData2;
			else if (floatop == 1)
				ID_Rt <= FPReadData2;
		end
		
endmodule

		