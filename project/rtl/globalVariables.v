/*
This file contains all global macro definitions
*/

`define TRUE 1
`define FALSE 0

`define DATA_WIDTH 6

//Network globals
`define NETWORK_ROW_ADDRESS_WIDTH 2
`define NETWORK_COLUMN_ADDRESS_WIDTH 2
`define NETWORK_ADDRESS_WIDTH `NETWORK_ROW_ADDRESS_WIDTH+`NETWORK_COLUMN_ADDRESS_WIDTH

//Cache-bank globals
`define CACHE_BANK_ADDRESS_WIDTH 8
`define CACHE_BANK_LINES 8

//BUffer size and counter
`define BUFFER_SIZE 8
`define BIT_SIZE 3 //BUFFER_SIZE = 2^(BIT_SIZE)
