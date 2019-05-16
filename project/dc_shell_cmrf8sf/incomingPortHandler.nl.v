
module incomingPortHandler ( clk, reset, localRouterAddress, 
        destinationAddressIn, requesterAddressIn, readIn, writeIn, 
        outputPortSelect, memRead, memWrite );
  input [5:0] localRouterAddress;
  input [13:0] destinationAddressIn;
  input [5:0] requesterAddressIn;
  output [3:0] outputPortSelect;
  input clk, reset, readIn, writeIn;
  output memRead, memWrite;
  wire   n41, n42, n43, n44, n45, n46, n74, n75, n76, n77, n78, n79, n80, n81,
         n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95,
         n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107,
         n108, n109, n110, n111, n112, n113, n114;

  DFFQX1TS \outputPortSelect_reg[3]  ( .D(n45), .CK(clk), .Q(
        outputPortSelect[3]) );
  DFFQX1TS \outputPortSelect_reg[2]  ( .D(n44), .CK(clk), .Q(
        outputPortSelect[2]) );
  DFFQX1TS \outputPortSelect_reg[1]  ( .D(n43), .CK(clk), .Q(
        outputPortSelect[1]) );
  DFFQX1TS \outputPortSelect_reg[0]  ( .D(n42), .CK(clk), .Q(
        outputPortSelect[0]) );
  DFFQX1TS memWrite_reg ( .D(n41), .CK(clk), .Q(memWrite) );
  DFFQX1TS memRead_reg ( .D(n46), .CK(clk), .Q(memRead) );
  INVX2TS U77 ( .A(n86), .Y(n100) );
  INVX2TS U78 ( .A(n84), .Y(n90) );
  INVX2TS U79 ( .A(n89), .Y(n91) );
  NAND2BXLTS U80 ( .AN(n109), .B(n95), .Y(n102) );
  NAND3BXLTS U81 ( .AN(n102), .B(n101), .C(n103), .Y(n104) );
  CLKBUFX2TS U82 ( .A(localRouterAddress[5]), .Y(n74) );
  CLKBUFX2TS U83 ( .A(destinationAddressIn[13]), .Y(n75) );
  NOR2BX1TS U84 ( .AN(n74), .B(n75), .Y(n107) );
  CLKBUFX2TS U85 ( .A(destinationAddressIn[11]), .Y(n76) );
  CLKBUFX2TS U86 ( .A(localRouterAddress[3]), .Y(n77) );
  NOR2BX1TS U87 ( .AN(n76), .B(n77), .Y(n94) );
  CLKBUFX2TS U88 ( .A(destinationAddressIn[12]), .Y(n78) );
  CLKBUFX2TS U89 ( .A(localRouterAddress[4]), .Y(n79) );
  NAND2BXLTS U90 ( .AN(n78), .B(n79), .Y(n92) );
  NAND2BXLTS U91 ( .AN(n79), .B(n78), .Y(n108) );
  NAND2BXLTS U92 ( .AN(n74), .B(n75), .Y(n112) );
  NAND2X1TS U93 ( .A(n108), .B(n112), .Y(n93) );
  AOI21X1TS U94 ( .A0(n94), .A1(n92), .B0(n93), .Y(n83) );
  CLKBUFX2TS U95 ( .A(readIn), .Y(n80) );
  CLKBUFX2TS U96 ( .A(writeIn), .Y(n81) );
  CLKBUFX2TS U97 ( .A(reset), .Y(n82) );
  AOI2BB1XLTS U98 ( .A0N(n80), .A1N(n81), .B0(n82), .Y(n101) );
  INVX2TS U99 ( .A(n101), .Y(n110) );
  NOR3XLTS U100 ( .A(n107), .B(n83), .C(n110), .Y(n43) );
  CLKBUFX2TS U101 ( .A(destinationAddressIn[9]), .Y(n84) );
  CLKBUFX2TS U102 ( .A(localRouterAddress[1]), .Y(n85) );
  CLKBUFX2TS U103 ( .A(destinationAddressIn[8]), .Y(n86) );
  CLKBUFX2TS U104 ( .A(localRouterAddress[0]), .Y(n87) );
  AOI22X1TS U105 ( .A0(n90), .A1(n85), .B0(n100), .B1(n87), .Y(n97) );
  CLKBUFX2TS U106 ( .A(localRouterAddress[2]), .Y(n88) );
  CLKBUFX2TS U107 ( .A(destinationAddressIn[10]), .Y(n89) );
  OAI22X1TS U108 ( .A0(n85), .A1(n90), .B0(n88), .B1(n91), .Y(n96) );
  NAND2X1TS U109 ( .A(n91), .B(n88), .Y(n98) );
  OA21XLTS U110 ( .A0(n97), .A1(n96), .B0(n98), .Y(n105) );
  NOR2BX1TS U111 ( .AN(n77), .B(n76), .Y(n109) );
  INVX2TS U112 ( .A(n92), .Y(n106) );
  NOR4XLTS U113 ( .A(n107), .B(n106), .C(n94), .D(n93), .Y(n95) );
  NOR3BXLTS U114 ( .AN(n97), .B(n102), .C(n96), .Y(n99) );
  OAI211XLTS U115 ( .A0(n87), .A1(n100), .B0(n99), .C0(n98), .Y(n103) );
  NOR2XLTS U116 ( .A(n105), .B(n104), .Y(n45) );
  NOR2XLTS U117 ( .A(n82), .B(n103), .Y(n114) );
  NOR3XLTS U118 ( .A(n82), .B(n80), .C(n81), .Y(n113) );
  AO22XLTS U119 ( .A0(n80), .A1(n114), .B0(memRead), .B1(n113), .Y(n46) );
  NOR2BX1TS U120 ( .AN(n105), .B(n104), .Y(n44) );
  AOI211XLTS U121 ( .A0(n109), .A1(n108), .B0(n107), .C0(n106), .Y(n111) );
  NOR3BXLTS U122 ( .AN(n112), .B(n111), .C(n110), .Y(n42) );
  AO22XLTS U123 ( .A0(n114), .A1(n81), .B0(n113), .B1(memWrite), .Y(n41) );
endmodule

