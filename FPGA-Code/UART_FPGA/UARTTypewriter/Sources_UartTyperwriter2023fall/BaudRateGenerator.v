//File Name: BaudRateGenerator.v
//Author: Jianjian Song
//Date: September 26, 2022
//ECE433 Fall 2022
//Inputs: Baud Rate in BaudRate, System Clock Frequency in ClockFrequency
//Output: uartClock, a clock that is 16 times faster than the uart bit speed
//-------------------------------------------------------------------

module BaudRateGenerator (
output reg  uartClock,
input Reset, clock,
input [19:0] BaudRate,  //up to 1,000,000
input [29:0] ClockFrequency); //up to 1GHz
 
reg [15:0] 	baud_count;

 always @(posedge clock)
      if(Reset==1) begin baud_count <= 1'b0;  uartClock <= 1'b1;
					end
		else if (baud_count == ClockFrequency/(BaudRate*16)) 
		begin
           		baud_count <= 1'b0;   uartClock <= 1'b1;
		end
       else
		begin
           		baud_count <= baud_count + 1'b1;
           		uartClock <= 1'b0;
      	end
endmodule
