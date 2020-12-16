module regFile(reg1, reg2, reg3, ReadData1, ReadData2, clk, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite);
//input
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input clk, RegWrite;
	input [31:0] WriteData;
//output	
	output reg [31:0] ReadData1, ReadData2;
	output reg [31:0]reg1,reg2,reg3;
	
//initializing registers
	reg [31:0] registers_i[31:0];	
	integer i;
	
	initial
		begin
			registers_i[0]=0;
			for(i=0;i<32;i=i+1) 
				begin
					registers_i[i]=i;
				end
		end
//writing data to the register
			always @(posedge clk)
				begin
					if(RegWrite && WriteRegister!=0)
						begin
							registers_i[WriteRegister] <= WriteData;
							//here
							reg3 <= registers_i[6];
						end
				end
						
//reading the data
	always @(negedge clk)
		begin
			ReadData1 <= registers_i[ReadRegister1];
			ReadData2 <= registers_i[ReadRegister2];
			reg1 <= registers_i[1];
         reg2 <= registers_i[2];
	      
		end
	
endmodule
////////////////////////////////////////////////////
////module clock(clk);
////	output clk;
////	reg clk;
////	initial begin
////		clk <= 0;
////	end
////	always
////		begin
////		#50 
////		clk <= ~clk;	
////	end
////endmodule
//////////////////////////////////////////////////////
////module test;
////wire [31:0] r1, r2;
////reg [31:0] wd;
////reg [4:0] rr1, rr2, w;
////wire clk;
////reg rw;
////
////clock c1(clk);
////registerFile rf(r1,r2,clk,rr1,rr2,w,wd,rw);
////
////initial
////begin
////rr1 = 2 ; rr2 = 3 ; w=0 ; wd = 0; rw =0;
////#50 $display("R1= %b ",r1," R2 = %b",r2);
////
////rr1 = 2 ; rr2 = 3 ; w=4 ; wd = 16; rw =1;
////#75 $display("R1= %b ",r1," R2 = %b",r2);
////
////rr1 = 4 ; rr2 = 4 ; w= 0; wd = 16; rw =1;
////#75 $display("R1= %b ",r1," R2 = %b",r2);
////
////rr1 = 4 ; rr2 = 4 ; w= 0; wd = 16; rw =1;
////#76 $display("R1= %b ",r1," R2 = %b",r2);
////
////rr1 = 0 ; rr2 = 4 ; w= 0; wd = 16; rw =1;
////#100 $display("R1= %b ",r1," R2 = %b",r2);
////
////rr1 = 2 ; rr2 = 3 ; w=0 ; wd = 0; rw =0;
////#150 $display("R1= %b ",r1," R2 = %b",r2);
////
////end
////endmodule
////
////
