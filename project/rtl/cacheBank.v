`include "globalVariables.v"

module cacheBank( 
	input clk,
	input reset,
	
	//Port A
	input [`DATA_WIDTH -1:0] cacheDataIn_A,
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A,
	input memWrite_A,
	output reg [`DATA_WIDTH -1:0] cacheDataOut_A,
	output reg portA_writtenTo,
	
	//Port B
	input [`DATA_WIDTH -1:0] cacheDataIn_B,
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B,
	input memWrite_B,
	output reg [`DATA_WIDTH -1:0] cacheDataOut_B,
	output reg portB_writtenTo
	);


     

// parameters for the width 

parameter ADR   = `CACHE_BANK_ADDRESS_WIDTH;
parameter DAT   = `DATA_WIDTH;
parameter DPTH  = `CACHE_BANK_LINES;

//internal variables
reg [DPTH-1:0] isWritten;
reg [DAT-1:0] SRAM [DPTH-1:0];


always @ (posedge clk)

begin

 	if (reset) begin
		isWritten <= {DPTH{1'b0}};
		//portA_writtenTo <= 1;
		//portB_writtenTo <= 1;
 	end

 	else begin

	  	if (~memWrite_A) begin
	   		SRAM[cacheAddressIn_A] <= cacheDataIn_A;
			isWritten[cacheAddressIn_A] <= 1;
	  	end

		else begin
	   		cacheDataOut_A <= SRAM[cacheAddressIn_A];
			portA_writtenTo <= isWritten[cacheAddressIn_A];
	  	end

	  	if (~memWrite_B) begin
	   		SRAM[cacheAddressIn_B] <= cacheDataIn_B;
			isWritten[cacheAddressIn_B] <= 1;
	  	end

		else begin
	   		cacheDataOut_B <= SRAM[cacheAddressIn_B];
			portB_writtenTo <= isWritten[cacheAddressIn_B];	  	
		end

	  	
  	end
end	
endmodule

