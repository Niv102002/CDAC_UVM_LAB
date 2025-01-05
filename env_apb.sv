class env_apb extends uvm_env;

	agent_master 	  agm1;
	agent_slave       ags1;
	virtual_sequencer vseqr;
	sb                sb1;
	subscriber        sub1;

  `uvm_component_utils(env_apb)

  function new(string name = "env_apb", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "BUILD PHASE IN ENVIRONMENT", UVM_NONE)

    agm1  = agent_master::type_id::create("agm1", this);
    ags1  = agent_slave::type_id::create("ags1", this);
    sb1  = sb::type_id::create("sb1", this);
    sub1  = subscriber::type_id::create("sub1", this);

    vseqr = virtual_sequencer::type_id::create("vseqr", this);

  endfunction

  function void connect_phase(uvm_phase phase);
  	super.connect_phase(phase);
  	
  endfunction : connect_phase

endclass