module readData_Mux (RegData, ReadData, FPReadData, floatop);

// input 
	input [63:0] ReadData, FPReadData;
	input floatop;
	
// output 
	output reg [63:0] RegData;
	
	always @(*)
		begin
			if(floatop == 0)
				RegData <= ReadData;
			else if (floatop == 1)
				RegData <= FPReadData;
		end
		
endmodule

		