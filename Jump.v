module Jumpj( JumpAddress, JumpShiftedAddress , PCplus4);

// input
	input [31:0] JumpShiftedAddress, PCplus4;
	
// output
	output reg [31:0] JumpAddress;
	
	always @(*)
		begin
			JumpAddress <= {PCplus4[31:28], JumpShiftedAddress[27:0]};
		end
		
endmodule
 
