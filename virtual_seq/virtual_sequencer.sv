class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

  reset_sequencer rst_seqr;
  sequencer addr_seqr;

  `uvm_component_utils(virtual_sequencer)
  //`uvm_component_utils_begin(virtual_sequence)
    /**** `uvm_field_* macro invocations here ****/
  //`uvm_component_utils_end

//-------------------------------------------------------------------------------
// Functions and Tasks
//-------------------------------------------------------------------------------

  // Constructor
  function new(string name = "virtual_sequencer", uvm_component parent=null);
    super.new(name, parent);
    // rst_seqr = reset_sequencer::type_id::create("rst_seqr");
    // addr_seqr = sequencer::type_id::create("addr_seqr");
  endfunction

endclass