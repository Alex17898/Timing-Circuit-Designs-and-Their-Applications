`timescale 1ps / 100fs
module testbench;

    parameter period = 2;
    parameter delay = 1;

    reg E;
	reg [6:0]alpha;
	wire clk_out;

    DCO U0(.E(E),.alpha(alpha),.clk_out(clk_out));

    initial begin
        $fsdbDumpfile("./DCO_rtl.fsdb");
        $fsdbDumpvars;
    end


    initial begin
		alpha=7'b1;E=0;
		#6000   E=1;
		#300000 alpha=7'b10;E=0;
		#6000   E=1;
		#300000 alpha=7'b100000;E=0;
		#10000   E=1;
		#300000 alpha=7'd1;E=0;
		#50000   E=1;
        #2000000 $finish;
    end

    // Automatically finish
    initial begin
        #1000000;
        $finish;
    end

endmodule