//`include "globalVariables.v"
`include "CacheMem.v"

`timescale 1 ns/1 ps
`celldefine

module cacheBank( 
	input clk,
	input reset,
	
	//Port A
	input [31:0] cacheDataIn_A,
	input [7:0] cacheAddressIn_A,
	input memWrite_A,
	output  [31:0] cacheDataOut_A,
	output portA_writtenTo,
	
	//Port B
	input [31:0] cacheDataIn_B,
	input [7:0] cacheAddressIn_B,
	input memWrite_B,
	output [31:0] cacheDataOut_B,
	output  portB_writtenTo
	);

CacheMem Memory( .QA(cacheDataOut_A), .QB(cacheDataOut_B), .CLKA(clk), .CENA(reset), .WENA(memWrite_A), .AA(cacheAddressIn_A), .DA(cacheDataIn_A), .CLKB(clk), .CENB(reset), .WENB(memWrite_B), .AB(cacheAddressIn_B), .DB(cacheDataIn_B));


endmodule
`endcelldefine
	     

// parameters for the width 
/*
parameter ADR   = `CACHE_BANK_ADDRESS_WIDTH;
parameter DAT   = `DATA_WIDTH;
parameter DPTH  = `CACHE_BANK_LINES;

//internal variables
reg [DPTH-1:0] isWritten;
*/





/*always @ (posedge clk)

begin

 	if (reset) begin
		isWritten <= {DPTH{1'b0}};
		//portA_writtenTo <= 1;
		//portB_writtenTo <= 1;
 	end

 	else begin

	  	if (~memWrite_A) begin
			isWritten[cacheAddressIn_A] <= 1;
	  	end

		else begin
			portA_writtenTo <= isWritten[cacheAddressIn_A];
	  	end

	  	if (~memWrite_B) begin
			isWritten[cacheAddressIn_B] <= 1;
	  	end

		else begin
			portB_writtenTo <= isWritten[cacheAddressIn_B];	  	
		end

	  	
  	end
end
*/	

