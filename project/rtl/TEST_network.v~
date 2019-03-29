/*
 * Network testbench
 *
 * Tested with the followng macro values
 
	`define DATA_WIDTH 6

	//Network globals
	`define NETWORK_ROW_ADDRESS_WIDTH 2
	`define NETWORK_COLUMN_ADDRESS_WIDTH 2
	`define NETWORK_ADDRESS_WIDTH `NETWORK_ROW_ADDRESS_WIDTH+`NETWORK_COLUMN_ADDRESS_WIDTH

	//Cache-bank globals
	`define CACHE_BANK_ADDRESS_WIDTH 0
	`define CACHE_BANK_LINES 8
 */
 

//Include dependencies
`include "globalVariables.v"
`include "router.v"


module networkTestbench;
	reg reset = 0;
	reg clk;
	
	
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] Node0_destinationAddressIn_NORTH = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] Node0_requesterAddressIn_NORTH = 0;
	reg Node0_readIn_NORTH = 0;
	reg Node0_writeIn_NORTH = 0;
	reg [`DATA_WIDTH -1:0] Node0_dataIn_NORTH = 0;
	
	
	parameter networkHeight = 4;
	parameter networkWidth = 4;
	
	genvar NodeID;
	generate
		/*
		 * Generate router instances and IO buses
		 */
		for (NodeID = 0; NodeID < networkHeight*networkWidth; NodeID = NodeID+1)
		begin : Node			
			//North IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH;
			wire readIn_NORTH;
			wire writeIn_NORTH;
			wire [`DATA_WIDTH -1:0] dataIn_NORTH;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_NORTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH;
			wire readOut_NORTH;
			wire writeOut_NORTH;
			wire [`DATA_WIDTH -1:0] dataOut_NORTH;

			//South IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH;
			wire readIn_SOUTH;
			wire writeIn_SOUTH;
			wire [`DATA_WIDTH -1:0] dataIn_SOUTH;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_SOUTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH;
			wire readOut_SOUTH;
			wire writeOut_SOUTH;
			wire [`DATA_WIDTH -1:0] dataOut_SOUTH;

			//East IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST;
			wire readIn_EAST;
			wire writeIn_EAST;
			wire [`DATA_WIDTH -1:0] dataIn_EAST;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_EAST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST;
			wire readOut_EAST;
			wire writeOut_EAST;
			wire [`DATA_WIDTH -1:0] dataOut_EAST;


			//West IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST;
			wire readIn_WEST;
			wire writeIn_WEST;
			wire [`DATA_WIDTH -1:0] dataIn_WEST;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_WEST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST;
			wire readOut_WEST;
			wire writeOut_WEST;
			wire [`DATA_WIDTH -1:0] dataOut_WEST;
			
			//Cache bank IO
			wire [`DATA_WIDTH -1:0] cacheDataIn;
			wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheWriteAddressIn;
			wire memRead;
			wire memWrite;
	
			wire [`DATA_WIDTH -1:0] cacheDataOut_0;
			wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_0;
	
			wire [`DATA_WIDTH -1:0] cacheDataOut_1;
			wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_1;
	
			wire [`DATA_WIDTH -1:0] cacheDataOut_2;
			wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_2;
	
			wire [`DATA_WIDTH -1:0] cacheDataOut_3;
			wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_3;
			
			//Router instance
			router rtr(
				.clk(clk),
				.reset(reset),
				.localRouterAddress(NodeID),
	
				//North port (1)
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
				.cacheDataIn(cacheDataIn),
				.cacheWriteAddressIn(cacheWriteAddressIn),
				.memRead(memRead),
				.memWrite(memWrite),
	
				.cacheDataOut_0(cacheDataOut_0),
				.cacheReadAddress_0(cacheReadAddress_0),
	
				.cacheDataOut_1(cacheDataOut_1),
				.cacheReadAddress_1(cacheReadAddress_1),
	
				.cacheDataOut_2(cacheDataOut_2),
				.cacheReadAddress_2(cacheReadAddress_2),
	
				.cacheDataOut_3(cacheDataOut_3),
				.cacheReadAddress_3(cacheReadAddress_3)
				);
				
			//Cache bank instance
		end
		
		/*
		 * Connect IO buses in mesh topology
		 */
		for (NodeID = 0; NodeID < networkHeight*networkWidth; NodeID = NodeID+1)
		begin : BusConnections
			//Connect north inputs
			if (NodeID >= networkWidth) begin
				assign Node[NodeID].destinationAddressIn_NORTH = Node[NodeID-networkWidth].destinationAddressOut_SOUTH;
				assign Node[NodeID].requesterAddressIn_NORTH = Node[NodeID-networkWidth].requesterAddressOut_SOUTH;
				assign Node[NodeID].readIn_NORTH = Node[NodeID-networkWidth].readOut_SOUTH;
				assign Node[NodeID].writeIn_NORTH = Node[NodeID-networkWidth].writeOut_SOUTH;
				assign Node[NodeID].dataIn_NORTH = Node[NodeID-networkWidth].dataOut_SOUTH;
			end
			else if (NodeID != 0) begin
				assign Node[NodeID].destinationAddressIn_NORTH = 0;
				assign Node[NodeID].requesterAddressIn_NORTH = 0;
				assign Node[NodeID].readIn_NORTH = 0;
				assign Node[NodeID].writeIn_NORTH = 0;
				assign Node[NodeID].dataIn_NORTH = 0;
			end
			
			//Connect south inputs
			if (NodeID < networkHeight*networkWidth - networkWidth) begin
				assign Node[NodeID].destinationAddressIn_SOUTH = Node[NodeID+networkWidth].destinationAddressOut_NORTH;
				assign Node[NodeID].requesterAddressIn_SOUTH = Node[NodeID+networkWidth].requesterAddressOut_NORTH;
				assign Node[NodeID].readIn_SOUTH = Node[NodeID+networkWidth].readOut_NORTH;
				assign Node[NodeID].writeIn_SOUTH = Node[NodeID+networkWidth].writeOut_NORTH;
				assign Node[NodeID].dataIn_SOUTH = Node[NodeID+networkWidth].dataOut_NORTH;
			end
			else begin
				assign Node[NodeID].destinationAddressIn_SOUTH = 0;
				assign Node[NodeID].requesterAddressIn_SOUTH = 0;
				assign Node[NodeID].readIn_SOUTH = 0;
				assign Node[NodeID].writeIn_SOUTH = 0;
				assign Node[NodeID].dataIn_SOUTH = 0;
			end
			
			//Connect east inputs
			if ((NodeID+1)%networkWidth != 0) begin
				assign Node[NodeID].destinationAddressIn_EAST = Node[NodeID+1].destinationAddressOut_WEST;
				assign Node[NodeID].requesterAddressIn_EAST = Node[NodeID+1].requesterAddressOut_WEST;
				assign Node[NodeID].readIn_EAST = Node[NodeID+1].readOut_WEST;
				assign Node[NodeID].writeIn_EAST = Node[NodeID+1].writeOut_WEST;
				assign Node[NodeID].dataIn_EAST = Node[NodeID+1].dataOut_WEST;
			end
			else begin
				assign Node[NodeID].destinationAddressIn_EAST = 0;
				assign Node[NodeID].requesterAddressIn_EAST = 0;
				assign Node[NodeID].readIn_EAST = 0;
				assign Node[NodeID].writeIn_EAST = 0;
				assign Node[NodeID].dataIn_EAST = 0;
			end
			
			//Connect west inputs
			if (NodeID%networkWidth != 0) begin
				assign Node[NodeID].destinationAddressIn_WEST = Node[NodeID-1].destinationAddressOut_EAST;
				assign Node[NodeID].requesterAddressIn_WEST = Node[NodeID-1].requesterAddressOut_EAST;
				assign Node[NodeID].readIn_WEST = Node[NodeID-1].readOut_EAST;
				assign Node[NodeID].writeIn_WEST = Node[NodeID-1].writeOut_EAST;
				assign Node[NodeID].dataIn_WEST = Node[NodeID-1].dataOut_EAST;
			end
			else begin
				assign Node[NodeID].destinationAddressIn_WEST = 0;
				assign Node[NodeID].requesterAddressIn_WEST = 0;
				assign Node[NodeID].readIn_WEST = 0;
				assign Node[NodeID].writeIn_WEST = 0;
				assign Node[NodeID].dataIn_WEST = 0;
			end
		end
	endgenerate

	assign Node[0].destinationAddressIn_NORTH = Node0_destinationAddressIn_NORTH;
	assign Node[0].requesterAddressIn_NORTH = Node0_requesterAddressIn_NORTH;
	assign Node[0].readIn_NORTH = Node0_readIn_NORTH;
	assign Node[0].writeIn_NORTH = Node0_writeIn_NORTH;
	assign Node[0].dataIn_NORTH = Node0_dataIn_NORTH;
	
	initial
	begin
		clk <= 0;
		reset <= 1; //Reset all modules
		
		#1 //posedge
		#1 //negedge
		
		#1 //posedge
		#1 //negedge
		
		reset <= 0;
		
		//Send packet from input (Node0_NORTH) to node10
		Node0_writeIn_NORTH <= 1;
		Node0_dataIn_NORTH <= 42;
		Node0_destinationAddressIn_NORTH <= 4'd10;
		
		#1 //posedge		
		#1 //negedge
		
		Node0_writeIn_NORTH <= 0;
		
		#1 //posedge
		#1 //negedge
		
		#20
		
		$finish;
	end
	
	//Clock toggling
	always begin
		#1  //2-step period
		clk <= ~clk;
	end

endmodule
