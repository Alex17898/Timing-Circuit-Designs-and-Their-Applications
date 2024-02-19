`timescale 1ns / 10ps
module PD
(
	input en,
	input clk_ref,
	input clk_div,
	output Lead_Lag
);
	wire reset,Rst,up,down,S,R,d;
	DFF U0(.D(1'b1),.reset(reset),.clk(clk_div),.Q(up));
	DFF U1(.D(1'b1),.reset(reset),.clk(clk_ref),.Q(down));
	nand u5(Rst,up,down);
	and u7(reset,Rst,en);
	nand n1(S,up,R);
	nand n2(R,down,S);
	nand n3(Lead_Lag,S,d);
	nand n4(d,Lead_Lag,R);	
endmodule

module DFF
(
	input D,
	input reset,
	input clk,
	output reg Q
);
	always@(posedge clk or negedge reset)begin
		if(~reset)begin
			Q<=1'b0;
		end
		else begin
			Q<=D;
		end
	end
endmodule