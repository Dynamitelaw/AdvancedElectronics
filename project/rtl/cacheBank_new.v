`include "globalVariables.v"
`include "CacheMem.v"

module cacheBank( 
	input clk,
	input reset,
	
	//Port A
	input [`DATA_WIDTH -1:0] cacheDataIn_A,
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A,
	input memWrite_A,
	output wire [`DATA_WIDTH -1:0] cacheDataOut_A,
	output reg portA_writtenTo,
	
	//Port B
	input [`DATA_WIDTH -1:0] cacheDataIn_B,
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B,
	input memWrite_B,
	output wire [`DATA_WIDTH -1:0] cacheDataOut_B,
	output reg portB_writtenTo
	);


	     

// parameters for the width 

parameter ADR   = `CACHE_BANK_ADDRESS_WIDTH;
parameter DAT   = `DATA_WIDTH;
parameter DPTH  = `CACHE_BANK_LINES;

//internal variables
reg [DPTH-1:0] isWritten;
reg [DAT-1:0] SRAM [DPTH-1:0];




CacheMem Memory( .QA(cacheDataOut_A), .QB(cacheDataOut_B), .CLKA(clk), .CENA(reset), .WENA(memWrite_A), .AA(cacheAddressIn_A), .DA(cacheDataIn_A), .CLKB(clk), .CENB(reset), .WENB(memWrite_B), .AB(cacheAddressIn_B), .DB(cacheDataIn_B));

always @ (posedge clk)

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
endmodule
