/*
 * Defines the microarchitecture of a router
 *
 * Jose Rubianes (jer2201)
 */
 
//Include dependencies
`include "globalVariables.v"
`include "cacheAccessArbiter.v"
`include "outputportarbiter.v"


/*
 * Top-level router module
 */
module router(
	input clk,
	input reset,
	input [`NETWORK_ADDRESS_WIDTH -1:0] localRouterAddress,
	
	//North port (1)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input readIn_NORTH,
	input writeIn_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_NORTH,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH,
	output wire readOut_NORTH,
	output wire writeOut_NORTH,
	output wire [`DATA_WIDTH -1:0] dataOut_NORTH,
	
	//South port (2)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input readIn_SOUTH,
	input writeIn_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_SOUTH,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH,
	output wire readOut_SOUTH,
	output wire writeOut_SOUTH,
	output wire [`DATA_WIDTH -1:0] dataOut_SOUTH, 
	
	//East port (3)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input readIn_EAST,
	input writeIn_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_EAST,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST,
	output wire readOut_EAST,
	output wire writeOut_EAST,
	output wire [`DATA_WIDTH -1:0] dataOut_EAST, 
	
	//West port (4)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input readIn_WEST,
	input writeIn_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0]destinationAddressOut_WEST,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST,
	output wire readOut_WEST,
	output wire writeOut_WEST,
	output wire [`DATA_WIDTH -1:0] dataOut_WEST, 
		
	//Cache bank IO
	output wire [`DATA_WIDTH -1:0] cacheDataIn_A,
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A,
	input [`DATA_WIDTH -1:0] cacheDataOut_A,
	output wire memWrite_A,
	
	output wire [`DATA_WIDTH -1:0] cacheDataIn_B,
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B,
	input [`DATA_WIDTH -1:0] cacheDataOut_B,
	output wire memWrite_B
	);
	
	/* ##############################
	 * Input buffers
	 * ##############################
	 */
	 
	//North
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressInBuffer_NORTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressInBuffer_NORTH;
	reg readInBuffer_NORTH;
	reg writeInBuffer_NORTH;
	reg [`DATA_WIDTH -1:0] dataInBuffer_NORTH;
	
	//South
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressInBuffer_SOUTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressInBuffer_SOUTH;
	reg readInBuffer_SOUTH;
	reg writeInBuffer_SOUTH;
	reg [`DATA_WIDTH -1:0] dataInBuffer_SOUTH;
	
	//East
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressInBuffer_EAST;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressInBuffer_EAST;
	reg readInBuffer_EAST;
	reg writeInBuffer_EAST;
	reg [`DATA_WIDTH -1:0] dataInBuffer_EAST;
	
	//West
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressInBuffer_WEST;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressInBuffer_WEST;
	reg readInBuffer_WEST;
	reg writeInBuffer_WEST;
	reg [`DATA_WIDTH -1:0] dataInBuffer_WEST;
	 
	 
	/* ###################################
	 * Instantiate incoming port handlers
	 * ###################################
	 */
	 
	//North
	wire [3:0] outputPortSelect_NORTH;
	wire memRead_NORTH;
	wire memWrite_NORTH;
	incomingPortHandler inNorth(
		.clk(clk),
		.reset(reset),
		.localRouterAddress(localRouterAddress),
		.destinationAddressIn(destinationAddressIn_NORTH),
		.requesterAddressIn(requesterAddressIn_NORTH),
		.readIn(readInBuffer_NORTH),
		.writeIn(writeInBuffer_NORTH),
		.outputPortSelect(outputPortSelect_NORTH),
		.memRead(memRead_NORTH),
		.memWrite(memWrite_NORTH)
		);
	
	//South
	wire [3:0] outputPortSelect_SOUTH;
	wire memRead_SOUTH;
	wire memWrite_SOUTH;
	incomingPortHandler inSouth(
		.clk(clk),
		.reset(reset),
		.localRouterAddress(localRouterAddress),
		.destinationAddressIn(destinationAddressIn_SOUTH),
		.requesterAddressIn(requesterAddressIn_SOUTH),
		.readIn(readInBuffer_SOUTH),
		.writeIn(writeInBuffer_SOUTH),
		.outputPortSelect(outputPortSelect_SOUTH),
		.memRead(memRead_SOUTH),
		.memWrite(memWrite_SOUTH)
		);
		
	//East
	wire [3:0] outputPortSelect_EAST;
	wire memRead_EAST;
	wire memWrite_EAST;
	incomingPortHandler inEast(
		.clk(clk),
		.reset(reset),
		.localRouterAddress(localRouterAddress),
		.destinationAddressIn(destinationAddressIn_EAST),
		.requesterAddressIn(requesterAddressIn_EAST),
		.readIn(readInBuffer_EAST),
		.writeIn(writeInBuffer_EAST),
		.outputPortSelect(outputPortSelect_EAST),
		.memRead(memRead_EAST),
		.memWrite(memWrite_EAST)
		);
	
	//West
	wire [3:0] outputPortSelect_WEST;
	wire memRead_WEST;
	wire memWrite_WEST;
	incomingPortHandler inWest(
		.clk(clk),
		.reset(reset),
		.localRouterAddress(localRouterAddress),
		.destinationAddressIn(destinationAddressIn_WEST),
		.requesterAddressIn(requesterAddressIn_WEST),
		.readIn(readInBuffer_WEST),
		.writeIn(writeInBuffer_WEST),
		.outputPortSelect(outputPortSelect_WEST),
		.memRead(memRead_WEST),
		.memWrite(memWrite_WEST)
		);
		
	
	/* ##############################
	 * Instantiate cache arbiter
	 * ##############################
	 */
	wire readReady_NORTH;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] cacheRequesterAddress_NORTH;
	wire [`DATA_WIDTH -1:0] cacheDataOut_NORTH;
	
	wire readReady_SOUTH;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] cacheRequesterAddress_SOUTH;
	wire [`DATA_WIDTH -1:0] cacheDataOut_SOUTH;
	
	wire readReady_EAST;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] cacheRequesterAddress_EAST;
	wire [`DATA_WIDTH -1:0] cacheDataOut_EAST;
	
	wire readReady_WEST;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] cacheRequesterAddress_WEST;
	wire [`DATA_WIDTH -1:0] cacheDataOut_WEST;
	
	cacheAccessArbiter cacheController(
		.clk(clk),
		.reset(reset),
	
		//North IO
		.cacheAddressIn_NORTH(destinationAddressInBuffer_NORTH[`CACHE_BANK_ADDRESS_WIDTH -1:0]),
		.requesterAddressIn_NORTH(requesterAddressInBuffer_NORTH),
		.memRead_NORTH(memRead_NORTH),
		.memWrite_NORTH(memWrite_NORTH),
		.dataIn_NORTH(dataInBuffer_NORTH),
	
		.readReady_NORTH(readReady_NORTH),
		.requesterAddressOut_NORTH(cacheRequesterAddress_NORTH),
		.cacheDataOut_NORTH(cacheDataOut_NORTH),
	
		//South IO
		.cacheAddressIn_SOUTH(destinationAddressInBuffer_SOUTH[`CACHE_BANK_ADDRESS_WIDTH -1:0]),
		.requesterAddressIn_SOUTH(requesterAddressInBuffer_SOUTH),
		.memRead_SOUTH(memRead_SOUTH),
		.memWrite_SOUTH(memWrite_SOUTH),
		.dataIn_SOUTH(dataInBuffer_SOUTH),
	
		.readReady_SOUTH(readReady_SOUTH),
		.requesterAddressOut_SOUTH(cacheRequesterAddress_SOUTH),
		.cacheDataOut_SOUTH(cacheDataOut_SOUTH),
		
		//East IO
		.cacheAddressIn_EAST(destinationAddressInBuffer_EAST[`CACHE_BANK_ADDRESS_WIDTH -1:0]),
		.requesterAddressIn_EAST(requesterAddressInBuffer_EAST),
		.memRead_EAST(memRead_EAST),
		.memWrite_EAST(memWrite_EAST),
		.dataIn_EAST(dataInBuffer_EAST),
	
		.readReady_EAST(readReady_EAST),
		.requesterAddressOut_EAST(cacheRequesterAddress_EAST),
		.cacheDataOut_EAST(cacheDataOut_EAST),
		
		//West IO
		.cacheAddressIn_WEST(destinationAddressInBuffer_WEST[`CACHE_BANK_ADDRESS_WIDTH -1:0]),
		.requesterAddressIn_WEST(requesterAddressInBuffer_WEST),
		.memRead_WEST(memRead_WEST),
		.memWrite_WEST(memWrite_WEST),
		.dataIn_WEST(dataInBuffer_WEST),
	
		.readReady_WEST(readReady_WEST),
		.requesterAddressOut_WEST(cacheRequesterAddress_WEST),
		.cacheDataOut_WEST(cacheDataOut_WEST),
		
		//Cache bank IO
		.cacheDataIn_A(cacheDataIn_A),
		.cacheAddressIn_A(cacheAddressIn_A),
		.cacheDataOut_A(cacheDataOut_A),
		.memWrite_A(memWrite_A),
	
		.cacheDataIn_B(cacheDataIn_B),
		.cacheAddressIn_B(cacheAddressIn_B),
		.cacheDataOut_B(cacheDataOut_B),
		.memWrite_B(memWrite_B)
		);
	 
	 
	/* ##############################
	 * Instantiate output arbiters
	 * ##############################
	 */
	 
	//North
	outputPortArbiter outNorth(
		.clk(clk),
		.reset(reset),

		.selectBit_NORTH(outputPortSelect_NORTH[0]),
		.destinationAddressIn_NORTH(destinationAddressInBuffer_NORTH),
		.requesterAddressIn_NORTH(requesterAddressInBuffer_NORTH),
		.readIn_NORTH(readInBuffer_NORTH),
		.writeIn_NORTH(writeInBuffer_NORTH),
		.dataIn_NORTH(dataInBuffer_NORTH),
	
		.selectBit_SOUTH(outputPortSelect_SOUTH[0]),
		.destinationAddressIn_SOUTH(destinationAddressInBuffer_SOUTH),
		.requesterAddressIn_SOUTH(requesterAddressInBuffer_SOUTH),
		.readIn_SOUTH(readInBuffer_SOUTH),
		.writeIn_SOUTH(writeInBuffer_SOUTH),
		.dataIn_SOUTH(dataInBuffer_SOUTH),
		
		.selectBit_EAST(outputPortSelect_EAST[0]),
		.destinationAddressIn_EAST(destinationAddressInBuffer_EAST),
		.requesterAddressIn_EAST(requesterAddressInBuffer_EAST),
		.readIn_EAST(readInBuffer_EAST),
		.writeIn_EAST(writeInBuffer_EAST),
		.dataIn_EAST(dataInBuffer_EAST),
		
		.selectBit_WEST(outputPortSelect_WEST[0]),
		.destinationAddressIn_WEST(destinationAddressInBuffer_WEST),
		.requesterAddressIn_WEST(requesterAddressInBuffer_WEST),
		.readIn_WEST(readInBuffer_WEST),
		.writeIn_WEST(writeInBuffer_WEST),
		.dataIn_WEST(dataInBuffer_WEST),
		
		.readReady(readReady_NORTH),
		.readRequesterAddress(cacheRequesterAddress_NORTH),
		.cacheDataOut(cacheDataOut_NORTH),
	
		.destinationAddressOut(destinationAddressOut_NORTH),
		.requesterAddressOut(requesterAddressOut_NORTH),
		.readOut(readOut_NORTH),
		.writeOut(writeOut_NORTH),
		.dataOut(dataOut_NORTH)
		);
	
	//South
	outputPortArbiter outSouth(
		.clk(clk),
		.reset(reset),

		.selectBit_NORTH(outputPortSelect_NORTH[1]),
		.destinationAddressIn_NORTH(destinationAddressInBuffer_NORTH),
		.requesterAddressIn_NORTH(requesterAddressInBuffer_NORTH),
		.readIn_NORTH(readInBuffer_NORTH),
		.writeIn_NORTH(writeInBuffer_NORTH),
		.dataIn_NORTH(dataInBuffer_NORTH),
	
		.selectBit_SOUTH(outputPortSelect_SOUTH[1]),
		.destinationAddressIn_SOUTH(destinationAddressInBuffer_SOUTH),
		.requesterAddressIn_SOUTH(requesterAddressInBuffer_SOUTH),
		.readIn_SOUTH(readInBuffer_SOUTH),
		.writeIn_SOUTH(writeInBuffer_SOUTH),
		.dataIn_SOUTH(dataInBuffer_SOUTH),
		
		.selectBit_EAST(outputPortSelect_EAST[1]),
		.destinationAddressIn_EAST(destinationAddressInBuffer_EAST),
		.requesterAddressIn_EAST(requesterAddressInBuffer_EAST),
		.readIn_EAST(readInBuffer_EAST),
		.writeIn_EAST(writeInBuffer_EAST),
		.dataIn_EAST(dataInBuffer_EAST),
		
		.selectBit_WEST(outputPortSelect_WEST[1]),
		.destinationAddressIn_WEST(destinationAddressInBuffer_WEST),
		.requesterAddressIn_WEST(requesterAddressInBuffer_WEST),
		.readIn_WEST(readInBuffer_WEST),
		.writeIn_WEST(writeInBuffer_WEST),
		.dataIn_WEST(dataInBuffer_WEST),
		
		.readReady(readReady_SOUTH),
		.readRequesterAddress(cacheRequesterAddress_SOUTH),
		.cacheDataOut(cacheDataOut_SOUTH),
		
		.destinationAddressOut(destinationAddressOut_SOUTH),
		.requesterAddressOut(requesterAddressOut_SOUTH),
		.readOut(readOut_SOUTH),
		.writeOut(writeOut_SOUTH),
		.dataOut(dataOut_SOUTH)
		);
		
	//East
	outputPortArbiter outEast(
		.clk(clk),
		.reset(reset),

		.selectBit_NORTH(outputPortSelect_NORTH[2]),
		.destinationAddressIn_NORTH(destinationAddressInBuffer_NORTH),
		.requesterAddressIn_NORTH(requesterAddressInBuffer_NORTH),
		.readIn_NORTH(readInBuffer_NORTH),
		.writeIn_NORTH(writeInBuffer_NORTH),
		.dataIn_NORTH(dataInBuffer_NORTH),
	
		.selectBit_SOUTH(outputPortSelect_SOUTH[2]),
		.destinationAddressIn_SOUTH(destinationAddressInBuffer_SOUTH),
		.requesterAddressIn_SOUTH(requesterAddressInBuffer_SOUTH),
		.readIn_SOUTH(readInBuffer_SOUTH),
		.writeIn_SOUTH(writeInBuffer_SOUTH),
		.dataIn_SOUTH(dataInBuffer_SOUTH),
		
		.selectBit_EAST(outputPortSelect_EAST[2]),
		.destinationAddressIn_EAST(destinationAddressInBuffer_EAST),
		.requesterAddressIn_EAST(requesterAddressInBuffer_EAST),
		.readIn_EAST(readInBuffer_EAST),
		.writeIn_EAST(writeInBuffer_EAST),
		.dataIn_EAST(dataInBuffer_EAST),
		
		.selectBit_WEST(outputPortSelect_WEST[2]),
		.destinationAddressIn_WEST(destinationAddressInBuffer_WEST),
		.requesterAddressIn_WEST(requesterAddressInBuffer_WEST),
		.readIn_WEST(readInBuffer_WEST),
		.writeIn_WEST(writeInBuffer_WEST),
		.dataIn_WEST(dataInBuffer_WEST),
		
		.readReady(readReady_EAST),
		.readRequesterAddress(cacheRequesterAddress_EAST),
		.cacheDataOut(cacheDataOut_EAST),
		
		.destinationAddressOut(destinationAddressOut_EAST),
		.requesterAddressOut(requesterAddressOut_EAST),
		.readOut(readOut_EAST),
		.writeOut(writeOut_EAST),
		.dataOut(dataOut_EAST)
		);
		
	//West
	outputPortArbiter outWest(
		.clk(clk),
		.reset(reset),

		.selectBit_NORTH(outputPortSelect_NORTH[3]),
		.destinationAddressIn_NORTH(destinationAddressInBuffer_NORTH),
		.requesterAddressIn_NORTH(requesterAddressInBuffer_NORTH),
		.readIn_NORTH(readInBuffer_NORTH),
		.writeIn_NORTH(writeInBuffer_NORTH),
		.dataIn_NORTH(dataInBuffer_NORTH),
	
		.selectBit_SOUTH(outputPortSelect_SOUTH[3]),
		.destinationAddressIn_SOUTH(destinationAddressInBuffer_SOUTH),
		.requesterAddressIn_SOUTH(requesterAddressInBuffer_SOUTH),
		.readIn_SOUTH(readInBuffer_SOUTH),
		.writeIn_SOUTH(writeInBuffer_SOUTH),
		.dataIn_SOUTH(dataInBuffer_SOUTH),
		
		.selectBit_EAST(outputPortSelect_EAST[3]),
		.destinationAddressIn_EAST(destinationAddressInBuffer_EAST),
		.requesterAddressIn_EAST(requesterAddressInBuffer_EAST),
		.readIn_EAST(readInBuffer_EAST),
		.writeIn_EAST(writeInBuffer_EAST),
		.dataIn_EAST(dataInBuffer_EAST),
		
		.selectBit_WEST(outputPortSelect_WEST[3]),
		.destinationAddressIn_WEST(destinationAddressInBuffer_WEST),
		.requesterAddressIn_WEST(requesterAddressInBuffer_WEST),
		.readIn_WEST(readInBuffer_WEST),
		.writeIn_WEST(writeInBuffer_WEST),
		.dataIn_WEST(dataInBuffer_WEST),
		
		.readReady(readReady_WEST),
		.readRequesterAddress(cacheRequesterAddress_WEST),
		.cacheDataOut(cacheDataOut_WEST),
		
		.destinationAddressOut(destinationAddressOut_WEST),
		.requesterAddressOut(requesterAddressOut_WEST),
		.readOut(readOut_WEST),
		.writeOut(writeOut_WEST),
		.dataOut(dataOut_WEST)
		);
	
	
	/* ##############################
	 * Packet buffering behaviour
	 * ##############################
	 */
	always @ (posedge clk) begin
		//Synchronous reset
		if (reset) begin
			//North
			destinationAddressInBuffer_NORTH <= 0;
			requesterAddressInBuffer_NORTH <= 0;
			readInBuffer_NORTH <= 0;
			writeInBuffer_NORTH <= 0;
			dataInBuffer_NORTH <= 0;
	
			//South
			destinationAddressInBuffer_SOUTH <= 0;
			requesterAddressInBuffer_SOUTH <= 0;
			readInBuffer_SOUTH <= 0;
			writeInBuffer_SOUTH <= 0;
			dataInBuffer_SOUTH <= 0;
	
			//East
			destinationAddressInBuffer_EAST <= 0;
			requesterAddressInBuffer_EAST <= 0;
			readInBuffer_EAST <= 0;
			writeInBuffer_EAST <= 0;
			dataInBuffer_EAST <= 0;
	
			//West
			destinationAddressInBuffer_WEST <= 0;
			requesterAddressInBuffer_WEST <= 0;
			readInBuffer_WEST <= 0;
			writeInBuffer_WEST <= 0;
			dataInBuffer_WEST <= 0;
		end
		
		else begin
			//North
			destinationAddressInBuffer_NORTH <= destinationAddressIn_NORTH;
			requesterAddressInBuffer_NORTH <= requesterAddressIn_NORTH;
			readInBuffer_NORTH <= readIn_NORTH;
			writeInBuffer_NORTH <= writeIn_NORTH;
			dataInBuffer_NORTH <= dataIn_NORTH;
	
			//South
			destinationAddressInBuffer_SOUTH <= destinationAddressIn_SOUTH;
			requesterAddressInBuffer_SOUTH <= requesterAddressIn_SOUTH;
			readInBuffer_SOUTH <= readIn_SOUTH;
			writeInBuffer_SOUTH <= writeIn_SOUTH;
			dataInBuffer_SOUTH <= dataIn_SOUTH;
	
			//East
			destinationAddressInBuffer_EAST <= destinationAddressIn_EAST;
			requesterAddressInBuffer_EAST <= requesterAddressIn_EAST;
			readInBuffer_EAST <= readIn_EAST;
			writeInBuffer_EAST <= writeIn_EAST;
			dataInBuffer_EAST <= dataIn_EAST;
	
			//West
			destinationAddressInBuffer_WEST <= destinationAddressIn_WEST;
			requesterAddressInBuffer_WEST <= requesterAddressIn_WEST;
			readInBuffer_WEST <= readIn_WEST;
			writeInBuffer_WEST <= writeIn_WEST;
			dataInBuffer_WEST <= dataIn_WEST;
		end
	end
	
endmodule  //router


/*
 * Incoming port handler
 *
 * Parses the incoming destination address, and routes the packet to the appropiate output port.
 * Resposible for implimenting routing algorithm.
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
		end	
	end

endmodule  //incomingPortHandler

