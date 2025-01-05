class sequencer extends uvm_sequencer #(usequence_item) ;

  `uvm_component_utils(sequencer)

  function new(string name = "sequencer", uvm_component parent=null);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF SEQUENCER ", UVM_HIGH)
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    /**** Write body of this function ****/
  endfunction

  // end_of_elaboration
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    /**** Write body of this function ****/
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

  endtask


endclass