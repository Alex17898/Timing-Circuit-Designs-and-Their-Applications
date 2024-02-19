`timescale 1ps / 100fs
module testbench;

    parameter period = 2;
    parameter delay = 1;

    reg E;
	reg [6:0]alpha;
	wire clk_out;

    DCO U0(.E(E),.alpha(alpha),.clk_out(clk_out));

    initial begin
		$sdf_annotate("./DCO_syn.sdf", U0);
        $fsdbDumpfile("./DCO_syn.fsdb");
        $fsdbDumpvars;
    end


    initial begin
		alpha=7'b1;E=0;
		#50000   E=1;
		#200000 alpha=7'd2;
		#200000 alpha=7'd3;
		#200000 alpha=7'd4;
		#200000 alpha=7'd5;
		#200000 alpha=7'd6;
		#200000 alpha=7'd7;
		#200000 alpha=7'd8;
		#200000 alpha=7'd9;
		#200000 alpha=7'd10;
		#200000 alpha=7'd11;
		#200000 alpha=7'd12;
		#200000 alpha=7'd13;
		#200000 alpha=7'd20;
		#200000 alpha=7'd50;
		#200000 alpha=7'd127;
		#200000 alpha=7'd1;
        #3500000 $finish;
    end

    // Automatically finish
    initial begin
        #3500000;
        $finish;
    end

endmodule