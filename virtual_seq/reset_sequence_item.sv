class reset_sequence_item extends uvm_sequence_item ;

	rand bit rst_in;
	     logic rst_out;

  `uvm_object_utils_begin(reset_sequence_item)
    `uvm_field_int(rst_in , UVM_ALL_ON)
    `uvm_field_int(rst_out , UVM_ALL_ON )
  `uvm_object_utils_end

  // Constructor
  function new(string name = "reset_sequence_item");
    super.new(name);
    `uvm_info("", " SEQUENCE ITEM CALLED ", UVM_HIGH)
  endfunction

endclass