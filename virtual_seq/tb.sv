`include "uvm_macros.svh"
import uvm_pkg::*;

typedef class test;
typedef class sequencer;
typedef class usequence;
typedef class usequence_item;
typedef class env;
typedef class subscriber;
typedef class sb;
typedef class agent;
typedef class mon;
typedef class driver;
typedef class uconfig;

typedef class reset_agent;
typedef class reset_mon;
typedef class reset_driver;
typedef class reset_config;
typedef class reset_sequencer;
typedef class reset_sequence;
typedef class reset_sequence_item;

typedef class virtual_sequencer;
typedef class virtual_sequence;


`include "intf.sv"
`include "add_sub.sv"
`include "test.sv"
`include "env.sv"
`include "subscriber.sv"
`include "sb.sv"
`include "agent.sv"
`include "mon.sv"
`include "driver.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "sequence_item.sv"
`include "config.sv"

`include "reset_intf_rst.sv"
`include "reset_config.sv"
`include "reset_agent.sv"
`include "reset_mon.sv"
`include "reset_driver.sv"
`include "reset_sequencer.sv"
`include "reset_sequence.sv"
`include "reset_sequence_item.sv"

`include "virtual_sequencer.sv"
`include "virtual_sequence.sv"

module tb ();

	parameter DATA_WIDTH = 4;

	bit clk;

	// intf sig_as(clk,rst);

	always #40ns clk = ~clk; //25Mhz clk

	intf_rst vif_rst ();

	intf #(
			.DATA_WIDTH(DATA_WIDTH)
		) vif ();

	assign vif.rst = vif_rst.rst_in;
	assign vif.clk = clk;

	add_sub #(
			.DATA_WIDTH(DATA_WIDTH)
		) inst_add_sub (
			.clk        (vif.clk),
			.rst        (vif.rst),
			.en_in      (vif.en_in),
			.control_in (vif.control_in),
			.data1      (vif.data1),
			.data2      (vif.data2),
			.y_out      (vif.y_out)
		);

	initial begin
		uvm_config_db #(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::set(null, "uvm_test_top.env1.agent1.mon1", "INTF_KEY", vif);
		uvm_config_db #(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::set(null, "uvm_test_top.env1.agent1.drv1", "INTF_KEY", vif);
		uvm_config_db #(virtual intf_rst)::set(null, "uvm_test_top.env1.reset_agent1", "RESET_INTF_KEY", vif_rst);
		// uvm_config_db #(virtual intf_rst)::set(null, "uvm_test_top", "RESET_INTF_KEY", vif_rst);
		run_test("test");
	end

endmodule : tb