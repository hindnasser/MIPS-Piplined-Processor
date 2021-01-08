module BranchSignal_Mux (Src, Op1, Op2, Signal);

// input 
	input Op1, Op2, Signal;
	
// output
	output reg Src;
	
	always @(*)
		begin
			if(Signal)
				Src <= Op2;
			else 
				Src <= Op1;
		end
endmodule
