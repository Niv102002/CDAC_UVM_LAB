

class reset_config extends uvm_sequence_item;

	rand uvm_active_passive_enum is_active_rst;
  string timeunits;
  rand int delay;

  constraint delay_config {
    delay >= 0;
  }

  `uvm_object_utils_begin(reset_config)
  	`uvm_field_enum (uvm_active_passive_enum, is_active_rst, UVM_ALL_ON);
    `uvm_field_int(delay,UVM_ALL_ON)
  `uvm_object_utils_end

//-------------------------------------------------------------------------------
// Functions and Tasks
//-------------------------------------------------------------------------------

  // Constructor
  function new(string name = "reset_config");
    super.new(name);
    timeunits = "ns";
  endfunction
	
endclass : reset_config