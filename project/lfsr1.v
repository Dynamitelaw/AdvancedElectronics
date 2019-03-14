
module lfsr1 (clk, resetn, lfsr_out);
        input clk, resetn;
        output [27:0] lfsr_out;

        reg [27:0] lfsr_out;

        always @(posedge clk or negedge resetn) begin
        	if (~ resetn) begin
        		//next lfsr_out is zero
        		lfsr_out <= 27'b0;
        	end
        	
        	else begin
        		//next lfsr_out[27:1] = lfsr_out[26:0], and next lfsr_out[0] = ~(<- means inversion) of (xor of lfsr_out[27],lfsr_out[23],lfsr_out[16],lfsr_out[0])
        		lfsr_out[27:1] <= lfsr_out[26:0];
        		lfsr_out[0] <= ~(^ {lfsr_out[27],lfsr_out[23],lfsr_out[16],lfsr_out[0]});
        	end
        end
endmodule

