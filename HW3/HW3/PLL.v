`timescale 1ns / 10ps
module PLL
(
	input clk_ref,
	input reset,
	output clk_out,
	output Locked
);
	wire clk_div,Lead_Lag,start;
	wire [2:0]alpha;
	PD U0(.en(reset),.clk_ref(clk_ref),.clk_div(clk_div),.Lead_Lag(Lead_Lag));
	Controller U1(.Lead_Lag(Lead_Lag),.clk(clk_ref),.reset(reset),.Locked(Locked),.alpha(alpha),.start(start));
	DCO U2(.E(start),.alpha(alpha),.clk_out(clk_out));
	fDiv U3(.clk_DCO(clk_out),.reset(reset),.DIVN(8'd92),.clk_div(clk_div));
endmodule