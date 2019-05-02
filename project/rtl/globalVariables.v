/*
This file contains all global macro definitions
*/

`define TRUE 1
`define FALSE 0

`define DATA_WIDTH 32

//Network globals
`define NETWORK_ROW_ADDRESS_WIDTH 4
`define NETWORK_COLUMN_ADDRESS_WIDTH 4
`define NETWORK_ADDRESS_WIDTH `NETWORK_ROW_ADDRESS_WIDTH+`NETWORK_COLUMN_ADDRESS_WIDTH

`define NETWORK_HEIGHT 16  //cannot exceed 2^NETWORK_ROW_ADDRESS_WIDTH. Should be equal to said value for best access port placement
`define NETWORK_WIDTH 16  //cannot exceed 2^NETWORK_COLUMN_ADDRESS_WIDTH. Should be equal to said value for best access port placement 

//Cache-bank globals
`define CACHE_BANK_ADDRESS_WIDTH 8
`define CACHE_BANK_LINES 256

//BUffer size and counter
`define BUFFER_SIZE 8
`define BIT_SIZE 3 //BUFFER_SIZE = 2^(BIT_SIZE)
