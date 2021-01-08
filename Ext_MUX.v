module Ext_MUX (ExtendedImm, SignedImmediate, UnsignedImmediate, Issigned);

// input 
	input [63:0] SignedImmediate, UnsignedImmediate;
	input Issigned;
	
// output
	output reg [63:0] ExtendedImm;
	
	always @(*)
		begin
			if(Issigned == 0)
				ExtendedImm <= UnsignedImmediate;
			else 
				ExtendedImm <= SignedImmediate;
		end
endmodule

		