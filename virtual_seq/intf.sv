`ifndef INTF_
		`define INTF_

interface intf #(parameter DATA_WIDTH = 4) (input logic clk, logic rst);

	logic en_in;
	logic control_in;
	logic [DATA_WIDTH-1 : 0] data1;
	logic [DATA_WIDTH-1 : 0] data2;
	logic [DATA_WIDTH : 0]   y_out;


endinterface : intf

`endif
