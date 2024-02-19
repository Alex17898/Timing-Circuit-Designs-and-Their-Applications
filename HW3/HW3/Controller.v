`timescale 1ns / 10ps
module Controller(
	input Lead_Lag,
	input clk,
	input reset,
	output reg Locked,
	output reg[2:0]alpha,
	output reg start
);
	reg [2:0]control;
	reg [2:0]state,next_state;
	reg [2:0]count_p,count_n;
	reg register;
	
	parameter [2:0] IDLE =0;
	parameter [2:0] COMP = 1;
	parameter [2:0] CALC = 2;
	parameter [2:0] ADD = 3;
	parameter [2:0] FINISH =4;
	
	always@(posedge clk)begin
		if(~reset)begin
			state<=IDLE;
			alpha<=3'b100;
			control<=3'b010;
			Locked<=1'b0;
			count_p<=3'd0;
			count_n<=3'd0;
			start<=1'b0;
		end
		else begin
			state<=next_state;
			start<=1'b1;
			case(state)
				IDLE:begin
					alpha<=3'b100;
					control<=3'b010;
					Locked<=1'b0;
				end
				COMP:begin
					if(Lead_Lag)begin
						alpha<=alpha+control;
					end
					else begin
						alpha<=alpha-control;
					end
					Locked<=1'b0;
					control<=control;
				end
				CALC:begin
					if(control==3'd1)begin
						control<=8'd1;
					end
					else begin
						control<=control>>1;
					end
					Locked<=1'b0;
					alpha<=alpha;
				end
				ADD:begin
					Locked<=1'b1;
					if(Lead_Lag)begin
						alpha<=alpha+8'd1;
					end
					else begin
						alpha<=alpha-8'd1;
					end
					Locked<=1'b0;
					control<=control;
				end
				FINISH:begin
					Locked<=1'b1;
					alpha<=alpha;
				end
				default:begin
					alpha<=alpha;
					Locked<=Locked;
					control<=control;
				end
			endcase
		end
	end
	
	always@(*)begin
			case(state)
				IDLE:next_state=COMP;
				COMP:next_state=CALC;
				CALC:next_state=(control==8'd1)?ADD:COMP;
				ADD:next_state=FINISH;
				FINISH:next_state=FINISH;
				default:next_state=IDLE;
			endcase
	end
endmodule
