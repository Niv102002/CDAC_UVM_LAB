`timescale 1ns/1ps

module add_sub 
#(
	parameter DATA_WIDTH = 4
)
(		
	input logic 				   clk, 
	input logic 				   rst, 
	input logic 				   en_in,
	input logic					   control_in,
	input logic [DATA_WIDTH-1 : 0] data1,
	input logic [DATA_WIDTH-1 : 0] data2,
	output logic [DATA_WIDTH : 0]  y_out
);

always_ff @(posedge clk or negedge rst) begin 
	if(~rst) begin
		y_out <= 5'b0;   //reset output to zero
	end else begin
		if (en_in) begin
			y_out = (control_in) ? data1 + data2  // ADDITION OPERATION WHEN BOTH EN AND CONTROL ARE HIGH
								 : data1 - data2;  // SUBTRACTION OPERATION WHEN EN IS HIGH AND CONTROL IS LOW
		end
	end
end


endmodule : add_sub