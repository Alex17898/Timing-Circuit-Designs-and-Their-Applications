`timescale 1ns / 10ps
module testbench;

    parameter period = 1000;
    parameter delay = 1;

    reg clk_ref;
	reg reset;
	wire clk_out;
	wire Locked;

    PLL U0(.clk_ref(clk_ref),.reset(reset),.clk_out(clk_out),.Locked(Locked));

    initial begin
		$sdf_annotate("./PLL_syn.sdf", U0);
        $fsdbDumpfile("./PLL_syn.fsdb");
        $fsdbDumpvars;
    end
	always #(period / 2) clk_ref = ~clk_ref;

    initial begin
		clk_ref=0;reset=1;
		#1000 reset=0;
		#2000 reset=1;
        #20000 $finish;
    end

    // Automatically finish
    initial begin
        #100000;
        $finish;
    end

endmodule

