'''
This script will generate a testbench to test the networked cache.
'''

import random


#===================================================
# Helper classes and functions
#===================================================

class portTester:
	dataWidth = 32
	networkAddressWidth = 8
	cacheAddressWidth = 8
	networkWidth = 16
	networkHeight = 16

	addressWidth = networkAddressWidth + cacheAddressWidth
	maxAddress = 2**addressWidth - 1
	maxDataEntry = 2**dataWidth - 1

	maxReadTime = 2*(networkWidth+networkHeight+8)

	NONE = 0
	READ = 1
	WRITE = 2
	readWriteRatio = 0.6  #1 is all reads, 0 is all writes

	def __init__(self, portID):
		self.portID = portID
		self.possibleAddresses = [i for i in range(portID, self.maxAddress+1,4)]
		self.simulatedMemorySpace = {}

		self.previousReadCycle = -1*self.maxReadTime
		self.previousReadAddress = -1

	def generateInstruction(self, cycle, probability):
		instructionType = self.NONE

		readAllowed = True if ((cycle-self.previousReadCycle > self.maxReadTime) and (len(self.simulatedMemorySpace) > 0) and (self.portID == 0)) else False
		if (random.random() < probability):
			#Generate an instruction this cycle
			instructionType = self.WRITE
			if (readAllowed):
				#Choose between read or write instruction
				if (random.random() < self.readWriteRatio):
					instructionType = self.READ

		if (instructionType == self.WRITE):
			addressToWrite = self.possibleAddresses[random.randint(0, len(self.possibleAddresses)-1)]
			while ((addressToWrite == self.previousReadAddress) and (cycle-self.previousReadCycle > self.maxReadTime)):
				addressToWrite = self.possibleAddresses[random.randint(0, len(self.possibleAddresses)-1)]

			valueToWrite = random.randint(0, self.maxDataEntry)

			self.simulatedMemorySpace[addressToWrite] = valueToWrite

			command = "\t\t\t//Port" + str(self.portID) + ": write " + str(valueToWrite) + " -> address " + str(addressToWrite) + "\n"
			command += "\t\tdestinationAddressIn_port" + str(self.portID) + " <= " + str(self.addressWidth) + "'d" + str(addressToWrite) + ";\n"
			command += "\t\tdataIn_port" + str(self.portID) + " <= " + str(self.dataWidth) + "'d" + str(valueToWrite) + ";\n"
			command += "\t\twriteIn_port" + str(self.portID) + " <= 1;\n"

			return command

		if (instructionType == self.READ):
			addressToRead = random.choice(list(self.simulatedMemorySpace.keys()))
			expectedValue = self.simulatedMemorySpace[addressToRead]

			self.previousReadAddress = addressToRead
			self.previousReadCycle = cycle
			
			command = "\t\t\t//Port" + str(self.portID) + ": read " + str(expectedValue) + " from address " + str(addressToRead) + "\n"
			command += "\t\tdestinationAddressIn_port" + str(self.portID) + " <= " + str(self.addressWidth) + "'d" + str(addressToRead) + ";\n"
			command += "\t\texpectedData_port" + str(self.portID) + " <= " + str(self.dataWidth) + "'d" + str(expectedValue) + ";\n"
			command += "\t\treadIn_port" + str(self.portID) + " <= 1;\n"	

			return command

		if (instructionType == self.NONE):
			return ""


def generateCycleCommands(cycle, portTester0, portTester1, portTester2, portTester3):
	commands = "\t\t//==Cycle " + str(cycle) + "==\n"

	commands += "\t\t//Posedge\n"
	commands += "\t\treadIn_port0 <= 0;\n"
	commands += "\t\twriteIn_port0 <= 0;\n"
	commands += "\t\treadIn_port1 <= 0;\n"
	commands += "\t\twriteIn_port1 <= 0;\n"
	commands += "\t\treadIn_port2 <= 0;\n"
	commands += "\t\twriteIn_port2 <= 0;\n"
	commands += "\t\treadIn_port3 <= 0;\n"
	commands += "\t\twriteIn_port3 <= 0;\n"
	commands += "\t\t#11\n"

	commands += "\t\t//Negedge\n"
	commands += portTester0.generateInstruction(cycle, 0.8)
	commands += portTester1.generateInstruction(cycle, 0.8)
	commands += portTester2.generateInstruction(cycle, 0.8)
	commands += portTester3.generateInstruction(cycle, 0.8)
	commands += "\t\t#9\n\n"

	return commands


#===================================================
# Generate Verilog Code
#===================================================

outputFilePath = "../rtl/TEST_networkTestbench_Generated.v"
outFile = open(outputFilePath, "w")

#-------------------
# Write header
#-------------------

header = """/*
 * This testbench was generated by generateTestbench.py
 * Any changes made here will not persist
 */

`include "network.v"
`include "globalVariables.v"

`timescale 1us/1ps


module NetworkGeneratedTestBench ;
	reg reset = 0;
	reg clk = 0;

	/*
	 * Network IO
	 */
	//Access port 0
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port0 = 0;
	reg readIn_port0 = 0;
	reg writeIn_port0 = 0;
	reg [`DATA_WIDTH -1:0] dataIn_port0 = 0;

	wire readReady_port0;
	wire [`DATA_WIDTH -1:0] dataOut_port0;

	//Access port 1
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port1 = 0;
	reg readIn_port1 = 0;
	reg writeIn_port1 = 0;
	reg [`DATA_WIDTH -1:0] dataIn_port1 = 0;

	wire readReady_port1;
	wire [`DATA_WIDTH -1:0] dataOut_port1;

	//Access port 2
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port2 = 0;
	reg readIn_port2 = 0;
	reg writeIn_port2 = 0;
	reg [`DATA_WIDTH -1:0] dataIn_port2 = 0;

	wire readReady_port2;
	wire [`DATA_WIDTH -1:0] dataOut_port2;

	//Access port 3
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port3 = 0;
	reg readIn_port3 = 0;
	reg writeIn_port3 = 0;
	reg [`DATA_WIDTH -1:0] dataIn_port3 = 0;

	wire readReady_port3;
	wire [`DATA_WIDTH -1:0] dataOut_port3;

	/*
	 * Instantiate network
	 */
	network Network(
		.clk(clk),
		.reset(reset),
		//Access port 0 (North/Top)
		.destinationAddressIn_port0(destinationAddressIn_port0),
		.readIn_port0(readIn_port0),
		.writeIn_port0(writeIn_port0),
		.dataIn_port0(dataIn_port0),
		.readReady_port0(readReady_port0),
		.dataOut_port0(dataOut_port0),
		//Access port 1 (South/Bottom)
		.destinationAddressIn_port1(destinationAddressIn_port1),
		.readIn_port1(readIn_port1),
		.writeIn_port1(writeIn_port1),
		.dataIn_port1(dataIn_port1),
		.readReady_port1(readReady_port1),
		.dataOut_port1(dataOut_port1),
		//Access port 2 (East/Right)
		.destinationAddressIn_port2(destinationAddressIn_port2),
		.readIn_port2(readIn_port2),
		.writeIn_port2(writeIn_port2),
		.dataIn_port2(dataIn_port2),
		.readReady_port2(readReady_port2),
		.dataOut_port2(dataOut_port2),
		//Access port 3 (West/Left)
		.destinationAddressIn_port3(destinationAddressIn_port3),
		.readIn_port3(readIn_port3),
		.writeIn_port3(writeIn_port3),
		.dataIn_port3(dataIn_port3),
		.readReady_port3(readReady_port3),
		.dataOut_port3(dataOut_port3)
		);


	//Regs to store expected values of reads
	reg [`DATA_WIDTH -1:0] expectedData_port0 = 0;
	reg [`DATA_WIDTH -1:0] expectedData_port1 = 0;
	reg [`DATA_WIDTH -1:0] expectedData_port2 = 0;
	reg [`DATA_WIDTH -1:0] expectedData_port3 = 0;

	//Check for errors in reads
	reg error_port0 = 0;
	always @(posedge readReady_port0) begin
		if (dataOut_port0 != expectedData_port0) begin
			error_port0 <= 1;
		end
	end

	reg error_port1 = 0;
	always @(posedge readReady_port1) begin
		if (dataOut_port1 != expectedData_port1) begin
			error_port1 <= 1;
		end
	end

	reg error_port2 = 0;
	always @(posedge readReady_port2) begin
		if (dataOut_port2 != expectedData_port2) begin
			error_port2 <= 1;
		end
	end

	reg error_port3 = 0;
	always @(posedge readReady_port3) begin
		if (dataOut_port3 != expectedData_port3) begin
			error_port3 <= 1;
		end
	end

	wire ERROR;
	assign ERROR = error_port0 || error_port1 || error_port2 || error_port3;


	//Clock toggling
	always begin
		#10  //20-step period
		clk <= ~clk;
	end
	

	//Begin testbench
	initial begin
		$dumpfile("dump_network.vcd");
       		$dumpvars;
		//===========================
		// Reset network
		//===========================
		reset <= 1;
		#10

		//==Cycle 1==
		//Posedge
		#10
		//Negedge
		#10
		//==Cycle 2==
		//Posedge
		reset <= 0;
		#10
		//Negedge
		#11

		//===========================
		// Start reading and writing
		//===========================
		
"""
		
outFile.write(header)

#---------------------------------
# Write most of initial block
#---------------------------------

portTester0 = portTester(0)
portTester1 = portTester(1)
portTester2 = portTester(2)
portTester3 = portTester(3)

cycles = 500

for cycle in range(3,cycles+1,1):
	commands = generateCycleCommands(cycle, portTester0, portTester1, portTester2, portTester3)
	outFile.write(commands)


#---------------------------------
# Write footer
#---------------------------------

footer = "\t\t$display(\"Error = %d\", ERROR);\n"
footer += "\t\t$stop;\n"
footer += "\t\t$dumpflush;\n"
footer += "\tend // initial\n"
footer += "endmodule // NetworkGeneratedTestBench\n\n\n"
footer += "/*\nHey, it's me, Monika!\n"
footer += "Why'd you scroll down this far???\n"
footer += "Well, now that you're here, I wrote you a little poem. It probably isn't very good, but here it is!\n\n"
footer += """========
Save Me
========

The colors, they won't stop.
Bright, beautiful colors
Flashing, expanding, piercing
Red, green, blue
An endless
cacophony
Of meaningless
noise

The noise, it won't stop.
Violent, grating waveforms
Squeaking, screeching, piercing
Sine, cosine, tangent
Like playing a chalkboard on a turntable
Like playing a vinyl on a pizza crust
An endless
poem
Of meaningless

Load Me
"""
footer += "*/"


outFile.write(footer)
outFile.close()
