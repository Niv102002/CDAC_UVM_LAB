class reset_sequencer extends uvm_sequencer #(reset_sequence_item) ;

  `uvm_component_utils_begin(reset_sequencer)
  `uvm_component_utils_end

  function new(string name = "reset_sequencer", uvm_component parent=null);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF reset_sequencer ", UVM_HIGH)
  endfunction



endclass