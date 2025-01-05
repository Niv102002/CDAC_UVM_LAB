class test extends uvm_test;

	env env1;
	virtual_sequence vseq;

	function new(string name = "test", uvm_component parent = null);
		super.new(name, parent);		
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase)
		`uvm_info(get_type_name(), "TESET BUILD PHASE", UVM_NONE)
			env1 = env::type_id::create("env1",this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		vseq = virtual_sequence::type_id::create("vseq");
		// vseq.
		phase.drop_objection(this);
	endtask

endclass