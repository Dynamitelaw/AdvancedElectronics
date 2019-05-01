height = 16
width = 16

outputFilePath = "topology.txt"
outFile = open(outputFilePath, "w")

port0_NodeID = width/2;
port1_NodeID = (height-1)*width + width/2 -1;
port2_NodeID = (height/2)*width-1;
port3_NodeID = ((height-1)/2)*width;
	
for row in range(0, height, 1):
	for column in range(0, width, 1):
		NodeID = row*width + column
		outString = str(NodeID)
		if ((NodeID == port0_NodeID) or (NodeID == port1_NodeID) or (NodeID == port2_NodeID) or (NodeID == port3_NodeID)):
			outString = "[" + outString + "]"
		outString += "\t"
		outFile.write(outString)
	outFile.write("\n\n")
	
outFile.close()
