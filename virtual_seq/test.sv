class test extends uvm_test;

	`uvm_component_utils_begin(test)
	`uvm_component_utils_end

	env env1;
	// usequence seq1;
	// reset_sequence seq2;
	virtual intf_rst vif_rst;
	virtual_sequence vi_seq;

	int rst_th;

	function new(string name = "test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "BUILD PHASE OF TEST", UVM_NONE)
		env1 = env::type_id::create("env1", this);
		// uvm_config_db#(virtual intf_rst)::get(this, "", "RESET_INTF_KEY", vif_rst);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		// seq1 = usequence :: type_id :: create("seq1");
		// seq2 = reset_sequence :: type_id :: create("seq2");
		// seq2.start(env1.reset_agent1.reset_seqr1);
		// seq1.start(env1.agent1.seqr1);
		vi_seq = virtual_sequence :: type_id :: create("vi_seq");
		vi_seq.start(env1.vi_seqr);
		`uvm_info(get_type_name(), "VIRTUAL SEQR STARTED", UVM_NONE)
		
		// if(uvm_config_db#(int)::get(this, "", "RESET_TH_KEY", this.rst_th)) begin
		// 	vif_rst.rst_in = this.rst_th;
		// 	`uvm_info(get_type_name(), "RESET DEASSERTED AFTER 100 TX", UVM_NONE)
	    // end

		phase.drop_objection(this);
	endtask

endclass : test