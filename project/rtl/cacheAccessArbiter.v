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
	
	//North Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input memRead_NORTH,
	input memWrite_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,
	
	output wire readReady_NORTH,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH,
	output wire [`DATA_WIDTH -1:0] cacheDataOut_NORTH,
	
	//South Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input memRead_SOUTH,
	input memWrite_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
	
	output wire readReady_SOUTH,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH,
	output wire [`DATA_WIDTH -1:0] cacheDataOut_SOUTH,
	
	//East Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input memRead_EAST,
	input memWrite_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
	
	output wire readReady_EAST,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST,
	output wire [`DATA_WIDTH -1:0] cacheDataOut_EAST,
	
	//West Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input memRead_WEST,
	input memWrite_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
	
	output wire readReady_WEST,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST,
	output wire [`DATA_WIDTH -1:0] cacheDataOut_WEST,
		
	//Cache bank IO
	output reg [`DATA_WIDTH -1:0] cacheDataIn_A,
	output reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A,
	input [`DATA_WIDTH -1:0] cacheDataOut_A,
	output reg memWrite_A,
	
	output reg [`DATA_WIDTH -1:0] cacheDataIn_B,
	output reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B,
	input [`DATA_WIDTH -1:0] cacheDataOut_B,
	output reg memWrite_B
	);
	
	
	wire [3:0] localWrites = {memWrite_WEST, memWrite_EAST, memWrite_SOUTH, memWrite_NORTH};  //Concatenate local write signals
	wire [3:0] localAccessRequests = {memWrite_WEST || memRead_WEST, memWrite_EAST || memRead_EAST, memWrite_SOUTH || memRead_SOUTH, memWrite_NORTH || memRead_NORTH};  //Concatenate local write signals
	
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
	
	//Array of wires to concatenate requesterAddressIn ports
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddress_Concatenated [3:0];
	assign requesterAddress_Concatenated[0] = requesterAddressIn_NORTH;
	assign requesterAddress_Concatenated[1] = requesterAddressIn_SOUTH;
	assign requesterAddress_Concatenated[2] = requesterAddressIn_EAST;
	assign requesterAddress_Concatenated[3] = requesterAddressIn_WEST;
	
	//Array of wires to concatenate dataOut ports
	reg [`DATA_WIDTH -1:0] dataOut_Concatenated [3:0];
	assign cacheDataOut_NORTH = dataOut_Concatenated[0];
	assign cacheDataOut_SOUTH = dataOut_Concatenated[1];
	assign cacheDataOut_EAST = dataOut_Concatenated[2];
	assign cacheDataOut_WEST = dataOut_Concatenated[3];
	
	//Array of wires to concatenate readReady ports
	reg readReady_Concatenated [3:0];
	assign readReady_NORTH = readReady_Concatenated[0];
	assign readReady_SOUTH = readReady_Concatenated[1];
	assign readReady_EAST = readReady_Concatenated[2];
	assign readReady_WEST = readReady_Concatenated[3];
	
	//Array of wires to concatenate requesterAddressOut ports
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_Concatenated [3:0];
	assign requesterAddressOut_NORTH = requesterAddressOut_Concatenated[0];
	assign requesterAddressOut_SOUTH = requesterAddressOut_Concatenated[1];
	assign requesterAddressOut_EAST = requesterAddressOut_Concatenated[2];
	assign requesterAddressOut_WEST = requesterAddressOut_Concatenated[3];
	
	//Read wire assignments
	assign memRead = memRead_WEST || memRead_EAST|| memRead_SOUTH || memRead_NORTH;
	assign cacheReadAddress_0 = cacheAddressIn_NORTH;
	assign cacheReadAddress_1 = cacheAddressIn_SOUTH;
	assign cacheReadAddress_2 = cacheAddressIn_EAST;
	assign cacheReadAddress_3 = cacheAddressIn_WEST;
	
	//Store request variables so we know where to send read reults
	reg prevMemRead_A;
	reg prevMemRead_B;
	
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_A;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_B;
	
	reg [1:0] prevRequesterPort_A;
	reg [1:0] prevRequesterPort_B;
	
	//Buffers for write requests
	reg [`DATA_WIDTH -1:0] dataToWriteBuffer [`BUFFER_SIZE-1 :0];	
	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] addressToWriteBuffer [`BUFFER_SIZE-1:0];
	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] requesterAddressBuffer [`BUFFER_SIZE-1:0];
	reg [1:0] requesterPortBuffer [`BUFFER_SIZE-1:0];
	reg [`BUFFER_SIZE-1:0] isWrite;

	reg [`BIT_SIZE-1:0] nextEmptyBuffer;
	
	
	//Calculate total writes requested in this cycle
	reg [2:0] totalAccesses;
	integer l;
	always@(localAccessRequests) begin
	    	totalAccesses = 0;
	    	for(l=0;l<4;l=l+1) totalAccesses = totalAccesses + localAccessRequests[l];
	end

	/*
	 * Determine where to place new write requests in the buffer
	 */
	 
		//Incrementer for North buffer index
	wire [1:0] indexIncrementer_NORTH = 2'd0; 
	
		//Incrementer for South buffer index
	reg [1:0] indexIncrementer_SOUTH; 
	integer m;
	always@(localAccessRequests) begin
	    	indexIncrementer_SOUTH = 0;
	    	for(m=0; m<1;m=m+1) indexIncrementer_SOUTH = indexIncrementer_SOUTH + localAccessRequests[m];
	end
	
		//Incrementer for East buffer index
	reg [1:0] indexIncrementer_EAST; 
	integer n;
	always@(localAccessRequests) begin
	    	indexIncrementer_EAST = 0;  
	    	for(n=0;n<2;n=n+1) indexIncrementer_EAST = indexIncrementer_EAST + localAccessRequests[n];
	end
	
		//Incrementer for West buffer index
	reg [1:0] indexIncrementer_WEST; 
	integer p;
	always@(localAccessRequests) begin
	    	indexIncrementer_WEST = 0;
	    	for(p=0;p<3;p=p+1) indexIncrementer_WEST = indexIncrementer_WEST + localAccessRequests[p];
	end
	
		//Wire array to combine increment values
	wire [1:0] incrementerArray [3:0];
	assign incrementerArray[0] = indexIncrementer_NORTH;
	assign incrementerArray[1] = indexIncrementer_SOUTH;
	assign incrementerArray[2] = indexIncrementer_EAST;
	assign incrementerArray[3] = indexIncrementer_WEST;
	
		//How far do we shift the buffer
	reg [1:0] bufferShiftAmount;
	always @(nextEmptyBuffer) begin
		bufferShiftAmount =  nextEmptyBuffer > 1 ? 2 : 1;
	end

	//Falling edge events
	integer i;
	integer j;
	integer k;	
	always @ (negedge clk) begin
		//Synchronous reset
		if (reset) begin
			cacheDataIn_A <= 0;
			cacheAddressIn_A <= 0;
			memWrite_A <= 1;

			cacheDataIn_B <= 0;
			cacheAddressIn_B <= 0;
			memWrite_B <= 1;
			
			prevMemRead_A <= 0;
			prevMemRead_B <= 0;
			
			nextEmptyBuffer <= 0;

			for (k=0; k < `BUFFER_SIZE; k=k+1) begin
				dataToWriteBuffer[k] <= 0;
				addressToWriteBuffer[k] <= 0;
				requesterAddressBuffer[k] <= 0;
				isWrite[k] <= 0;
				requesterPortBuffer[k] <= 0;
			end
		end
		
		else begin 
			//if (|(totalAccesses)) nextEmptyBuffer <= nextEmptyBuffer + totalAccesses - 1;
			if ((|(totalAccesses)) || nextEmptyBuffer) nextEmptyBuffer <= nextEmptyBuffer + totalAccesses - bufferShiftAmount;
						
			//Nothing currently in buffer, sound out up to two requests immediately, then buffer the rest
			if (nextEmptyBuffer == 0) begin
				for (i=0; i < 4; i=i+1) begin
					if ((incrementerArray[i] == 0) && (localAccessRequests[i])) begin
						memWrite_A <= ~localWrites[i];  //write is active low in memory module, so we invert our local signal going out
						cacheDataIn_A <= dataIn_Concatenated[i];
						cacheAddressIn_A <= cacheAddress_Concatenated[i];
						prevRequesterAddress_A <= requesterAddress_Concatenated[i];
						prevMemRead_A <= ~localWrites[i];
						prevRequesterPort_A <= i;
					end
					else if ((incrementerArray[i] == 1) && (localAccessRequests[i])) begin
						memWrite_B <= ~localWrites[i];  //write is active low in memory module, so we invert our local signal going out
						cacheDataIn_B <= dataIn_Concatenated[i];
						cacheAddressIn_B <= cacheAddress_Concatenated[i];
						prevRequesterAddress_B <= requesterAddress_Concatenated[i];
						prevMemRead_B <= ~localWrites[i];
						prevRequesterPort_B <= i;
					end
					else if (localAccessRequests[i]) begin
						dataToWriteBuffer[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= dataIn_Concatenated[i];
						addressToWriteBuffer[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= cacheAddress_Concatenated[i];
						requesterAddressBuffer[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= requesterAddress_Concatenated[i];
						isWrite[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= localWrites[i];
						requesterPortBuffer[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= i;
					end
				end
				
				if (totalAccesses == 0) begin
					prevMemRead_A <= 0;
					prevMemRead_B <= 0;
				end 
				if (totalAccesses == 1) begin
					prevMemRead_B <= 0;
				end 
			end
			
			//Buffer has something in it
			else begin 
				//Write any new requests to the next availible buffers
				for (j=0; j < 4; j=j+1) begin
					if (localAccessRequests[j]) begin
						dataToWriteBuffer[nextEmptyBuffer + incrementerArray[j] - bufferShiftAmount] <= dataIn_Concatenated[j];
						addressToWriteBuffer[nextEmptyBuffer + incrementerArray[j] - bufferShiftAmount] <= cacheAddress_Concatenated[j];
						requesterAddressBuffer[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= requesterAddress_Concatenated[j];
						isWrite[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= localWrites[j];
						requesterPortBuffer[nextEmptyBuffer + incrementerArray[i] - bufferShiftAmount] <= j;
					end
				end
								
				//Shift buffer contents as 0th packet is sent
				for (k=0; k < `BUFFER_SIZE; k=k+1) begin
					if (k==0) begin
						memWrite_A <= ~isWrite[k];
						cacheDataIn_A <= dataToWriteBuffer[k];
						cacheAddressIn_A <= addressToWriteBuffer[k];
						prevRequesterAddress_A <= requesterAddressBuffer[k];
						prevMemRead_A <= ~isWrite[k];
						prevRequesterPort_A <= requesterPortBuffer[k];
					end
					
					if ((k==1) && (nextEmptyBuffer > 1)) begin  //buffer has at least 2 requests in it. Send 2nd request
						memWrite_B <= ~isWrite[k];
						cacheDataIn_B <= dataToWriteBuffer[k];
						cacheAddressIn_B <= addressToWriteBuffer[k];
						prevRequesterAddress_B <= requesterAddressBuffer[k];
						prevMemRead_B <= ~isWrite[k];
						prevRequesterPort_B <= requesterPortBuffer[k];
					end
					else begin
						prevMemRead_B <= 0;
					end
					
					if (k<`BUFFER_SIZE-bufferShiftAmount-1) begin 
						dataToWriteBuffer[k] <= dataToWriteBuffer[k+bufferShiftAmount];
						addressToWriteBuffer[k] <= addressToWriteBuffer[k+bufferShiftAmount];
						requesterAddressBuffer[k] <= requesterAddress_Concatenated[k+bufferShiftAmount];
						isWrite[k] <= isWrite[k+bufferShiftAmount];
						requesterPortBuffer[k] <= requesterPortBuffer[k+bufferShiftAmount];
					end
					
					if (k == `BUFFER_SIZE-1) begin 
						dataToWriteBuffer[k] <= 0;
						addressToWriteBuffer[k] <= 0;
						requesterAddressBuffer[k] <= 0;
						isWrite[k] <= 0;
						requesterPortBuffer[k] <= 0;
					end
				end	
			end
		end
	end
	
	//Rising edge events
	integer q;
	always @ (posedge clk) begin
		if (reset) begin
			requesterAddressOut_Concatenated[0] <= 0;
			requesterAddressOut_Concatenated[1] <= 0;
			requesterAddressOut_Concatenated[2] <= 0;
			requesterAddressOut_Concatenated[3] <= 0;
		end
		
		else begin
			//Update request variables on rising edge
			for (q=0; q<4; q=q+1) begin
				if (prevRequesterPort_A == q) begin
					readReady_Concatenated[q] <= prevMemRead_A;
					requesterAddressOut_Concatenated[q] <= prevRequesterAddress_A;
				end
				else if (prevRequesterPort_B == q) begin
					readReady_Concatenated[q] <= prevMemRead_B;
					requesterAddressOut_Concatenated[q] <= prevRequesterAddress_B;
				end
				else begin
					readReady_Concatenated[q] <= 0;
				end
			end
		end
	end
	
	integer r;
	always @ (*) begin
		if (clk) begin
			for (r=0; r<4; r=r+1) begin
				if (prevRequesterPort_A == q) begin
					dataOut_Concatenated[q] = cacheDataOut_A;
				end
				else if (prevRequesterPort_B == q) begin
					dataOut_Concatenated[q] = cacheDataOut_B;
				end
				else begin
					dataOut_Concatenated[q] = 0;
				end
			end
		end
	end	
endmodule 

