class env extends uvm_env;

  `uvm_component_utils(env)
  //`uvm_component_utils_begin(env)
    /**** `uvm_field_* macro invocations here ****/
  //`uvm_component_utils_end

  // Constructor

  agent agent1;
  reset_agent reset_agent1;
  subscriber sub1;
  sb sb1;
  uconfig config1;
  reset_config config_rst;
  virtual_sequencer vi_seqr;

  function new(string name = "env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF ENVIRONMENT ", UVM_HIGH)
    agent1 = agent::type_id::create("agent1",this);
    sub1 = subscriber::type_id::create("sub1",this);
    sb1 = sb::type_id::create("sb1",this);
    config1 = uconfig ::type_id::create("config1");  
    config_rst = reset_config :: type_id :: create("config_rst");      //Check if this is correct

    reset_agent1 = reset_agent::type_id::create("reset_agent1",this);

    vi_seqr = virtual_sequencer::type_id::create("vi_seqr",this);


    // config1.is_active = UVM_ACTIVE;
    // ADD_SUB_CONFIG
    assert ( config1.randomize() with {is_active == UVM_ACTIVE;} );
    uvm_config_db#(uconfig)::set(null, "uvm_test_top.env1.agent1", "CONF_KEY", config1);

    // RESET CONFIG

    assert ( config_rst.randomize() with {is_active_rst == UVM_ACTIVE; delay == 2; } );
    uvm_config_db#(reset_config)::set(null, "uvm_test_top.env1.reset_agent1", "RESET_CONF_KEY", config_rst);
  endfunction

  function void connect_phase(uvm_phase phase);

  	super.connect_phase(phase);

  	agent1.mon1.seq_aport_mon2ss.connect(sub1.analysis_export);
  	agent1.mon1.seq_aport_mon2ss.connect(sb1.export_mon);
    agent1.drv1.rsp_port.connect(sb1.eport_drv);
    // reset_agent1.seq_aport_reset_mon2ss.connect()

    vi_seqr.rst_seqr = reset_agent1.reset_seqr1;
    vi_seqr.addr_seqr = agent1.seqr1;

  endfunction



endclass