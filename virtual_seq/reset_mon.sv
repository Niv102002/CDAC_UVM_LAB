

class reset_mon extends uvm_monitor ;

  virtual intf_rst vif;
  reset_sequence_item seq;
  uvm_analysis_port #(reset_sequence_item) seq_aport_reset_mon2ss;
  int count_seq;
  reset_config config1;
  `uvm_component_utils(reset_mon)

  function new(string name = "reset_mon", uvm_component parent=null);
    super.new(name, parent);
    seq_aport_reset_mon2ss = new("seq_aport_reset_mon2ss", this);
    this.count_seq = 0;
    `uvm_info(get_type_name(), "ANALYSIS PORT CREATED IN reset_monITOR", UVM_NONE)
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF reset_monITOR ", UVM_NONE)

    // uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this, "", "INTF_KEY", vif);

    if (uvm_config_db#(virtual intf_rst)::get(this, "", "INT2D_KEY", vif)) begin
    `uvm_info(get_type_name(), "RECIEVED VIF IN reset_monITOR", UVM_NONE)
    end else begin
    `uvm_info(get_type_name(), " NOT RECIEVED VIF", UVM_NONE)
    end

    if (uvm_config_db#(reset_config)::get(this, "", "CONF1_RST_KEY", config1)) begin
    `uvm_info(get_type_name(), "RECIEVED CONF_RST_KEY IN reset_monitor", UVM_NONE)
      config1.print();
    end else begin
    `uvm_info(get_type_name(), " NOT RECIEVED CONF_RST_KEY", UVM_NONE)
    end

  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      // #10;
      #(config1.delay+1);
      seq = reset_sequence_item::type_id::create("seq");
      seq.rst_in = vif.rst_in;
      seq.rst_out = vif.rst_out;
      // seq_aport_reset_mon2ss.write(seq);
      // `uvm_info("", "reset_monITOR SENT DATA", UVM_NONE)
      // this.count_seq++;
      // seq.print();
    end
  endtask

 // virtual function void report_phase(uvm_phase phase);
 //   super.report_phase(phase);
 //   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS SENT FROM reset_monITOR  :  %0d ", this.count_seq), UVM_NONE)
 // endfunction : report_phase

endclass