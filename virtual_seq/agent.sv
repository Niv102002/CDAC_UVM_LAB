class agent extends uvm_agent ;

  `uvm_component_utils(agent)

  mon mon1;
  driver drv1;
  sequencer seqr1;
  uconfig config1;

  function new(string name = "agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF AGENT ", UVM_HIGH)

    drv1 = driver ::type_id::create("drv1", this);
    seqr1 = sequencer ::type_id::create("seqr1", this);
    mon1 = mon ::type_id::create("mon1", this);
    
    if(uvm_config_db#(uconfig)::get(this, "", "CONF_KEY",config1)) begin
      `uvm_info(get_type_name(), "CONF_KEY RECIEVED", UVM_HIGH)
    end else begin
      `uvm_info(get_type_name(), "CONF_KEY NOT RECIEVED", UVM_HIGH)
    end
    
    // if(config1.is_active == UVM_ACTIVE) begin
    // end
    // config1 = uconfig ::type_id::create("config1");
    
    // drv1.print();
    // seqr1.print();
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // // drv1.rsp_port.connect(seqr1.rsp_export);
    // if(config1.is_active == UVM_ACTIVE) begin
      drv1.seq_item_port.connect(seqr1.seq_item_export);
    // end

  endfunction


endclass