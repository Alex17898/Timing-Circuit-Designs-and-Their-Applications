`timescale 1ns / 100ps
module SA(
	input [9:0]target,
	input clk,
	input reset,
	input start,
	output reg done,
	output reg[7:0]x,
	output reg[9:0]y
);
	reg [7:0]control;
	reg [1:0]state,next_state;
	
	parameter [1:0] IDLE =0;
	parameter [1:0] COMP = 1;
	parameter [1:0] CALC = 2;
	parameter [1:0] FINISH =3;
	
	always@(posedge clk)begin
		if(~reset)begin
			state<=IDLE;
		end
		else begin
			state<=next_state;
			case(state)
				IDLE:begin
					y=10'd607;
					x=8'b1000_0000;
					done=1'b0;
					control=8'b0100_0000;
				end
				COMP:begin
					if((control==8'd0)&(y>target))begin
						x=x-1;
					end
					else if(y>target)begin
						x=x-control;
					end
					else begin
						x=x+control;
					end
				end
				CALC:begin
					control=control>>1;
					y=(x<<1)+(13*x>>5)+300;
				end
				FINISH:done=1'b1;
			endcase
		end
	end
	
	always@(*)begin
			case(state)
				IDLE:next_state=(start)?COMP:IDLE;
				COMP:next_state=CALC;
				CALC:next_state=(control==8'd0)?FINISH:COMP;
				FINISH:next_state=IDLE;
				default:next_state=IDLE;
			endcase
	end
endmodule
