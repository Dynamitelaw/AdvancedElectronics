//`include globalVariables.v
module clockgating(read,write,clk,gatedclk);

	input read,write,clk;
	output wire gatedclk;

	wire enable;
	reg q;

	assign enable= write || read;
	
	always @(enable,clk) begin
	  if(~clk) begin
	  q = enable;
	  end

	end
	assign gatedclk = q && clk;

endmodule
