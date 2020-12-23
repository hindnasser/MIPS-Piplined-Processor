module Rt_MUX (ID_Rt, ReadRegister2, FPReadRegister2, floatop, clk);

// input 
	input [31:0] ReadRegister2, FPReadRegister2;
	input floatop, clk;
	
// output 
	output reg [31:0] ID_Rt;
	
	always @(posedge clk)
		begin
			if(floatop == 0)
				ID_Rt = ReadRegister2;
			else if (floatop == 1)
				ID_Rt = FPReadRegister2;
		end
		
endmodule

		