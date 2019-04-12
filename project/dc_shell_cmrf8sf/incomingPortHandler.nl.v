
module incomingPortHandler ( clk, reset, localRouterAddress, 
        destinationAddressIn, requesterAddressIn, readIn, writeIn, 
        outputPortSelect, memRead, memWrite );
  input [3:0] localRouterAddress;
  input [11:0] destinationAddressIn;
  input [3:0] requesterAddressIn;
  output [3:0] outputPortSelect;
  input clk, reset, readIn, writeIn;
  output memRead, memWrite;
  wire   n23, n24, n25, n26, n27, n28, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80;

  DFFQX1TS memRead_reg ( .D(n28), .CK(clk), .Q(memRead) );
  DFFQX1TS \outputPortSelect_reg[3]  ( .D(n27), .CK(clk), .Q(
        outputPortSelect[3]) );
  DFFQX1TS memWrite_reg ( .D(n23), .CK(clk), .Q(memWrite) );
  DFFQX1TS \outputPortSelect_reg[0]  ( .D(n24), .CK(clk), .Q(
        outputPortSelect[0]) );
  DFFQX1TS \outputPortSelect_reg[1]  ( .D(n25), .CK(clk), .Q(
        outputPortSelect[1]) );
  DFFQX1TS \outputPortSelect_reg[2]  ( .D(n26), .CK(clk), .Q(
        outputPortSelect[2]) );
  INVX2TS U49 ( .A(n49), .Y(n54) );
  INVX2TS U50 ( .A(n63), .Y(n66) );
  INVX2TS U51 ( .A(n52), .Y(n56) );
  OAI31X1TS U52 ( .A0(n67), .A1(n69), .A2(n65), .B0(n64), .Y(n26) );
  CLKBUFX2TS U53 ( .A(destinationAddressIn[9]), .Y(n46) );
  CLKBUFX2TS U54 ( .A(localRouterAddress[1]), .Y(n47) );
  NAND2BXLTS U55 ( .AN(n46), .B(n47), .Y(n59) );
  NOR2BX1TS U56 ( .AN(n46), .B(n47), .Y(n58) );
  CLKBUFX2TS U57 ( .A(destinationAddressIn[10]), .Y(n48) );
  CLKBUFX2TS U58 ( .A(localRouterAddress[2]), .Y(n49) );
  CLKBUFX2TS U59 ( .A(destinationAddressIn[11]), .Y(n50) );
  CLKBUFX2TS U60 ( .A(localRouterAddress[3]), .Y(n51) );
  NAND2BXLTS U61 ( .AN(n50), .B(n51), .Y(n72) );
  OAI21XLTS U62 ( .A0(n48), .A1(n54), .B0(n72), .Y(n77) );
  CLKBUFX2TS U63 ( .A(localRouterAddress[0]), .Y(n52) );
  CLKBUFX2TS U64 ( .A(destinationAddressIn[8]), .Y(n53) );
  CLKAND2X2TS U65 ( .A(n48), .B(n54), .Y(n73) );
  NOR2BX1TS U66 ( .AN(n50), .B(n51), .Y(n71) );
  AOI211XLTS U67 ( .A0(n56), .A1(n53), .B0(n73), .C0(n71), .Y(n55) );
  OAI21XLTS U68 ( .A0(n56), .A1(n53), .B0(n55), .Y(n57) );
  NOR4BXLTS U69 ( .AN(n59), .B(n58), .C(n77), .D(n57), .Y(n67) );
  NAND2BXLTS U70 ( .AN(n53), .B(n52), .Y(n60) );
  AOI21X1TS U71 ( .A0(n60), .A1(n59), .B0(n58), .Y(n69) );
  CLKBUFX2TS U72 ( .A(writeIn), .Y(n61) );
  CLKBUFX2TS U73 ( .A(readIn), .Y(n62) );
  CLKBUFX2TS U74 ( .A(reset), .Y(n63) );
  OAI21XLTS U75 ( .A0(n61), .A1(n62), .B0(n66), .Y(n75) );
  NOR2XLTS U76 ( .A(n71), .B(n75), .Y(n78) );
  NOR3BXLTS U77 ( .AN(n78), .B(n77), .C(n73), .Y(n70) );
  INVX2TS U78 ( .A(n70), .Y(n65) );
  OR3X1TS U79 ( .A(n63), .B(n61), .C(n62), .Y(n74) );
  INVX2TS U80 ( .A(n74), .Y(n68) );
  NAND2X1TS U81 ( .A(n68), .B(outputPortSelect[2]), .Y(n64) );
  CLKAND2X2TS U82 ( .A(n67), .B(n66), .Y(n80) );
  AO22XLTS U83 ( .A0(n62), .A1(n80), .B0(n68), .B1(memRead), .Y(n28) );
  AO22XLTS U84 ( .A0(n70), .A1(n69), .B0(n68), .B1(outputPortSelect[3]), .Y(
        n27) );
  AOI21X1TS U85 ( .A0(n73), .A1(n72), .B0(n71), .Y(n76) );
  INVX2TS U86 ( .A(n74), .Y(n79) );
  OAI2BB2XLTS U87 ( .B0(n76), .B1(n75), .A0N(n79), .A1N(outputPortSelect[1]), 
        .Y(n25) );
  AO22XLTS U88 ( .A0(outputPortSelect[0]), .A1(n79), .B0(n78), .B1(n77), .Y(
        n24) );
  AO22XLTS U89 ( .A0(n61), .A1(n80), .B0(n79), .B1(memWrite), .Y(n23) );
endmodule

