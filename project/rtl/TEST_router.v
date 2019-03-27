/*
 * Router testbench
 *
 * Jose Rubianes (jer2201)
 */
 

//Include dependencies
`include "globalVariables.v"
`include "router.v"

module routerTestbench;
	//Instantiate modules
	reg reset = 0;
	reg clk;
	
	reg [`NETWORK_ADDRESS_WIDTH-1:0] localAddress = 4'd4;
	
	//North IO
	reg portEnable_NORTH = `TRUE;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH = 0;
	reg readIn_NORTH = 0;
	reg writeIn_NORTH = 0;
	reg [`DATA_WIDTH -1:0] dataIn_NORTH = 0;
	
	wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_NORTH;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH;
	wire readOut_NORTH;
	wire writeOut_NORTH;
	wire [`DATA_WIDTH -1:0] dataOut_NORTH;
	
	//South IO
	reg portEnable_SOUTH = `TRUE;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH = 0;
	reg readIn_SOUTH = 0;
	reg writeIn_SOUTH = 0;
	reg [`DATA_WIDTH -1:0] dataIn_SOUTH = 0;
	
	wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_SOUTH;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH;
	wire readOut_SOUTH;
	wire writeOut_SOUTH;
	wire [`DATA_WIDTH -1:0] dataOut_SOUTH;
	
	//East IO
	reg portEnable_EAST = `TRUE;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST = 0;
	reg readIn_EAST = 0;
	reg writeIn_EAST = 0;
	reg [`DATA_WIDTH -1:0] dataIn_EAST = 0;
	
	wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_EAST;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST;
	wire readOut_EAST;
	wire writeOut_EAST;
	wire [`DATA_WIDTH -1:0] dataOut_EAST;
	
	//West IO
	reg portEnable_WEST = `TRUE;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST = 0;
	reg readIn_WEST = 0;
	reg writeIn_WEST = 0;
	reg [`DATA_WIDTH -1:0] dataIn_WEST = 0;
	
	wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_WEST;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST;
	wire readOut_WEST;
	wire writeOut_WEST;
	wire [`DATA_WIDTH -1:0] dataOut_WEST;
	
	//Cache bank IO
	reg [`DATA_WIDTH -1:0] cacheDataOut = 0;
	
	wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddress;
	wire [`DATA_WIDTH -1:0] cacheDataIn;
	wire memRead;
	wire memWrite;
	
	router router4(
		.clk(clk),
		.reset(reset),
		.localRouterAddress(localAddress),
	
		//North port (1)
		.portEnable_NORTH(portEnable_NORTH),
		.destinationAddressIn_NORTH(destinationAddressIn_NORTH),
		.requesterAddressIn_NORTH(requesterAddressIn_NORTH),
		.readIn_NORTH(readIn_NORTH),
		.writeIn_NORTH(writeIn_NORTH),
		.dataIn_NORTH(dataIn_NORTH),
		
		.destinationAddressOut_NORTH(destinationAddressOut_NORTH),
		.requesterAddressOut_NORTH(requesterAddressOut_NORTH),
		.readOut_NORTH(readOut_NORTH),
		.writeOut_NORTH(writeOut_NORTH),
		.dataOut_NORTH(dataOut_NORTH),
	
		//South port (2)
		.portEnable_SOUTH(portEnable_SOUTH),
		.destinationAddressIn_SOUTH(destinationAddressIn_SOUTH),
		.requesterAddressIn_SOUTH(requesterAddressIn_SOUTH),
		.readIn_SOUTH(readIn_SOUTH),
		.writeIn_SOUTH(writeIn_SOUTH),
		.dataIn_SOUTH(dataIn_SOUTH),
		
		.destinationAddressOut_SOUTH(destinationAddressOut_SOUTH),
		.requesterAddressOut_SOUTH(requesterAddressOut_SOUTH),
		.readOut_SOUTH(readOut_SOUTH),
		.writeOut_SOUTH(writeOut_SOUTH),
		.dataOut_SOUTH(dataOut_SOUTH),
		
		//East port (3)
		.portEnable_EAST(portEnable_EAST),
		.destinationAddressIn_EAST(destinationAddressIn_EAST),
		.requesterAddressIn_EAST(requesterAddressIn_EAST),
		.readIn_EAST(readIn_EAST),
		.writeIn_EAST(writeIn_EAST),
		.dataIn_EAST(dataIn_EAST),
		
		.destinationAddressOut_EAST(destinationAddressOut_EAST),
		.requesterAddressOut_EAST(requesterAddressOut_EAST),
		.readOut_EAST(readOut_EAST),
		.writeOut_EAST(writeOut_EAST),
		.dataOut_EAST(dataOut_EAST),
		
		//West port (4)
		.portEnable_WEST(portEnable_WEST),
		.destinationAddressIn_WEST(destinationAddressIn_WEST),
		.requesterAddressIn_WEST(requesterAddressIn_WEST),
		.readIn_WEST(readIn_WEST),
		.writeIn_WEST(writeIn_WEST),
		.dataIn_WEST(dataIn_WEST),
		
		.destinationAddressOut_WEST(destinationAddressOut_WEST),
		.requesterAddressOut_WEST(requesterAddressOut_WEST),
		.readOut_WEST(readOut_WEST),
		.writeOut_WEST(writeOut_WEST),
		.dataOut_WEST(dataOut_WEST),
		
		//Cache bank IO
		.cacheDataOut(cacheDataOut),
	
		.cacheAddress(cacheAddress),
		.cacheDataIn(cacheDataIn),
		.memRead(memRead),
		.memWrite(memWrite)
		);
	
	initial
	begin
		clk <= 0;
		reset <= 1;
		
		#2
		//Set packet destinations
		writeIn_NORTH <= 1;
		dataIn_NORTH <= 2;
		destinationAddressIn_NORTH <= 4'd2;
		
		writeIn_SOUTH <= 1;
		dataIn_SOUTH <= 4;
		destinationAddressIn_SOUTH <= 4'd4;
		
		writeIn_EAST <= 1;
		dataIn_EAST <= 8;
		destinationAddressIn_EAST <= 4'd8;
		
		writeIn_WEST <= 1;
		dataIn_WEST <= 6;
		destinationAddressIn_WEST <= 4'd6;
		#1
		
		reset <= 0;
		
		#7
		$finish;
	end
	
	//Clock toggling
	always begin
		#1  //2-step period
		clk <= ~clk;
	end

endmodule
