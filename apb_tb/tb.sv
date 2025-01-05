`include "uvm_macros.svh"
import uvm_pkg::*;

typedef class test_apb;

`include "test_apb.sv"

module tb ();

	bit clk;
	bit rst;

	intf_apb vif(clk, rst);

	initial begin
		run_test("test");
	end

endmodule : tb