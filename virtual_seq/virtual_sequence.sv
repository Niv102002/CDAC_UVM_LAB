class virtual_sequence extends uvm_sequence; // #(reset_sequence_item) ;

  reset_sequence rst_seq;
  usequence addr_seq;

  `uvm_object_utils_begin(virtual_sequence)
  `uvm_object_utils_end

  `uvm_declare_p_sequencer(virtual_sequencer)

  function new(string name = "virtual_sequence");
    super.new(name);
  endfunction

  task body();
    rst_seq = reset_sequence::type_id::create("rst_seq");
    addr_seq = usequence::type_id::create("addr_seq");
		`uvm_info(get_type_name(), "SEQUENCES CREATED IN VIRTUAL SEQUENCE", UVM_NONE)
  	rst_seq.start(p_sequencer.rst_seqr);
		`uvm_info(get_type_name(), "RESET SEQ STARTED", UVM_NONE)
  	addr_seq.start(p_sequencer.addr_seqr);
		`uvm_info(get_type_name(), "ADDER SEQ STARTED", UVM_NONE)
  endtask

endclass