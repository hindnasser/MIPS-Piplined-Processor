module Jump_Mux (PCSrc2, JumpAddress, PCSrc, Jump);

// input 
	input [31:0] JumpAddress, PCSrc;
	input Jump;
	
// output
	output reg [31:0] PCSrc2;

	always @(*)
		begin
			if(Jump == 1) 
				PCSrc2 <= JumpAddress;
		   else
				PCSrc2 <= PCSrc;
		end
	
endmodule
	