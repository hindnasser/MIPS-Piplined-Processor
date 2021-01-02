module ForwardingUnit (forwardOp1, forwardOp2, ID_EXE_Rs, ID_EXE_Rt, EXE_MEM_DstReg, EXE_MEM_RegWrite, MEM_WB_DstReg, MEM_WB_RegWrite);

//input
	input [4:0] ID_EXE_Rs, ID_EXE_Rt, EXE_MEM_DstReg, MEM_WB_DstReg;
	input EXE_MEM_RegWrite, MEM_WB_RegWrite;
	
//output
	output reg [1:0] forwardOp1, forwardOp2;
	
	
	always @(*) begin
		
// ALU-ALU forwarding conditions for Op1
		if(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rs)) begin
			forwardOp1 <= 2'b10; end
			
// MEM-ALU forwarding conditions for Op1			
		else if(MEM_WB_RegWrite && (MEM_WB_DstReg != 4'b0) &&
		~(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rs))&& MEM_WB_DstReg == ID_EXE_Rs) begin
			forwardOp1 <= 2'b01; end
		
		else forwardOp1 <= 2'b00;
			
		
// ALU-ALU forwarding conditions for Op2
		if(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rt)) begin
			forwardOp2 <= 2'b10;  end
			
// MEM-ALU forwarding conditions for Op2
		else if(MEM_WB_RegWrite && (MEM_WB_DstReg != 4'b0) &&
		~(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rt)) && MEM_WB_DstReg == ID_EXE_Rt) begin
			forwardOp2 <= 2'b01;  end
			
		else forwardOp2 <= 2'b00;
			
	end

endmodule

//module clock(clk);
//	output clk;
//	reg clk;
//	initial begin
//		clk <= 0;
//	end
//	always
//		begin
//		#50 
//		clk <= ~clk;	
//	end
//endmodule

//module test;
//reg [31:0] ID_EXE_Rs, ID_EXE_Rt, EXE_MEM_DstReg, MEM_WB_DstReg;
//reg EXE_MEM_RegWrite, MEM_WB_RegWrite;
//wire clk;
//wire [1:0] forwardOp1, forwardOp2;
//
//
//clock c1(clk);
//ForwardingUnit rf(forwardOp1, forwardOp2, ID_EXE_Rs, ID_EXE_Rt, EXE_MEM_DstReg, EXE_MEM_RegWrite, MEM_WB_DstReg, MEM_WB_RegWrite, clk);
//
//initial
//begin
//ID_EXE_Rs<= 5 ; ID_EXE_Rt<= 5 ; EXE_MEM_DstReg<= 5; MEM_WB_DstReg<= 5; EXE_MEM_RegWrite<= 1 ; MEM_WB_RegWrite<= 0 ;
//#150 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);
//
//ID_EXE_Rs<= 5; ID_EXE_Rt<= 5; EXE_MEM_DstReg<= 6 ; MEM_WB_DstReg<= 5 ; EXE_MEM_RegWrite<=0 ; MEM_WB_RegWrite<=1 ;
//#200 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);
//
//ID_EXE_Rs<= 6 ; ID_EXE_Rt<= 7 ; EXE_MEM_DstReg<= 9 ; MEM_WB_DstReg<= 10 ; EXE_MEM_RegWrite<= 1 ; MEM_WB_RegWrite<= 1 ;
//#250 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);
//
//ID_EXE_Rs<= 6; ID_EXE_Rt<= 6 ; EXE_MEM_DstReg<= 6; MEM_WB_DstReg<= 6 ; EXE_MEM_RegWrite<= 1; MEM_WB_RegWrite<= 1 ;
//#300 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);
//
//ID_EXE_Rs<= 7; ID_EXE_Rt<= 7 ; EXE_MEM_DstReg<= 9 ; MEM_WB_DstReg<= 7; EXE_MEM_RegWrite<= 0; MEM_WB_RegWrite<= 1 ;
//#350 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);
//
//ID_EXE_Rs<= 8; ID_EXE_Rt<= 4; EXE_MEM_DstReg<=4 ; MEM_WB_DstReg<=8 ; EXE_MEM_RegWrite<= 1 ; MEM_WB_RegWrite<= 1 ;
//#400 $display("A = %b ",forwardOp1," B = %b ",forwardOp2);
//end
//endmodule