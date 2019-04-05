/*
 * Cache Access Arbiter
 *
 * Controls read and write requests to the cache block associated with this router
 * Buffers access requests (NOT YET IMPLIMENTED)
 */
 
 
`include "globalVariables.v"


module cacheAccessArbiter(
	input clk,
	input reset,
	
	//Input from North Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input memRead_NORTH,
	input memWrite_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,
	
	output reg readReady_NORTH,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH,
	
	//Input from South Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input memRead_SOUTH,
	input memWrite_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
	
	output reg readReady_SOUTH,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH,
	
	//Input from East Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input memRead_EAST,
	input memWrite_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
	
	output reg readReady_EAST,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST,
	
	//Input from West Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input memRead_WEST,
	input memWrite_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
	
	output reg readReady_WEST,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST,
	
	//Cache bank IO
	output reg [`DATA_WIDTH -1:0] cacheDataIn,
	output reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheWriteAddressIn,
	output wire memRead,
	output reg memWrite,
	
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_0,  //North's port
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_1,  //South's port
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_2,  //East's port
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_3  //West's port
	);
	
	
	wire [3:0] localWrites = {memWrite_WEST, memWrite_EAST, memWrite_SOUTH, memWrite_NORTH};  //Concatenate local write signals
	
	//Array of wires to concatenate dataIn ports
	wire [`DATA_WIDTH -1:0] dataIn_Concatenated [3:0];
	assign dataIn_Concatenated[0] = dataIn_NORTH;
	assign dataIn_Concatenated[1] = dataIn_SOUTH;
	assign dataIn_Concatenated[2] = dataIn_EAST;
	assign dataIn_Concatenated[3] = dataIn_WEST;
	
	//Array of wires to concatenate cacheAddressIn ports
	wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddress_Concatenated [3:0];
	assign cacheAddress_Concatenated[0] = cacheAddressIn_NORTH;
	assign cacheAddress_Concatenated[1] = cacheAddressIn_SOUTH;
	assign cacheAddress_Concatenated[2] = cacheAddressIn_EAST;
	assign cacheAddress_Concatenated[3] = cacheAddressIn_WEST;
	
	//Read wire assignments
	assign memRead = memRead_WEST || memRead_EAST|| memRead_SOUTH || memRead_NORTH;
	assign cacheReadAddress_0 = cacheAddressIn_NORTH;
	assign cacheReadAddress_1 = cacheAddressIn_SOUTH;
	assign cacheReadAddress_2 = cacheAddressIn_EAST;
	assign cacheReadAddress_3 = cacheAddressIn_WEST;
	
	//Store request variables so we know where to send read reults
	reg prevMemRead_NORTH;
	reg prevMemRead_SOUTH;
	reg prevMemRead_EAST;
	reg prevMemRead_WEST;
	
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_NORTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_SOUTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_EAST;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_WEST;
	
	//Buffers for write requests
	reg [`DATA_WIDTH -1:0] dataToWriteBuffer [`BUFFER_SIZE-1 :0];	
	reg [`NETWORK_ADDRESS_WIDTH -1:0] addressToWriteBuffer [`BUFFER_SIZE-1:0];
	reg [1:0] isReadOrWrite [`BUFFER_SIZE-1:0];
	//reg [`BUFFER_SIZE-1:0] bufferWrittenToTracker;
	reg [`BIT_SIZE-1:0] nextEmptyBuffer;
	
	
	//Calculate total writes requested in this cycle
	reg [2:0] totalWrites;
	integer l;
	always@(localWrites) begin
	    	totalWrites = 0;
	    	for(l=0;l<4;l=l+1) totalWrites = totalWrites + localWrites[l];
	end

	/*
	 * Determine where to place new write requests in the buffer
	 */
	 
		//Incrementer for North buffer index
	wire [1:0] indexIncrementer_NORTH = 2'd0; 
	
		//Incrementer for South buffer index
	reg [1:0] indexIncrementer_SOUTH; 
	integer m;
	always@(localWrites) begin
	    	indexIncrementer_SOUTH = 0;
	    	for(m=0; m<1;m=m+1) indexIncrementer_SOUTH = indexIncrementer_SOUTH + localWrites[m];
	end
	
		//Incrementer for East buffer index
	reg [1:0] indexIncrementer_EAST; 
	integer n;
	always@(localWrites) begin
	    	indexIncrementer_EAST = 0;  
	    	for(n=0;n<2;n=n+1) indexIncrementer_EAST = indexIncrementer_EAST + localWrites[n];
	end
	
		//Incrementer for West buffer index
	reg [1:0] indexIncrementer_WEST; 
	integer p;
	always@(localWrites) begin
	    	indexIncrementer_WEST = 0;
	    	for(p=0;p<3;p=p+1) indexIncrementer_WEST = indexIncrementer_WEST + localWrites[p];
	end
	
		//Wire array to combine increment values
	wire [1:0] incrementerArray [3:0];
	assign incrementerArray[0] = indexIncrementer_NORTH;
	assign incrementerArray[1] = indexIncrementer_SOUTH;
	assign incrementerArray[2] = indexIncrementer_EAST;
	assign incrementerArray[3] = indexIncrementer_WEST;

	//Falling edge events
	integer i;
	integer j;
	integer k;	
	always @ (negedge clk) begin
		//Synchronous reset
		if (reset) begin
			cacheDataIn <= 0;
			cacheWriteAddressIn <= 0;
			memWrite <= 0;
			
			prevMemRead_NORTH <= 0;
			prevMemRead_SOUTH <= 0;
			prevMemRead_EAST <= 0;
			prevMemRead_WEST <= 0;
			
			nextEmptyBuffer <= 0;
		end
		
		else begin 
			if (|(totalWrites)) nextEmptyBuffer <= nextEmptyBuffer + totalWrites - 1;
						
			//Nothing currently in buffer, regularly send out data as was being sent out in router.v
			if (nextEmptyBuffer == 0) begin
				case (localWrites)
					//No local writes
					4'b0000 : begin
						memWrite <= 0;
					end
					//Write from north port
					4'b0001 : begin
						memWrite <= 1;
						cacheDataIn <= dataIn_NORTH;
						cacheWriteAddressIn <= cacheAddressIn_NORTH;
					end
					//Write from south port
					4'b0010 : begin
						memWrite <= 1;
						cacheDataIn <= dataIn_SOUTH;
						cacheWriteAddressIn <= cacheAddressIn_SOUTH;
					end
					//Write from east port
					4'b0100 : begin
						memWrite <= 1;
						cacheDataIn <= dataIn_EAST;
						cacheWriteAddressIn <= cacheAddressIn_EAST;
					end
					//Write from west port
					4'b1000 : begin
						memWrite <= 1;
						cacheDataIn <= dataIn_WEST;
						cacheWriteAddressIn <= cacheAddressIn_WEST;
					end
					//Multiple writes
					default : begin
						for (i=0; i < 4; i=i+1) begin
							if ((incrementerArray[i] == 0) && (localWrites[i])) begin
								memWrite <= 1;
								cacheDataIn <= dataIn_Concatenated[i];
								cacheWriteAddressIn <= cacheAddress_Concatenated[i];
							end
							else if (localWrites[i]) begin
								dataToWriteBuffer[nextEmptyBuffer + incrementerArray[i] - 1] <= dataIn_Concatenated[i];
								addressToWriteBuffer[nextEmptyBuffer + incrementerArray[i] - 1] <= cacheAddress_Concatenated[i];
							end
						end
					end
				endcase
			end
			
			//Buffer has something in it
			else begin 
				//Write any new requests to the next availible buffers
				for (j=0; j < 4; j=j+1) begin
					if (localWrites[j]) begin
						dataToWriteBuffer[nextEmptyBuffer + incrementerArray[j] -1] <= dataIn_Concatenated[j];
						addressToWriteBuffer[nextEmptyBuffer + incrementerArray[j] -1] <= cacheAddress_Concatenated[j];
					end
				end
								
				//Shift buffer contents as 0th packet is sent
				for (k=0; k < `BUFFER_SIZE-1; k=k+1) begin
					if (k==0) begin
						//cacheDataIn <= 6'd42;
						cacheDataIn <= dataToWriteBuffer[k];
						cacheWriteAddressIn <= addressToWriteBuffer[k];
					end
					if (k<nextEmptyBuffer-1) begin 
						dataToWriteBuffer[k] <= dataToWriteBuffer[k+1];
						addressToWriteBuffer[k] <= addressToWriteBuffer[k+1];
					end
					
				end	
			end
			
			//Store request variables so we know where to send read reults
			prevMemRead_NORTH <= memRead_NORTH;
			prevMemRead_SOUTH <= memRead_SOUTH;
			prevMemRead_EAST <= memRead_EAST;
			prevMemRead_WEST <= memRead_WEST;
			
			prevRequesterAddress_NORTH <= requesterAddressIn_NORTH;
			prevRequesterAddress_SOUTH <= requesterAddressIn_SOUTH;
			prevRequesterAddress_EAST <= requesterAddressIn_EAST;
			prevRequesterAddress_WEST <= requesterAddressIn_WEST;
		end
	end
	
	//Rising edge events
	always @ (posedge clk) begin
		//Update request variables on rising edge
		readReady_NORTH <= prevMemRead_NORTH;
		requesterAddressOut_NORTH <= prevRequesterAddress_NORTH;
		
		readReady_SOUTH <= prevMemRead_SOUTH;
		requesterAddressOut_SOUTH <= prevRequesterAddress_SOUTH;
		
		readReady_EAST <= prevMemRead_EAST;
		requesterAddressOut_EAST <= prevRequesterAddress_EAST;
		
		readReady_WEST <= prevMemRead_WEST;
		requesterAddressOut_WEST <= prevRequesterAddress_WEST;
	end	
endmodule 
