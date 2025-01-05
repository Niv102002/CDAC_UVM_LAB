class reset_agent extends uvm_agent ;

  `uvm_component_utils(reset_agent)

  reset_mon reset_mon1;
  reset_driver reset_drv1;
  reset_sequencer reset_seqr1;
  virtual intf_rst vif_rst;
  reset_config config1_rst;

  function new(string name = "reset_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF reset_agent ", UVM_NONE)
    
    // drv1 = reset_driver ::type_id::create("drv1", this);
    reset_mon1 = reset_mon ::type_id::create("reset_mon1", this);
    // seqr1 = reset_sequencer ::type_id::create("seqr1", this);
    // config1_rst = reset_config ::type_id::create("config1_rst", this);

    if (uvm_config_db#(virtual intf_rst)::get(this, "", "RESET_INTF_KEY",vif_rst)) begin    
      uvm_config_db#(virtual intf_rst)::set(null, "uvm_test_top.env1.reset_agent1.reset_drv1", "INT2D_KEY", this.vif_rst);
      uvm_config_db#(virtual intf_rst)::set(null, "uvm_test_top.env1.reset_agent1.reset_mon1", "INT2D_KEY", this.vif_rst);
      `uvm_info(get_type_name(), "RECEIVED VIF IN reset_agent", UVM_NONE)
    end else begin
      `uvm_info(get_type_name(), "VIF NOT RECIEVED", UVM_NONE)
    end
    
    if(uvm_config_db#(reset_config)::get(this, "", "RESET_CONF_KEY", config1_rst)) begin
      `uvm_info(get_type_name(), "RESET_CONF_KEY RECIEVED", UVM_NONE)
      uvm_config_db#(reset_config)::set(null, "uvm_test_top.env1.reset_agent1.reset_drv1", "CONF_RST_KEY", this.config1_rst);
      uvm_config_db#(reset_config)::set(null, "uvm_test_top.env1.reset_agent1.reset_mon1", "CONF1_RST_KEY", this.config1_rst);
    end else begin
      `uvm_info(get_type_name(), "RESET_CONF_KEY NOT RECIEVED", UVM_NONE)
    end
    
    config1_rst.print();
    if(config1_rst.is_active_rst == UVM_ACTIVE) begin
      reset_drv1 = reset_driver ::type_id::create("reset_drv1", this);
      reset_seqr1 = reset_sequencer ::type_id::create("reset_seqr1", this);
    end
    // config1_rst = reset_config ::type_id::create("config1_rst");
    // drv1.print();
    // seqr1.print();
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // reset_drv1.rsp_port.connect(reset_seqr1.rsp_export);
    if(config1_rst.is_active_rst == UVM_ACTIVE) begin
      reset_drv1.seq_item_port.connect(reset_seqr1.seq_item_export);
    end

  endfunction



endclass