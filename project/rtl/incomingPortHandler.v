/*
 * Incoming port handler
 *
 * Parses the incoming destination address, and routes the packet to the appropiate output port.
 * Resposible for implimenting routing algorithm.
 */
`include "globalVariables.v"

/*
module incomingPortHandler(
	input clk,
	input reset,
	input [`NETWORK_ADDRESS_WIDTH -1:0] localRouterAddress,
	
	//External IO
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn,
	input readIn,
	input writeIn,
			
	//Internal IO
	output reg [3:0] outputPortSelect,
	output reg memRead,
	output reg memWrite
	);
	
	reg [3:0] counter;
	
	always @ (posedge clk) begin
		//Synchronous reset
		if (reset) begin
			outputPortSelect <= 4'b0000;
			memRead <= 0;
			memWrite <= 0;
			counter <= 0;
		end
		
		else begin
			outputPortSelect <= counter;
			counter <= counter + 1;
		end	
	end

endmodule  //incomingPortHandler
*/

module incomingPortHandler(
	input clk,
	input reset,
	input [`NETWORK_ADDRESS_WIDTH -1:0] localRouterAddress,
	
	//External IO
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn,
	input readIn,
	input writeIn,
			
	//Internal IO
	output reg [3:0] outputPortSelect,
	output reg memRead,
	output reg memWrite
	);
		
	//Address parsing
	wire [`NETWORK_ROW_ADDRESS_WIDTH-1:0] localRowAddress = localRouterAddress[`NETWORK_ADDRESS_WIDTH-1:`NETWORK_COLUMN_ADDRESS_WIDTH];  //row then column ordering for network address
	wire [`NETWORK_COLUMN_ADDRESS_WIDTH-1:0] localColumnAddress = localRouterAddress[`NETWORK_COLUMN_ADDRESS_WIDTH-1:0];
	
	wire [`NETWORK_ADDRESS_WIDTH -1:0] incomingDesitnationAddress = destinationAddressIn[`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:`CACHE_BANK_ADDRESS_WIDTH];
	wire [`NETWORK_ROW_ADDRESS_WIDTH-1:0] destinationRowAddress = incomingDesitnationAddress[`NETWORK_ADDRESS_WIDTH-1:`NETWORK_COLUMN_ADDRESS_WIDTH];  //row then column ordering for network address
	wire [`NETWORK_COLUMN_ADDRESS_WIDTH-1:0] destinationColumnAddress = incomingDesitnationAddress[`NETWORK_COLUMN_ADDRESS_WIDTH-1:0];
	
	always @ (posedge clk) begin
		//Synchronous reset
		if (reset) begin
			outputPortSelect <= 4'b0000;
			memRead <= 0;
			memWrite <= 0;
		end
		
		else begin
			if (readIn || writeIn) begin
				//We have an incoming packet
				if (incomingDesitnationAddress == localRouterAddress) begin
					//This packet it meant for us. Pass to local cache
					outputPortSelect <= 4'b0000;
					memRead <= readIn;
					memWrite <= writeIn;
				end
				
				//Packet is meant for someone else. Route packet to next router
				//Route to correct row first, then correct column
				else if (destinationRowAddress > localRowAddress) begin
					//send packet south
					outputPortSelect <= 4'b0010;
					memRead <= `FALSE;
					memWrite <= `FALSE;
				end
				
				else if (destinationRowAddress < localRowAddress) begin
					//send packet north
					outputPortSelect <= 4'b0001;
					memRead <= `FALSE;
					memWrite <= `FALSE;
				end
				
				else if (destinationRowAddress == localRowAddress) begin
					if (destinationColumnAddress > localColumnAddress) begin
						//send packet east
						outputPortSelect <= 4'b0100;
					end
					
					if (destinationColumnAddress < localColumnAddress) begin
						//send packet west
						outputPortSelect <= 4'b1000;
					end
					memRead <= `FALSE;
					memWrite <= `FALSE;
				end
			end
			else begin
				outputPortSelect <= 4'b0000;
			end
		end	
	end

endmodule  //incomingPortHandler

