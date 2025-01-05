class subscriber extends uvm_subscriber #(usequence_item);


	usequence_item seq1;
  int count_seq;
	// uvm_analysis_imp #(usequence_item, subscriber) seq_mon;

  `uvm_component_utils(subscriber)

  covergroup add_cg();
     cg0 : coverpoint seq1.data1;
     cg1 : coverpoint seq1.data2;
     cg2 : coverpoint seq1.en_in{
     ignore_bins invalid[] = {1'b1};
     }
     cg3 : coverpoint seq1.control_in{
     ignore_bins invalid[] = {1'b0};
     }
     cg4 : coverpoint seq1.y_out{
     ignore_bins invalid[] = {5'b11111};
     }
     cg0xcg1xcg3 : cross cg0, cg1, cg3;
     cg3xcg4 : cross cg3, cg4;
  endgroup : add_cg


  covergroup sub_cg();
     sub_cg0 : coverpoint seq1.data1 {
       bins valid0 = {[0:15]};
     }
     sub_cg1 : coverpoint seq1.data2 {
       bins valid1 = {[0:15]};
     }
     sub_cg2 : coverpoint seq1.en_in {
       ignore_bins invalid[] = {1'b1};
     }
     sub_cg3 : coverpoint seq1.control_in;
     sub_cg4 : coverpoint seq1.y_out {
       ignore_bins invalid[] = {[16:31]};
     }

     // Use 'iff' for conditional cross coverage
     sub_cg5 : cross sub_cg0, sub_cg1  iff ((seq1.data1 >= seq1.data2)) {
        bins valid = binsof(sub_cg0.valid0) || binsof(sub_cg1.valid1);
     }

    sub_cg6 : cross sub_cg5,sub_cg3;

    sub_cg7 : cross sub_cg3, sub_cg4;

  endgroup : sub_cg

  // covergroup sub_cg();
  //    cg0 : coverpoint seq1.data1 {
  //    bins valid0 = {[0:15]};
  //    }
  //    cg1 : coverpoint seq1.data2{
  //    bins valid1 = {[0:15]};
  //    }
  //    cg2 : coverpoint seq1.en_in{
  //    ignore_bins invalid[] = {1'b1};
  //    }
  //    cg3 : coverpoint seq1.control_in{
  //    ignore_bins invalid[] = {1'b1};
  //    }
  //    cg4 : coverpoint seq1.y_out{
  //    ignore_bins invalid[] = {[16:31]};
  //    }
  //    cg5 : cross cg0, cg1
  //    {
  //     bins valid = binsof(cg0.valid0) with (seq1.data1> seq1.data2) || binsof(cg1.valid0) with (seq1.data1> seq1.data2) ;
  //    }

  // endgroup : sub_cg


  function new(string name = "subscriber", uvm_component parent=null);
    super.new(name, parent);
    add_cg = new();
    // sub_cg = new();
    this.count_seq = 0;
    // seq_mon = new("seq_mon", this);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF SUBSCRIBER ", UVM_HIGH)
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

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

  endtask

  function void write (usequence_item t);
  	`uvm_info(get_type_name(), "SUBSCRIBER GOT THE SEQ FROM MONITOR", UVM_HIGH)
  	seq1 = t;
    this.count_seq++;
    add_cg.sample();
    // sub_cg.sample();
    // if(this.add_cg.get_inst_coverage() == 100.00) begin
    //   `uvm_fatal("", $sformatf(" SEQ COUNT WHEN COVERAGE 100 = %0d ", this.count_seq))
    // end
    t.print();
    //`uvm_info(get_type_name(), $sformatf("DATA1 : %0d DATA2 : %0d  Y_OUT : %0d", seq.data1, seq1.data2 , seq1.y_out), UVM_HIGH)
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("", $sformatf(" ADDITION COVERAGE = %2.2f ", this.add_cg.get_inst_coverage()), UVM_NONE)
    // `uvm_info("", $sformatf(" SUBTRACTION COVERAGE = %2.2f ", this.sub_cg.get_inst_coverage()), UVM_NONE)
  endfunction : report_phase

endclass