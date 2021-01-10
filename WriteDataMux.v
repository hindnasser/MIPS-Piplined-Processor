module WriteDataMux (result, Data, FPData, FPLoadStore);

// input 
	input [63:0] Data, FPData;
	input FPLoadStore;
	
// output 
	output reg [63:0] result;
	
	initial
		result <= Data;
		
	always @(*)
		begin
			if(FPLoadStore == 1)
				result <= FPData;
			else 
				result <= Data;
		end
		
endmodule

	