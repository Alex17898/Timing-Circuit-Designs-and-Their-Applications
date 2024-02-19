`timescale 1ns / 10ps
module fDiv
(
	input clk_DCO,
	input reset,
	input [7:0]DIVN,
	output clk_div
);
	wire [7:0]half;
	reg [7:0]count;
	
	always@(posedge clk_DCO or negedge reset)begin
		if(~reset)begin
			count<=8'd0;
		end
		else if(count==DIVN-8'd1)begin
			count<=8'd0;
		end
		else begin
			count<=count+8'd1;
		end
	end
	
	assign half=DIVN>>1;
	assign clk_div=(count>half)?1'b0:1'b1;
endmodule
 