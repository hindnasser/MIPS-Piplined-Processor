module Ext_MUX (ExtendedImm, SignedImmediate, UnsignedImmediate, Issigned);

// input 
	input [31:0] SignedImmediate, UnsignedImmediate;
	input Issigned;
	
// output
	output reg [31:0] ExtendedImm;
	
	always @(*)
		begin
			if(Issigned == 0)
				ExtendedImm <= UnsignedImmediate;
			else if(Issigned == 1)
				ExtendedImm <= SignedImmediate;
		end
endmodule

		