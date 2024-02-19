`timescale 1ns / 10ps
module testbench;

    parameter period = 1000;
    parameter delay = 1;

    reg clk_ref;
	reg reset;
	wire clk_out;
	wire Locked;

    PLL PLL1(.clk_ref(clk_ref),.reset(reset),.clk_out(clk_out),.Locked(Locked));

    initial begin
        $fsdbDumpfile("./PLL_rtl.fsdb");
        $fsdbDumpvars;
    end
	always #(period / 2) clk_ref = ~clk_ref;

    initial begin
		clk_ref=0;reset=1;
		#1000 reset=0;
		#5000 reset=1;
        #2000000 $finish;
    end

    // Automatically finish
    initial begin
        #1000000;
        $finish;
    end

endmodule