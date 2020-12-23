module Rs_MUX (ID_Rs, ReadRegister1, FPReadRegister1, floatop, clk);

// input 
	input [31:0] ReadRegister1, FPReadRegister1;
	input floatop, clk;
	
// output 
	output reg [31:0] ID_Rs;
	
	always @(posedge clk)
		begin
			if(floatop == 0)
				ID_Rs = ReadRegister1;
			else if (floatop == 1)
				ID_Rs = FPReadRegister1;
		end
		
endmodule

		