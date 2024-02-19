`timescale 1ns / 100ps
module testbench;

    parameter period = 2;
    parameter delay = 1;

    reg [9:0]target;
	reg clk;
	reg reset;
	reg start;
	wire done;
	wire [7:0]x;
	wire [9:0]y;

    SA u1(
	.target(target),
	.clk(clk),
	.reset(reset),
	.start(start),
	.done(done),
	.x(x),
	.y(y)
	);

initial begin
    $sdf_annotate("./SA_syn.sdf", u1);
	$fsdbDumpfile("./SA_syn.fsdb");
	$fsdbDumpvars;
end

    always #(period / 2) clk = ~clk;

    initial begin
        clk = 1;
        reset = 1;
        start = 0;
        target=10'd550;
        #(period + delay) reset = 0;
        #(period * 2) reset = 1;
        #(period) start = 1;
        #(period) start = 0;


        @(negedge done);
        @(posedge clk);
		#(period) start = 1;
		target=10'd800;
        #(period) start = 0;
        #(period * 20) $finish;
    end


initial begin

$monitor ($time," y=%d x=%d",y,x); 

end

always@(posedge clk)begin
	if(done)begin
		$display("--------------------------------------------------");
		$display("Done:         Taget=%d y=%d x=%d",target,y,x);
		$display("--------------------------------------------------");
	end
end

endmodule
