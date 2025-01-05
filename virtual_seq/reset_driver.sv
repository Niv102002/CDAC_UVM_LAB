class reset_driver extends uvm_driver #(reset_sequence_item); 

	reset_sequence_item seq2;
  static int count_seq;

	virtual intf_rst vif;
  reset_config config1;

  `uvm_component_utils(reset_driver)

  function new(string name = "reset_driver", uvm_component parent=null);
    super.new(name, parent);
    this.count_seq = 0;
    // seq = reset_sequence_item :: type_id :: create("seq");
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF reset_driver ", UVM_NONE)

    //  uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this, "", "INTF_KEY", vif);
  
    if (uvm_config_db#(virtual intf_rst)::get(this, "", "INT2D_KEY", vif)) begin
    `uvm_info(get_type_name(), "RECIEVED VIF IN reset_driver", UVM_NONE)
    end else begin
    `uvm_info(get_type_name(), " NOT RECIEVED VIF", UVM_NONE)
    end

    if (uvm_config_db#(reset_config)::get(this, "", "CONF_RST_KEY", config1)) begin
    `uvm_info(get_type_name(), "RECIEVED CONF_RST_KEY IN reset_driver", UVM_NONE)
    end else begin
    `uvm_info(get_type_name(), " NOT RECIEVED CONF_RST_KEY", UVM_NONE)
    end

  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      // #10;
      #config1.delay;
      seq_item_port.get_next_item(seq2);
      vif.rst_in <= seq2.rst_in;
      seq2.rst_out = vif.rst_out;
      this.count_seq++;
      seq_item_port.item_done(seq2);
      seq_item_port.put_response(seq2);
      seq2.print();
      rsp_port.write(seq2);
      // `uvm_info("", "reset_driver SENT DATA ", UVM_NONE)
      // `uvm_info("", "reset_driver SENT DATA", UVM_NONE)
    end

  endtask

   virtual function void report_phase(uvm_phase phase);
   super.report_phase(phase);
   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS SENT FROM reset_driver  :  %0d ", this.count_seq), UVM_NONE)
   endfunction : report_phase


endclass
