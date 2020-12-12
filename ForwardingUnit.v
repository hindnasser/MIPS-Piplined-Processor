module ForwardingUnit (forwardOp1, forwardOp2, ID_EXE_rs, ID_EXE_rt, EXE_MEM_rd, EXE_MEM_RegWrite, MEM_WB_rd, MEM_WB_RegWrite, clk);

//input
	input [31:0] ID_EXE_rs, ID_EXE_rt, EXE_MEM_rd, MEM_WB_rd;
	input EXE_MEM_RegWrite, MEM_WB_RegWrite, clk;
	
//output
	output reg [1:0] forwardOp1, forwardOp2;
	
	reg forward1, forward2;
	initial
		begin
			forward1 <= 0;
			forward2 <= 0;
		end
	always @(posedge clk) begin
		
//checking for ALU-ALU forwarding conditions
		if(EXE_MEM_RegWrite && (EXE_MEM_rd != 0) &&(EXE_MEM_rd == ID_EXE_rs)) begin
			forwardOp1 <= 10; forward1 <= 1; end
			
		if(EXE_MEM_RegWrite && (EXE_MEM_rd != 0) &&(EXE_MEM_rd == ID_EXE_rt)) begin
			forwardOp2 <= 10; forward2 <= 1; end

//checking for MEM-ALU forwarding conditions
		if(MEM_WB_RegWrite && (MEM_WB_rd != 0) &&
		~(EXE_MEM_RegWrite && (EXE_MEM_rd != 0) &&(EXE_MEM_rd == ID_EXE_rs))&& MEM_WB_rd == ID_EXE_rs) begin
			forwardOp1 <= 01; forward1 <= 1; end
			
		if(MEM_WB_RegWrite && (MEM_WB_rd != 0) &&
		~(EXE_MEM_RegWrite && (EXE_MEM_rd != 0) &&(EXE_MEM_rd == ID_EXE_rt)) && MEM_WB_rd == ID_EXE_rt) begin
			forwardOp1 <= 01; forward2 <= 1; end
			
		if(forward1 == 0) forwardOp1 <= 00;
		if(forward2 == 0) forwardOp2 <= 00;
	end

endmodule

module clock(clk);
	output clk;
	reg clk;
	initial begin
		clk <= 0;
	end
	always
		begin
		#50 
		clk <= ~clk;	
	end
endmodule

module test;
reg [31:0] ID_EXE_rs, ID_EXE_rt, EXE_MEM_rd, MEM_WB_rd;
reg EXE_MEM_RegWrite, MEM_WB_RegWrite;
wire clk;
wire [1:0] forwardOp1, forwardOp2;


clock c1(clk);
ForwardingUnit rf(forwardOp1, forwardOp2, ID_EXE_rs, ID_EXE_rt, EXE_MEM_rd, EXE_MEM_RegWrite, MEM_WB_rd, MEM_WB_RegWrite, clk);

initial
begin
ID_EXE_rs<= 5 ; ID_EXE_rt<= 5 ; EXE_MEM_rd<= 5; MEM_WB_rd<= 5; EXE_MEM_RegWrite<= 1 ; MEM_WB_RegWrite<= 0 ;
#150 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);

ID_EXE_rs<= 5; ID_EXE_rt<= 5; EXE_MEM_rd<= 6 ; MEM_WB_rd<= 5 ; EXE_MEM_RegWrite<=0 ; MEM_WB_RegWrite<=1 ;
#200 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);

ID_EXE_rs<= 6 ; ID_EXE_rt<= 7 ; EXE_MEM_rd<= 9 ; MEM_WB_rd<= 10 ; EXE_MEM_RegWrite<= 1 ; MEM_WB_RegWrite<= 1 ;
#250 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);

ID_EXE_rs<= 6; ID_EXE_rt<= 6 ; EXE_MEM_rd<= 6; MEM_WB_rd<= 6 ; EXE_MEM_RegWrite<= 1; MEM_WB_RegWrite<= 1 ;
#300 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);

ID_EXE_rs<= 7; ID_EXE_rt<= 7 ; EXE_MEM_rd<= 9 ; MEM_WB_rd<= 7; EXE_MEM_RegWrite<= 0; MEM_WB_RegWrite<= 1 ;
#350 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);

ID_EXE_rs<= 8; ID_EXE_rt<= 4; EXE_MEM_rd<=4 ; MEM_WB_rd<=8 ; EXE_MEM_RegWrite<= 1 ; MEM_WB_RegWrite<= 1 ;
#400 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);
end
endmodule