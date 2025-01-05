class sub_test extends test;

	`uvm_component_utils_begin(sub_test)
	`uvm_component_utils_end

	// env env2;
	sub_usequence seq2;

	function new(string name = "sub_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "BUILD PHASE OF TEST", UVM_HIGH)
		// env2 = env::type_id::create("env2", this);
		seq2 = sub_usequence :: type_id :: create("seq2",this);
	endfunction

	task run_phase(uvm_phase phase);
		// super.run_phase(phase);   So that that test doesn't start
		phase.raise_objection(this);
		seq2.start(env1.agent1.seqr1);
		phase.drop_objection(this);
	endtask

endclass : sub_test