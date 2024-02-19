`timescale 1ns / 10ps
module DCO#(
	parameter alpha_num = 3,
	parameter delay_num = 36
) 
(
	input E,
	input [alpha_num-1:0]alpha,
	output clk_out

);
	wire [7:0]u;
	wire [delay_num-1:0]g;
	wire y;
	
	NAND2X2 NAND0(.A(E),.B(clk_out),.Y(g[0]));
	
	genvar j; 
	generate
		for(j=0;j<delay_num-1;j=j+1)begin:delay
			TBUFX1 TBUF0(.A(g[j]),.OE(1'b1),.Y(g[j+1]));
		end
	endgenerate
	BUFX18 buf7(.A(g[delay_num-1]),.Y(y));
	BUFX16 buf8(.A(y),.Y(u[0]));
	
	BUFX16 buf0(.A(u[0]),.Y(u[1]));
	BUFX18 buf1(.A(u[1]),.Y(u[2]));
	BUFX18 buf2(.A(u[2]),.Y(u[3]));
	BUFX18 buf3(.A(u[3]),.Y(u[4]));
	BUFX18 buf4(.A(u[4]),.Y(u[5]));
	BUFX18 buf5(.A(u[5]),.Y(u[6]));
	BUFX18 buf6(.A(u[6]),.Y(u[7]));

	MUX8to1 U0(.A(u),.sel(alpha),.Dout(clk_out));
	
endmodule

module MUX8to1
(
	input [7:0]A,
	input [2:0]sel,
	output reg Dout
);
	always @(*)begin
		case(sel)
		3'd0:Dout=A[0];
        3'd1:Dout=A[1];
        3'd2:Dout=A[2];
        3'd3:Dout=A[3];
        3'd4:Dout=A[4];
        3'd5:Dout=A[5];
        3'd6:Dout=A[6];
        3'd7:Dout=A[7];
		default:Dout=Dout;
		endcase
	end
endmodule