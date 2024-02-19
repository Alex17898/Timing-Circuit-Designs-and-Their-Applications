`timescale 1ps / 100fs
module DCO#(
	parameter alpha_num = 7,
	parameter lambda_num = 128,
	parameter delay_num = 25
) 
(
	input E,
	input [alpha_num-1:0]alpha,
	output clk_out

);
	wire [lambda_num-1:0]u;
	wire [delay_num-1:0]g;
	
	NAND2X2 NAND0(.A(E),.B(clk_out),.Y(g[0]));
	
	genvar j; 
	generate
		for(j=0;j<delay_num-1;j=j+1)begin:delay
			TBUFX1 TBUF0(.A(g[j]),.OE(1'b1),.Y(g[j+1]));
		end
	endgenerate
	
	assign u[0]=g[delay_num-1];
	
	genvar i; 
	generate
		for(i=0;i<lambda_num-1;i=i+1)begin:RO
			TBUFX2 TBUF1(.A(u[i]),.OE(1'b1),.Y(u[i+1]));
		end
	endgenerate
	
	MUX128to1 m0(.A(u),.sel(alpha),.Dout(clk_out));
	
endmodule

module MUX128to1
(
	input [127:0]A,
	input [6:0]sel,
	output reg Dout
);
	always @(*)begin
		case(sel)
		7'd0:Dout=A[0];
        7'd1:Dout=A[1];
        7'd2:Dout=A[2];
        7'd3:Dout=A[3];
        7'd4:Dout=A[4];
        7'd5:Dout=A[5];
        7'd6:Dout=A[6];
        7'd7:Dout=A[7];
        7'd8:Dout=A[8];
        7'd9:Dout=A[9];
        7'd10:Dout=A[10];
        7'd11:Dout=A[11];
        7'd12:Dout=A[12];
        7'd13:Dout=A[13];
        7'd14:Dout=A[14];
        7'd15:Dout=A[15];
        7'd16:Dout=A[16];
        7'd17:Dout=A[17];
        7'd18:Dout=A[18];
        7'd19:Dout=A[19];
        7'd20:Dout=A[20];
        7'd21:Dout=A[21];
        7'd22:Dout=A[22];
        7'd23:Dout=A[23];
        7'd24:Dout=A[24];
        7'd25:Dout=A[25];
        7'd26:Dout=A[26];
        7'd27:Dout=A[27];
        7'd28:Dout=A[28];
        7'd29:Dout=A[29];
        7'd30:Dout=A[30];
        7'd31:Dout=A[31];
        7'd32:Dout=A[32];
        7'd33:Dout=A[33];
        7'd34:Dout=A[34];
        7'd35:Dout=A[35];
        7'd36:Dout=A[36];
        7'd37:Dout=A[37];
        7'd38:Dout=A[38];
        7'd39:Dout=A[39];
        7'd40:Dout=A[40];
        7'd41:Dout=A[41];
        7'd42:Dout=A[42];
        7'd43:Dout=A[43];
        7'd44:Dout=A[44];
        7'd45:Dout=A[45];
        7'd46:Dout=A[46];
        7'd47:Dout=A[47];
        7'd48:Dout=A[48];
        7'd49:Dout=A[49];
        7'd50:Dout=A[50];
        7'd51:Dout=A[51];
        7'd52:Dout=A[52];
        7'd53:Dout=A[53];
        7'd54:Dout=A[54];
        7'd55:Dout=A[55];
        7'd56:Dout=A[56];
        7'd57:Dout=A[57];
        7'd58:Dout=A[58];
        7'd59:Dout=A[59];
        7'd60:Dout=A[60];
        7'd61:Dout=A[61];
        7'd62:Dout=A[62];
        7'd63:Dout=A[63];
        7'd64:Dout=A[64];
        7'd65:Dout=A[65];
        7'd66:Dout=A[66];
        7'd67:Dout=A[67];
        7'd68:Dout=A[68];
        7'd69:Dout=A[69];
        7'd70:Dout=A[70];
        7'd71:Dout=A[71];
        7'd72:Dout=A[72];
        7'd73:Dout=A[73];
        7'd74:Dout=A[74];
        7'd75:Dout=A[75];
        7'd76:Dout=A[76];
        7'd77:Dout=A[77];
        7'd78:Dout=A[78];
        7'd79:Dout=A[79];
        7'd80:Dout=A[80];
        7'd81:Dout=A[81];
        7'd82:Dout=A[82];
        7'd83:Dout=A[83];
        7'd84:Dout=A[84];
        7'd85:Dout=A[85];
        7'd86:Dout=A[86];
        7'd87:Dout=A[87];
        7'd88:Dout=A[88];
        7'd89:Dout=A[89];
        7'd90:Dout=A[90];
        7'd91:Dout=A[91];
        7'd92:Dout=A[92];
        7'd93:Dout=A[93];
        7'd94:Dout=A[94];
        7'd95:Dout=A[95];
        7'd96:Dout=A[96];
        7'd97:Dout=A[97];
        7'd98:Dout=A[98];
        7'd99:Dout=A[99];
        7'd100:Dout=A[100];
        7'd101:Dout=A[101];
        7'd102:Dout=A[102];
        7'd103:Dout=A[103];
        7'd104:Dout=A[104];
        7'd105:Dout=A[105];
        7'd106:Dout=A[106];
        7'd107:Dout=A[107];
        7'd108:Dout=A[108];
        7'd109:Dout=A[109];
        7'd110:Dout=A[110];
        7'd111:Dout=A[111];
        7'd112:Dout=A[112];
        7'd113:Dout=A[113];
        7'd114:Dout=A[114];
        7'd115:Dout=A[115];
        7'd116:Dout=A[116];
        7'd117:Dout=A[117];
        7'd118:Dout=A[118];
        7'd119:Dout=A[119];
        7'd120:Dout=A[120];
        7'd121:Dout=A[121];
        7'd122:Dout=A[122];
        7'd123:Dout=A[123];
        7'd124:Dout=A[124];
        7'd125:Dout=A[125];
        7'd126:Dout=A[126];
        7'd127:Dout=A[127];
		default:Dout=1'b0;
	endcase
	end
endmodule 