/*
 * Defines the microarchitecture of a router
 *
 * Jose Rubianes (jer2201)
 */
 
//Include dependencies
`include globalVariables.v


/*
 * Top-level router module
 */
module router(
	input clk,
	input reset,
	
	//North port (0)
	input portEnable_NORTH,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input readIn_NORTH,
	input writeIn_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,
		
	output [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_NORTH,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH,
	output readOut_NORTH,
	output writeOut_NORTH,
	output [`DATA_WIDTH -1:0] dataOut_NORH,
	
	//South port (1)
	input portEnable_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input readIn_SOUTH,
	input writeIn_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
		
	output [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_SOUTH,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH,
	output readOut_SOUTH,
	output writeOut_SOUTH,
	output [`DATA_WIDTH -1:0] dataOut_SOUTH, 
	
	//East port (2)
	input portEnable_EAST,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input readIn_EAST,
	input writeIn_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
		
	output [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0]] destinationAddressOut_EAST,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST,
	output readOut_EAST,
	output writeOut_EAST,
	output [`DATA_WIDTH -1:0] dataOut_EAST, 
	
	//West port (3)
	input portEnable_WEST,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input readIn_WEST,
	input writeIn_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
		
	output [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0]destinationAddressOut_WEST,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST,
	output readOut_WEST,
	output writeOut_WEST,
	output [`DATA_WIDTH -1:0] dataOut_WEST, 
		
	//Cache bank IO
	input [`DATA_WIDTH -1:0] cacheDataOut,
	
	output [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddress,
	output [`DATA_WIDTH -1:0] cacheDataIn,
	output memRead,
	output memWrite
	)
	
	generate
		if (portEnable_NORTH)
			//instantiate porthandler
		else
			//don't instantiate	
		//is this possible?: need to look into it
		// https://stackoverflow.com/questions/15240591/conditional-instantiation-of-verilog-module
	endgenerate
	
endmodule  //router


/*
 * Router port handler
 */
module portHandler(
	input clk,
	input reset,
	
	//External IO
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn,
	input readIn,
	input writeIn,
	input [`DATA_WIDTH -1:0] dataIn,
		
	output reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut,
	output reg readOut,
	output reg writeOut,
	output reg [`DATA_WIDTH -1:0] dataOut,
	
	//Internal IO
	input [`NETWORK_ADDRESS_WIDTH -1:0] localRouterAddress,
	
	input outputQueueIn_Data [`DATA_WIDTH -1:0],
	input outputQueueIn_RW,
	input arbiterSelect,
	
	output reg [3:0] outputPortSelect,
	output reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddress,
	output reg [`DATA_WIDTH -1:0] cacheDataIn,
	output reg memRead,
	output reg memWrite
	)
	
	/*
	//Input and output buffers
	parameter bufferSize = 3;
	
	reg [`DATA_WIDTH:0] inputBuffer [bufferSize-1:0];  //MSB used to store read/write 
	wire inputBufferSelect [bufferSize-1:0];
	
	reg [`DATA_WIDTH:0] outputBuffer [bufferSize-1:0];
	wire outputBufferSelect [bufferSize-1:0];
	*/
	
	//Address parsing
	wire [`NETWORK_ROW_ADDRESS_WIDTH-1:0] localRowAddress = localRouterAddress[`NETWORK_ADDRESS_WIDTH-1:`NETWORK_COLUMN_ADDRESS_WIDTH];  //row then column ordering for network address
	wire [`NETWORK_COLUMN_ADDRESS_WIDTH-1:0] localColumnAddress = localRouterAddress[`NETWORK_COLUMN_ADDRESS_WIDTH-1:0];
	
	wire [`NETWORK_ADDRESS_WIDTH -1:0] incomingDesitnationAddress = destinationAddressIn[`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:`CACHE_BANK_ADDRESS_WIDTH];
	wire [`NETWORK_ROW_ADDRESS_WIDTH-1:0] destinationRowAddress = incomingDesitnationAddress[`NETWORK_ADDRESS_WIDTH-1:`NETWORK_COLUMN_ADDRESS_WIDTH];  //row then column ordering for network address
	wire [`NETWORK_COLUMN_ADDRESS_WIDTH-1:0] destinationColumnAddress = incomingDesitnationAddress[`NETWORK_COLUMN_ADDRESS_WIDTH-1:0];
	
	
	
	/*
	//Combinational logic to determine next empty spot in buffers
	always @* begin
		for (i=0; i<bufferSize; i=i+1) begin
			if (i==0) begin
				inputBufferSelect[i] = ~(inputBuffer[i][`DATA_WIDTH]);
				outputBufferSelect[i] = ~(outputBuffer[i][`DATA_WIDTH]);
			end
			else begin
				inputBufferSelect[i] = ~(inputBuffer[i][`DATA_WIDTH]) ~(&inputBufferSelect[i-1:0]);
				outputBufferSelect[i] = ~(outputBuffer[i][`DATA_WIDTH]) ~(&outputBufferSelect[i-1:0]);
			end
		end
	end
	*/
	
	
	always @ (posedge clk) begin
		//Synchronous reset
		if (reset) begin
			for (i = 0; i < bufferSize; i = i +1) begin
				inputBuffer[i] <= `DATA_WIDTH'b0;
				outputBuffer[i] <= `DATA_WIDTH'b0;
			end
		end
		
		else begin
			//Input port handling
			if (readIn || writeIn) begin
				//We have an incoming packet
				if (incomingDesitnationAddress == localRouterAddress) begin
					//This packet it meant for us. Pass to local cache
					cacheAddress <= destinationAddressIn[`CACHE_BANK_ADDRESS_WIDTH -1:0];
					cacheDataIn <= dataIn;
					memRead <= readIn;
					memWrite <= writeIn;
				end
				
				//Packet is meant for someone else. Route packet to next router
				//Route to correct row first, then correct column
				if (destinationRowAddress > localRowAddress) begin
					//send packet south
					outputPortSelect <= 4'b0010;
				end
				
				if (destinationRowAddress < localRowAddress) begin
					//send packet north
					outputPortSelect <= 4'b0001;
				end
				
				if (destinationRowAddress == localRowAddress) begin
					if (destinationColumnAddress > localColumnAddress) begin
						//send packet east
						outputPortSelect <= 4'b0100;
					end
					
					if (destinationColumnAddress < localColumnAddress) begin
						//send packet west
						outputPortSelect <= 4'b1000;
					end
				end
			end
		end	
	end

endmodule  //portHandler

