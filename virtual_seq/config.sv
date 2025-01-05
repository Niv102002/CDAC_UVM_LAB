

class uconfig extends uvm_sequence_item;

	rand uvm_active_passive_enum is_active;

  `uvm_object_utils_begin(uconfig)
  	`uvm_field_enum (uvm_active_passive_enum, is_active, UVM_ALL_ON);
  `uvm_object_utils_end

//-------------------------------------------------------------------------------
// Functions and Tasks
//-------------------------------------------------------------------------------

  // Constructor
  function new(string name = "uconfig");
    super.new(name);
  endfunction
	
endclass : uconfig