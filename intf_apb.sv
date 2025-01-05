interface intf_apb (input logic clk, input logic rst);

	logic [31:0] paddr;
	logic        pselx;
	logic 		 penable;
	logic 		 pwrite;
	logic 		 pready;
	logic [31:0] pwdata;
	logic [31:0] prdata;
	logic 		 pslver;

	modport master (output paddr, pselx, penable, pwrite, pwdata, input pready, prdata, pslver, clk, rst);

	modport slave (input paddr, pselx, penable, pwrite, pwdata, clk, rst output pready, prdata, pslver);

endinterface : intf_apb