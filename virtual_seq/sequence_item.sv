class usequence_item extends uvm_sequence_item ;

	rand logic [3:0] data1;
	rand logic [3:0] data2;
	rand logic       en_in;
	rand logic       control_in;
	     logic [4:0] y_out;

  constraint cons1 {
    (control_in == 0 ) -> (data1 >= data2);
  }


  // `uvm_object_utils(sequence_item)
  `uvm_object_utils_begin(usequence_item)
    `uvm_field_int(data1 , UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(data2 , UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(en_in , UVM_ALL_ON)
    `uvm_field_int(control_in , UVM_ALL_ON)
    `uvm_field_int(y_out , UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

//-------------------------------------------------------------------------------
// Functions and Tasks
//-------------------------------------------------------------------------------

  // Constructor
  function new(string name = "usequence_item");
    super.new(name);
    `uvm_info("", " SEQUENCE ITEM CALLED ", UVM_HIGH)
  endfunction

  // task print();
  //   $display("Queue contents:");
  //   foreach (this[i]) begin
  //     $display("Element %0d: %0d", i, this[i]);
  //   end
  // endtask
endclass