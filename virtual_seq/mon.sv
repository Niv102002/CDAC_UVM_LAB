

class mon extends uvm_monitor ;

  parameter DATA_WIDTH = 4;  

  virtual intf #(.DATA_WIDTH(DATA_WIDTH)) vif;
  usequence_item seq;
  uvm_analysis_port #(usequence_item) seq_aport_mon2ss;
  int count_seq;
  `uvm_component_utils(mon)

  function new(string name = "mon", uvm_component parent=null);
    super.new(name, parent);
    seq_aport_mon2ss = new("seq_aport_mon2ss", this);
    this.count_seq = 0;
    `uvm_info(get_type_name(), "ANALYSIS PORT CREATED IN MONITOR", UVM_HIGH)
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF MONITOR ", UVM_HIGH)

    // uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this, "", "INTF_KEY", vif);

    if (uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this, "", "INTF_KEY", vif)) begin
    `uvm_info(get_type_name(), "RECIEVED VIF", UVM_HIGH)
    end else begin
    `uvm_info(get_type_name(), " NOT RECIEVED VIF", UVM_HIGH)
    end

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

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      if (vif.rst) begin
      seq = usequence_item::type_id::create("seq");
      monitor_data();
    end else begin
      `uvm_info(get_type_name(), "RESET IS HIGH ", UVM_HIGH)
      @(posedge vif.clk);
    end
  end

  endtask

 task monitor_data();
      @(posedge vif.clk);
      // `uvm_info(get_type_name(), "SEQ IS CREATED IN MON ", UVM_HIGH)
      if(vif.en_in) begin
      @(posedge vif.clk);
        seq.data1 =  vif.data1;
        seq.data2 =  vif.data2;
        seq.en_in =  vif.en_in;
        seq.control_in =  vif.control_in;
        seq.y_out =  vif.y_out;
        seq_aport_mon2ss.write(seq);
        count_seq++;
      end else begin
      `uvm_info(get_type_name(), "ENABLE IS LOW ", UVM_HIGH)
      end
 endtask 

 virtual function void report_phase(uvm_phase phase);
   super.report_phase(phase);
   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS SENT FROM MONITOR  :  %0d ", this.count_seq), UVM_NONE)
 endfunction : report_phase

endclass

    // repeat (5) begin
    //   seq = usequence_item :: type_id :: create("seq",this);
    //   void'(seq.randomize());
    //   `uvm_info(get_type_name(), " DATA SENT BY MONITOR TO SB AND SUB", UVM_HIGH)
    //   seq.print();
    //   seq_aport_mon2ss.write(seq);
    // end