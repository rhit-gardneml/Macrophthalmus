`timescale 1ns / 1ps
//ECE433 Fall 2023
//Baud rate and clock frequency are defined in UARTmodule433fall2022.v
//Test UART module: 
//Baud Rate is 19200 defined and clock are defined in UARTmodule2020Fall.v
//System clock is 100MHz

module UartTyperwriter2023fall #(parameter DataLength=8)(
input clock, reset, rx, output tx,
output [DataLength-1:0] transmitted_bits);

// Signals for UART connections
reg read_from_uart, write_to_uart;
wire  	tx_full;
wire  	tx_half_full;
wire  	rx_data_present;
wire  	rx_full;
wire  	rx_half_full;
wire [DataLength-1:0] rx_data, tx_data;
reg [DataLength-1:0] databuffer;
//new data flag is used to transmit typed ASCII word once to display
reg newdata;
always@(posedge clock) begin
	if(reset==1) begin read_from_uart<=0; newdata<=0; databuffer<=0; end
	else if (rx_data_present==1) begin read_from_uart<=1;  newdata<=1; databuffer<=rx_data; end 
	else begin read_from_uart<=0; newdata<=0; databuffer<=0; end
    if(reset==1) begin write_to_uart<=0; end
	else if (newdata==1) begin write_to_uart<=1; newdata<=0; end
	else begin write_to_uart<=0; end
end

//module UARTmodule2023Fall #(parameter TRANSMITTED_BITS=8, BAUDRATE=20'd19200, FREQUENCY=30'd125000000) 
//(input  reset, clock, read_from_uart, write_to_uart, rx, 
//input [TRANSMITTED_BITS-1:0] tx_data,
//output  tx_full, rx_data_present, tx,
//output [TRANSMITTED_BITS-1:0] rx_data,
//output reg [TRANSMITTED_BITS-1:0] transmitted_bits);

//send receive data to transmitted data directly

UARTmodule2023Fall UARTunit(reset, clock, read_from_uart, write_to_uart, rx, 
databuffer, tx_full, rx_data_present,
tx, rx_data, transmitted_bits);

endmodule
